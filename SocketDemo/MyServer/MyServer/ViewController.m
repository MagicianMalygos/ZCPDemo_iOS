//
//  ViewController.m
//  MyServer
//
//  Created by 朱超鹏 on 2018/10/24.
//  Copyright © 2018年 zcp. All rights reserved.
//

#import "ViewController.h"
#import "SocketDataModel.h"
#import "UserModel.h"
#import "MessageModel.h"
#import "ServiceProtocol.h"

#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

/**
 1.
 int bind( SOCKET sockaddr, const struct sockaddr * my_addr, int addrlen)
 将一本地地址与一套接口捆绑。
 
 sockaddr: 标识一未捆绑套接口的描述字。
 my_addr: 赋予套接口的地址
 addrlen: my_addr的长度
 返回值：成功0 失败-1
 
 2.
 int listen(SOCKET sockfd, int backlog)
 让一个套接字处于监听到来的连接请求的状态
 
 sockfd 一个已绑定未被连接的套接字描述符
 backlog 连接请求队列(queue of pending connections)
 返回值：无错误，返回0，否则，返回SOCKET ERROR
 */

/// 最大连接数
static int const kMaxConnectCount = 5;

@interface ViewController () <ServerProtocol>

@property (nonatomic, strong) NSMutableDictionary *clientMap;
@property (nonatomic, strong) NSMutableArray *clientArray;

@property (nonatomic, strong) NSMutableArray *clientNameArray;

@property (unsafe_unretained) IBOutlet NSTextView *logView;

@property (nonatomic, assign) int server_socket;

@end

@implementation ViewController

// ----------------------------------------------------------------------
#pragma mark - life cycle
// ----------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 开启服务
    [self startServer];
}

// ----------------------------------------------------------------------
#pragma mark - socket
// ----------------------------------------------------------------------

- (void)startServer {
    // 创建socket
    int server_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (server_socket == -1) {
        [self log:@"socket创建失败"];
        return;
    }
    [self log:[NSString stringWithFormat:@"socket创建成功 socket:%d", server_socket]];
    
    // 绑定地址和端口
    int port        = 1234;
    char *address   = "127.0.0.1";
    struct sockaddr_in server_addr;
    server_addr.sin_len         = sizeof(struct sockaddr_in);
    server_addr.sin_family      = AF_INET;
    server_addr.sin_port        = htons(port);
    server_addr.sin_addr.s_addr = inet_addr(address);
    bzero(&(server_addr.sin_zero), 8);
    
    // 绑定端口
    int bind_result = bind(server_socket, (struct sockaddr *)&server_addr, server_addr.sin_len);
    if (bind_result == -1) {
        [self log:[NSString stringWithFormat:@"端口绑定失败 code:%d", errno]];
        return;
    }
    [self log:[NSString stringWithFormat:@"端口绑定成功 地址：%s 端口号：%d", address, port]];
    
    // 使socket处于监听状态
    int listen_result = listen(server_socket, kMaxConnectCount);
    if (listen_result == -1) {
        [self log:@"开启监听失败"];
        return;
    }
    [self log:@"已成功开启监听"];
    
    self.server_socket = server_socket;
    for (int i = 0; i < kMaxConnectCount; i++) {
        [self acceptClient];
    }
    [self log:[NSString stringWithFormat:@"开始接收客户端接入，最大连接数：%d", kMaxConnectCount]];
}

/// 创建线程接受客户端接入
- (void)acceptClient {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        struct sockaddr_in client_address;
        socklen_t address_len;
        
        while (1) {
            int client_socket = accept(self.server_socket, (struct sockaddr *)&client_address, &address_len);
            if (client_socket == -1) {
                [self log:@"客户端连接失败"];
            } else {
                [self log:[NSString stringWithFormat:@"客户端连接成功。socket:%d", client_socket]];
                
                // 初始化用户
                [self setupUser:client_socket];
                // 给所有客户端发送消息
                [self updateUserList];
                // 接收客户端数据
                [self receiveFromClientWithSocket:client_socket];
            }
        }
    });
}

- (void)receiveFromClientWithSocket:(int)client_socket {
    while (1) {
        char buf[1024] = {0};
        ssize_t buflen = recv(client_socket, buf, 1024, 0);
        
        if (buflen > 0) {
            [self log:@"接收到客户端的消息"];
            NSData *data = [NSData dataWithBytes:buf length:buflen];
            [self parseData:data];
        } else if (buflen == 0) {
            [self log:[NSString stringWithFormat:@"socket %d关闭", client_socket]];
            
            UserModel *userModel = self.clientMap[[@(client_socket) stringValue]];
            [self.clientMap removeObjectForKey:[@(client_socket) stringValue]];
            [self.clientArray removeObject:userModel];
            
            close(client_socket);
            [self acceptClient];
            break;
        }
    }
}

