//
//  ViewController.m
//  MyClient
//
//  Created by 朱超鹏 on 2018/10/24.
//  Copyright © 2018年 zcp. All rights reserved.
//


/**
 
 1.
 int socket(int domain, int type, int protocol);
 分配一个套接口的描述字及其所用的资源
 domain：协议域，又称协议族（family）。常用的协议族有AF_INET、AF_INET6、AF_LOCAL（或称AF_UNIX，Unix域Socket）、AF_ROUTE等。协议族决定了socket的地址类型，在通信中必须采用对应的地址，如AF_INET决定了要用ipv4地址（32位的）与端口号（16位的）的组合、AF_UNIX决定了要用一个绝对路径名作为地址。（见socket.h中"Address families"）
 type：指定Socket类型。常用的socket类型有SOCK_STREAM、SOCK_DGRAM、SOCK_RAW、SOCK_PACKET、SOCK_SEQPACKET等。流式Socket（SOCK_STREAM）是一种面向连接的Socket，针对于面向连接的TCP服务应用。数据报式Socket（SOCK_DGRAM）是一种无连接的Socket，对应于无连接的UDP服务应用。（见socket.h中"Types"）
 protocol：指定协议。常用协议有IPPROTO_TCP、IPPROTO_UDP、IPPROTO_STCP、IPPROTO_TIPC等，分别对应TCP传输协议、UDP传输协议、STCP传输协议、TIPC传输协议。type和protocol不可以随意组合，如SOCK_STREAM不可以跟IPPROTO_UDP组合。当第三个参数为0时，会自动选择第二个参数类型对应的默认协议。
 返回值：如果调用成功就返回新创建的套接字的描述符，如果失败就返回INVALID_SOCKET（Linux下失败返回-1）
 
 协议簇：ipv4、ipv6、unix
    AF_INET（又称 PF_INET）是 IPv4 网络协议的套接字类型。目的就是使用 IPv4 进行通信。因为 IPv4 使用 32 位地址，相比 IPv6 的 128 位来说，计算更快，便于用于局域网通信。
    AF_INET6 则是 IPv6 的
    AF_UNIX 则是 Unix 系统本地通信。AF_INET相比 AF_UNIX 更具通用性，因为 Windows 上有 AF_INET 而没有 AF_UNIX
 
 类型：tcp、udp
    SOCK_STREAM 提供有序的、可靠的、双向的和基于连接的字节流，使用带外数据传送机制，为Internet地址族使用TCP。
    SOCK_DGRAM 支持无连接的、不可靠的和使用固定大小（通常很小）缓冲区的数据报服务，为Internet地址族使用UDP。
 
 2.
 bzero(void*, size_t) 将数组的前n个字符置空，设置为'\0'
 
 3.
 int connect(SOCKET s, const struct sockaddr * name, int namelen)
 建立与指定socket的连接。
 s：标识一个未连接socket
 name：指向要连接套接字的sockaddr结构体的指针
 namelen：sockaddr结构体的字节长度
 返回值：成功则返回0, 失败返回-1，错误原因存于errno 中（<sys/errno.h>）
 
 4.
 int recv( SOCKET s, char *buf, int len, int flags)
 用于已连接的数据报或流式套接口进行数据的接收。
 
 s：指定接收端套接字描述符
 buf：指明一个缓冲区，该缓冲区用来存放recv函数接收到的数据；
 len：指明buf的长度；
 flags：一般置为0。
 返回值：recv函数返回其实际copy的字节数。如果recv在copy时出错，那么它返回SOCKET_ERROR；如果recv函数在等待协议接收数据时网络中断了，那么它返回0。
 
    EAGAIN：套接字已标记为非阻塞，而接收操作被阻塞或者接收超时。对非阻塞socket而言，EAGAIN不是一种错误。在VxWorks和Windows上，EAGAIN的名字叫EWOULDBLOCK。
    EBADF：sock不是有效的描述词
    ECONNREFUSE：远程主机阻绝网络连接
    EFAULT：内存空间访问出错
    EINTR：操作被信号中断
    EINVAL：参数无效
    ENOMEM：内存不足
    ENOTCONN：与面向连接关联的套接字尚未被连接上
    ENOTSOCK：sock索引的不是套接字
    ...
 
 5.
 Socket阻塞，非阻塞。使用socket函数创建socket时默认是阻塞的。
 
 阻塞就是干不完不准回来，
 非组赛就是你先干，我现看看有其他事没有，完了告诉我一声
 
 我们拿最常用的send和recv两个函数来说吧...
 比如你调用send函数发送一定的Byte,在系统内部send做的工作其实只是把数据传输(Copy)到TCP/IP协议栈的输出缓冲区,它执行成功并不代表数据已经成功的发送出去了,如果TCP/IP协议栈没有足够的可用缓冲区来保存你Copy过来的数据的话...这时候就体现出阻塞和非阻塞的不同之处了:对于阻塞模式的socket send函数将不返回直到系统缓冲区有足够的空间把你要发送的数据Copy过去以后才返回,而对于非阻塞的socket来说send会立即返回WSAEWOULDDBLOCK告诉调用者说:"发送操作被阻塞了!!!你想办法处理吧..."
 对于recv函数,同样道理,该函数的内部工作机制其实是在等待TCP/IP协议栈的接收缓冲区通知它说:嗨,你的数据来了.对于阻塞模式的socket来说如果TCP/IP协议栈的接收缓冲区没有通知一个结果给它它就一直不返回:耗费着系统资源....对于非阻塞模式的socket该函数会马上返回,然后告诉你:WSAEWOULDDBLOCK---"现在没有数据,回头在来看看"
 
 6.
 int send( SOCKET s, const char * buf, int len, int flags);
 向一个已经连接的socket发送数据
 
 s：一个用于标识已连接套接口的描述字。
 buf：包含待发送数据的缓冲区。
 len：缓冲区中数据的长度。
 flags：调用执行方式。
 返回值：如果无错误，返回值为所发送数据的总数，否则返回SOCKET_ERROR。

 
 */

