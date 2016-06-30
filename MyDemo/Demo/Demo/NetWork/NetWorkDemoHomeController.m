
//
//  NetWorkDemoHomeController.m
//  Demo
//
//  Created by apple on 16/6/6.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "NetWorkDemoHomeController.h"
#import "ZCPURLConnectionTool.h"
#import "ZCPURLSessionTool.h"
#import "ZCPAFNetworkingTool.h"

@interface NetWorkDemoHomeController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *infoArray;

@end

@implementation NetWorkDemoHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - getter / setter
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT - 64)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}
- (NSArray *)infoArray {
    if (_infoArray == nil) {
        _infoArray = @[@{@"info": @"get异步 Connection", @"sel": @"getRequest_Asynchronous_Connection", @"type": @"connection"}
                       , @{@"info": @"post异步 Connection", @"sel": @"postRequest_Asynchronous_Connection", @"type": @"connection"}
                       , @{@"info": @"下载 Connection", @"sel": @"uploadRequest_Connection", @"type": @"connection"}
                       
                       , @{@"info": @"get同步 Session", @"sel": @"getRequest_Synchronouos_Session", @"type": @"session"}
                       , @{@"info": @"post异步 Session", @"sel": @"postRequest_Asynchronous_Session", @"type": @"session"}
                       
                       , @{@"info": @"get异步 AF", @"sel": @"getRequest_Asynchronous_AF", @"type": @"AF"}
                       , @{@"info": @"post异步 AF", @"sel": @"postRequest_Asynchronous_AF", @"type": @"AF"}
                       , @{@"info": @"上传 AF", @"sel": @"uploadRequest_AF", @"type": @"AF"}
                       , @{@"info": @"下载 AF", @"sel": @"downloadRequest_AF", @"type": @"AF"}
                       , @{@"info": @"测试", @"sel": @"test", @"type": @"self"}
                       ];
    }
    return _infoArray;
}

#pragma mark - UITableView DataSource&Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.infoArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [[self.infoArray objectAtIndex:indexPath.row] valueForKey:@"info"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SEL method = NSSelectorFromString([[self.infoArray objectAtIndex:indexPath.row] valueForKey:@"sel"]);
    
    NSObject *object = nil;
    NSString *type = [[self.infoArray objectAtIndex:indexPath.row] valueForKey:@"type"];
    if ([type isEqualToString:@"connection"]) {
        object = [ZCPURLConnectionTool new];
    } else if ([type isEqualToString:@"session"]) {
        object = [ZCPURLSessionTool new];
    } else if ([type isEqualToString:@"AF"]) {
        object = [ZCPAFNetworkingTool new];
    } else if ([type isEqualToString:@"self"]) {
        object = self;
    }
    
    if ([object respondsToSelector:method]) {
        [object performSelector:method];
    }
}

#pragma mark - test
- (void)test {
    // 1. url中不能有中文
    NSString *urlStr1 = @"http://www.weather.com.cn/data/sk/101010100.html?username=1001&pwd=abc123";
    NSString *urlStr2 = @"http://www.weather.com.cn/data/sk/101010100.html?username=朱超鹏&pwd=abc123";
    // 如果参数有中文需要转码
    NSString *transformURLStr2 = [urlStr2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:urlStr1];
    NSURL *url2 = [NSURL URLWithString:urlStr2];
    NSURL *url3 = [NSURL URLWithString:transformURLStr2];
    NSLog(@"URL1: %@, URL2: %@, URL3: %@", url1, url2, url3);
    
    // 2. 添加http头信息
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url3];
    [request setValue:@"ios" forHTTPHeaderField:@"User-Agent"];
    
    // 3.任何NSURLRequest默认都是get请求
    
}

@end