- (void)sendSocketData:(SocketDataModel *)model {
    NSData *data = model.dataValue;
    
    const char *d = [data bytes];
    // send函数发送数据给服务端
    ssize_t r = send(model.socket, d, strlen(d), 0);
    
    if (r > 0) {
        NSLog(@"发送成功");
    } else {
        NSLog(@"发送失败 code:%d", errno);
    }
}

- (void)parseData:(NSData *)data {
    SocketDataModel *model = [[SocketDataModel alloc] initWithData:data];
    
    if (!model) {
        return;
    }
    
    SEL sel = NSSelectorFromString(model.method);
    [self performSelector:sel withObject:model.body];
}

// ----------------------------------------------------------------------
#pragma mark - ServerProtocol
// ----------------------------------------------------------------------

- (void)api_changeUserName:(NSString *)body {
    // 修改信息
    // 给所有在线用户发送list
}

- (void)api_sendMessage:(NSString *)body {
    // 给指定用户发送消息
    NSData *jsonData = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    MessageModel *message = [[MessageModel alloc] initWithDict:dict];
    
    
    // 判断用户是否还在线
    if (![self.clientMap.allKeys containsObject:[@(message.target) stringValue]]) {
        NSLog(@"%d已离线无法接收消息", message.target);
        return;
    }
    
    UserModel *sender = self.clientMap[[@(message.sender) stringValue]];
    UserModel *target = self.clientMap[[@(message.target) stringValue]];
    NSLog(@"%@ 发送给 %@：%@", sender.name, target.name, message.content);
    
    SocketDataModel *model = [[SocketDataModel alloc] init];
    model.socket = target.userId;
    model.method = NSStringFromSelector(@selector(callback_receiveMessage:));
    model.body = body;
    
    [self sendSocketData:model];
}

// ----------------------------------------------------------------------
#pragma mark - private
// ----------------------------------------------------------------------

- (void)setupUser:(int)client_socket {
    UserModel *user = [UserModel new];
    user.userId = client_socket;
    user.name = [NSString stringWithFormat:@"用户%d", client_socket];
    [self.clientMap setObject:user forKey:[@(client_socket) stringValue]];
    [self.clientArray addObject:user];
    
    NSData *userData = [NSJSONSerialization dataWithJSONObject:user.dictionaryValue options:kNilOptions error:nil];
    NSString *json = [[NSString alloc] initWithData:userData encoding:NSUTF8StringEncoding];
    
    SocketDataModel *model = [[SocketDataModel alloc] init];
    model.socket = client_socket;
    model.method = NSStringFromSelector(@selector(callback_login:));
    model.body = json;
    [self sendSocketData:model];
}

- (void)updateUserList {
    // 模型转字典
    NSMutableArray *arr = [NSMutableArray array];
    for (UserModel *userModel in self.clientArray) {
        NSDictionary *userDict = [userModel dictionaryValue];
        [arr addObject:userDict];
    }
    NSDictionary *dict = @{@"list": arr};
    
    // 字典转json
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:nil];
    NSString *body = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    // 给所有用户发送数据
    for (UserModel *userModel in self.clientArray) {
        // 生成socket模型
        SocketDataModel *model = [SocketDataModel new];
        model.socket = userModel.userId;
        model.method = NSStringFromSelector(@selector(callback_updateUserList:));
        model.body = body;
        
        [self sendSocketData:model];
    }
}

- (void)log:(NSString *)log {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.logView.string = [NSString stringWithFormat:@"%@\n%@", self.logView.string, log];
    });
}

// ----------------------------------------------------------------------
#pragma mark - getters and setters
// ----------------------------------------------------------------------

- (NSMutableDictionary *)clientMap {
    if (!_clientMap) {
        _clientMap = [NSMutableDictionary dictionary];
    }
    return _clientMap;
}

- (NSMutableArray *)clientArray {
    if (!_clientArray) {
        _clientArray = [NSMutableArray array];
    }
    return _clientArray;
}

- (NSMutableArray *)clientNameArray {
    if (!_clientNameArray) {
        _clientNameArray = [NSMutableArray array];
    }
    return _clientNameArray;
}

@end