#import "ViewController.h"
#import "MessageModel.h"
#import "SocketDataModel.h"
#import "UserModel.h"
#import "ServiceProtocol.h"

// socket相关函数
#import <sys/socket.h>
// socket地址结构体
#import <netinet/in.h>
// 地址结构体
#import <arpa/inet.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, ClientProtocol>

/// 好友列表
@property (weak, nonatomic) IBOutlet UITableView *friendTableView;
/// 用户名输入框
@property (weak, nonatomic) IBOutlet UITextField *nameInputView;
/// 聊天信息内容
@property (weak, nonatomic) IBOutlet UITextView *chatTextView;
/// 消息输入框
@property (weak, nonatomic) IBOutlet UITextField *messageInputView;
/// 目标名字
@property (weak, nonatomic) IBOutlet UILabel *targetNameLabel;
/// 目标id
@property (nonatomic, assign) int targetId;

/// 当前用户信息
@property (nonatomic, strong) UserModel *currUserModel;

/// 用户列表
@property (nonatomic, strong) NSMutableArray *userArray;
/// 服务器socket
@property (nonatomic, assign) int server_socket;

@end

@implementation ViewController

// ----------------------------------------------------------------------
#pragma mark - life cycle
// ----------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.friendTableView.dataSource = self;
    self.friendTableView.delegate = self;
    
    // 登录，建立连接
    [self login];
}

// ----------------------------------------------------------------------
#pragma mark - socket
// ----------------------------------------------------------------------

- (void)login {
    // 创建socket
    int server_socket = socket(AF_INET, SOCK_STREAM, 0);
    if (server_socket == -1) {
        [self log:@"创建socket失败"];
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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 建立连接，当服务端开启时，连接才会成功
        int connectResult = connect(server_socket, (struct sockaddr *)&server_addr, server_addr.sin_len);
        if (connectResult == -1) {
            [self log:[NSString stringWithFormat:@"连接服务器失败 code:%d", errno]];
        } else {
            [self log:[NSString stringWithFormat:@"已连接到服务器 地址：%s 端口：%d", address, port]];
            self.server_socket = server_socket;
            [self startReceiveDataFromServer];
        }
    });
}

/// 接收服务端发来的消息
- (void)startReceiveDataFromServer {
    while (1) {
        char buf[1024];
        // 此处如果没有收到数据则不会返回
        struct sockaddr_in sockaddr4;
        socklen_t sockaddr4len = sizeof(sockaddr4);
        
        ssize_t buflen = recvfrom(self.server_socket, buf, 1024, 0, (struct sockaddr *)&sockaddr4, &sockaddr4len);
        
        if (buflen > 0) {
            [self log:@"获取到了数据"];
            NSData *data = [NSData dataWithBytes:buf length:buflen];
            [self parseData:data];
            
        } else if ((buflen < 0) && (errno == EAGAIN || errno == EWOULDBLOCK || errno == EINTR)) {
            [self log:@"暂时没有数据，可能等下就有了..."];
        } else if (buflen == 0) {
            [self log:@"另一端关闭了socket"];
            break;
        } else if (buflen == -1) {
            [self log:@"recv函数错误"];
            break;
        } else {
            [self log:[NSString stringWithFormat:@"recv函数错误 code:%d", errno]];
            break;
        }
    }
}

- (void)sendSocketData:(SocketDataModel *)model {
    NSData *data = model.dataValue;
    
    const char *d = [data bytes];
    // send函数发送数据给服务端
    ssize_t r = send(self.server_socket, d, strlen(d), 0);
    
    if (r > 0) {
        [self log:@"发送成功"];
    } else {
        [self log:[NSString stringWithFormat:@"发送失败 code:%d", errno]];
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
#pragma mark - api
// ----------------------------------------------------------------------

/// 修改用户名
- (void)changeUserName:(NSString *)newUserName {
    if (newUserName.length == 0) {
        return;
    }
    
    SocketDataModel *model = [[SocketDataModel alloc] init];
    model.method = NSStringFromSelector(@selector(api_changeUserName:));
    NSDictionary *contentDict = @{@"newName": newUserName};
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:contentDict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    model.body = jsonString;
    
    [self sendSocketData:model];
}

/// 发送消息给指定用户
- (void)sendMessage:(NSString *)message toTarget:(int)target {
    MessageModel *model = [MessageModel new];
    model.target = target;
    model.sender = self.currUserModel.userId;
    model.content = message;
    [self sendMessageModel:model];
}

- (void)sendMessageModel:(MessageModel *)messageModel {
    SocketDataModel *model = [[SocketDataModel alloc] init];
    model.method = NSStringFromSelector(@selector(api_sendMessage:));
    NSDictionary *contentDict = [messageModel dictionaryValue];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:contentDict options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    model.body = jsonString;
    
    [self sendSocketData:model];
}

// ----------------------------------------------------------------------
#pragma mark - ClientProtocol
// ----------------------------------------------------------------------

- (void)callback_login:(NSString *)body {
    // 解析body数据
    NSData *jsonData = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    UserModel *userModel = [[UserModel alloc] initWithDict:dict];
    self.currUserModel = userModel;
}

- (void)callback_updateUserList:(NSString *)body {
    // 解析body数据
    NSData *jsonData = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    
    NSDictionary *arr = [dict objectForKey:@"list"];
    NSMutableArray *userArr = [NSMutableArray array];
    NSString *targetName = @"";
    
    // 字典转用户模型
    for (NSDictionary *userDict in arr) {
        UserModel *userModel = [[UserModel alloc] initWithDict:userDict];
        [userArr addObject:userModel];
        
        // 如果有当前选中的用户，则更新名字
        if (userModel.userId == self.targetId) {
            targetName = userModel.name;
        }
    }
    self.userArray = userArr;
    
    // 如果没有找到选中的用户，初始化id
    if (targetName.length == 0) {
        self.targetId = 0;
    }
    
    // 更新用户列表数据
    dispatch_async(dispatch_get_main_queue(), ^{
        self.targetNameLabel.text = targetName;
        [self.friendTableView reloadData];
    });
}

- (void)callback_receiveMessage:(NSString *)body {
    NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    MessageModel *model = [[MessageModel alloc] initWithDict:jsonDict];
    
    // show message
    [self log:[NSString stringWithFormat:@"收到了来自%d的消息：%@", model.sender, model.content]];
}

// ----------------------------------------------------------------------
#pragma mark - action
// ----------------------------------------------------------------------
- (IBAction)clickChangeUserNameButton {
    // 设置用户名
    NSString *userName = self.nameInputView.text;
    if (userName.length == 0) {
        return;
    }
    userName = [NSString stringWithFormat:@"name:%@", userName];
    
    [self changeUserName:userName];
}

- (IBAction)clickSendMessageButton {
    // 发送消息
    NSString *message = self.messageInputView.text;
    if (message.length == 0) {
        return;
    }
    
    [self sendMessage:message toTarget:self.targetId];
    self.messageInputView.text = @"";
}

// ----------------------------------------------------------------------
#pragma mark - private
// ----------------------------------------------------------------------

- (void)log:(NSString *)log {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.chatTextView.text = [NSString stringWithFormat:@"%@\n%@", self.chatTextView.text, log];
    });
}

// ----------------------------------------------------------------------
#pragma mark - tableview
// ----------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    UserModel *userModel = self.userArray[indexPath.row];
    cell.textLabel.text = userModel.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 如果点击的是自己，不处理
    UserModel *userModel = self.userArray[indexPath.row];
    if (self.currUserModel.userId == userModel.userId) {
        return;
    }
    self.targetId               = userModel.userId;
    self.targetNameLabel.text   = userModel.name;
}

// ----------------------------------------------------------------------
#pragma mark - getters and setters
// ----------------------------------------------------------------------
- (NSMutableArray *)userArray {
    if (!_userArray) {
        _userArray = [NSMutableArray array];
    }
    return _userArray;
}

@end
