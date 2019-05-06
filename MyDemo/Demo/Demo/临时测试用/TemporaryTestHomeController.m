//
//  TemporaryTestHomeController.m
//  Demo
//
//  Created by 朱超鹏 on 17/4/28.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "TemporaryTestHomeController.h"
#import <IQKeyboardManager.h>
#import <IQKeyboardReturnKeyHandler.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Masonry.h>
#import <ZCPCommentView.h>

#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>

#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"



@interface TemporaryTestHomeController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) NSMutableDictionary *headerDict;
@property (nonatomic, strong) IQKeyboardReturnKeyHandler *returnKeyHandler;
@property (nonatomic, strong) NSArray *directorys;
@property (nonatomic, copy) NSString *path;

@property (nonatomic, assign) NSInteger count;

@end

@implementation TemporaryTestHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Test
    [self testXXX]; // 范例
//    [self testAutoreleasepool];
//    [self testGetImageFromView];
//    [self testIQKeyboardManagerReturn];
//    [self testSandBoxPath];
//    [self testSettings];
    [self testBlock];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isMovingToParentViewController) {
        NSLog(@"首次进入");
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.isMovingFromParentViewController) {
        NSLog(@"退出");
    }
}

#pragma mark - test

// 测试XXX
- (void)testXXX {
}

#pragma mark - testAutoreleasepool

- (void)testAutoreleasepool {
    /*
     @autoreleasepool实际上就是下面两句话，作用是其内包含的所有调用autorelease的对象在出这个作用域后都会执行一次release
     
     void * atautoreleasepoolobj = objc_autoreleasePoolPush();
     // Do something
     objc_autoreleasePoolPop(atautoreleasepoolobj);
     
     会创建一个pool，然后将nil(atautoreleasepoolobj)入栈，后面所有调用autorelease的对象都会放到这个pool中，
     objc_autoreleasePoolPop这句代码会让里面所有的对象都执行一次release
     */
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"rocket.png"];
    [path description];
    
    // 内存暴增
    // 这种情况下image的释放归main函数中的@autoreleasepool {}管，下面的while循环会使得main runloop一直无法走下一次事件循环，因此也无法执行到objc_autoreleasePoolPop(atautoreleasepoolobj)这句代码，让其中的image对象执行release
//    NSArray *list = @[@"1"];
    while (1) {
        // object 不会暴增
//        NSObject *obj = [[NSObject alloc] init];
//        [obj description];
        
        // list 会暴增
//        id arr = [NSArray array];
//        id arr = [NSMutableArray new];
//        id arr = list.mutableCopy;
//        [arr description];
        
        // view 会暴增
//        id view = [[UIView alloc] init];
//        [view description];
        
        // image 会暴增
//        UIImage *image = [UIImage imageWithContentsOfFile:path];
//        [image description];
    }
    
    // image被及时释放，不会暴增
    // 这种情况下image的释放归while循环中的autoreleasepool {}管，在一次while循环中，objc_autoreleasePoolPop(atautoreleasepoolobj)被调用，image就会执行release方法释放内存
//    while (1) {
//        @autoreleasepool {
//            UIImage *image = [UIImage imageWithContentsOfFile:path];
//            [image description];
//        }
//    }
}

#pragma mark - testGetImageFromView

- (void)testGetImageFromView {
    
    NSMutableArray *viewArr = [NSMutableArray array];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        START_COUNT_TIME(start);
        int num = 0;
        for (int i = 0; i < 10; i++) {
            for (int j = 0; j < 50; j++) {
                @autoreleasepool {
                    UIView *view = [self getColorView];
                    UIImage *image = [self getImageFromView:view];
                    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
                    imageView.frame = CGRectMake(i*50, j*50, 50, 50);
                    [viewArr addObject:imageView];
                    num++;
                }
            }
        }
        NSLog(@"%i", num);
        
        NSLog(@"创建花费 %lu 微妙", END_COUNT_TIME(start));
        
        dispatch_async(dispatch_get_main_queue(), ^{
            START_COUNT_TIME(start2);
            for (UIView *view in viewArr) {
                [self.view addSubview:view];
            }
            NSLog(@"添加花费 %lu 微妙", END_COUNT_TIME(start2));
        });
    });
}

- (UIView *)getColorView {
    UIView *container = [UIView new];
    container.frame = CGRectMake(0, 0, 50, 50);
    UIImageView *view1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"codeLogo"]];
    view1.frame = CGRectMake(0, 0, 25, 25);
    view1.backgroundColor = RANDOM_COLOR;
    UIImageView *view2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"codeLogo"]];
    view2.frame = CGRectMake(25, 0, 25, 25);
    view2.backgroundColor = RANDOM_COLOR;
    UIImageView *view3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"codeLogo"]];
    view3.frame = CGRectMake(0, 25, 25, 25);
    view3.backgroundColor = RANDOM_COLOR;
    UIImageView *view4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"codeLogo"]];
    view4.frame = CGRectMake(25, 25, 25, 25);
    view4.backgroundColor = RANDOM_COLOR;
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 50, 50);
    label.font = [UIFont systemFontOfSize:8.0f];
    label.text = @"拉开见识到了疯狂就俺俩是打飞机拉克丝";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
    [container addSubview:view1];
    [container addSubview:view2];
    [container addSubview:view3];
    [container addSubview:view4];
//    [container addSubview:label];
    return container;
}

- (UIImage *)getImageFromView:(UIView *)view {
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - testIQKeyboardManagerReturn

- (void)testIQKeyboardManagerReturn {
    
    for (int i = 0; i < 5; i++) {
        UITextField *tf = [[UITextField alloc] init];
        tf.frame = CGRectMake(0, 50*i + 10, 100, 50);
        tf.backgroundColor = RANDOM_COLOR;
        [self.view addSubview:tf];
    }
    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc] initWithViewController:self];
}

#pragma mark - testSandBoxPath

- (void)testSandBoxPath {
    /*
        1./Users/zhuchaopeng388/Library/Developer/CoreSimulator/Devices/8D557EBD-4180-4535-93B4-F9D9CD9D008F/data/Containers/Data/Application/10CB9AFC-A114-4E5F-B760-065EDAC5D31B/Documents
        2.~/Documents
     */
    self.directorys = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.directorys = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, NO);

    self.directorys = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, NO); // ~/Applications
    self.directorys = NSSearchPathForDirectoriesInDomains(NSDemoApplicationDirectory, NSUserDomainMask, NO); // ~/Applications/Demos
    self.directorys = NSSearchPathForDirectoriesInDomains(NSDeveloperApplicationDirectory, NSUserDomainMask, NO); // ~/Developer/Applications
    self.directorys = NSSearchPathForDirectoriesInDomains(NSAdminApplicationDirectory, NSUserDomainMask, NO); // ~/Applications/Utilities
    self.directorys = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, NO); // ~/Library
    self.directorys = NSSearchPathForDirectoriesInDomains(NSDeveloperDirectory, NSUserDomainMask, NO); // ~/Developer
    
    self.directorys = NSSearchPathForDirectoriesInDomains(NSUserDirectory, NSUserDomainMask, NO); //
    self.directorys = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, NO); // ~/Library/Documentation
    self.directorys = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, NO); // ~/Documents
    self.directorys = NSSearchPathForDirectoriesInDomains(NSCoreServiceDirectory, NSUserDomainMask, NO); //
    self.directorys = NSSearchPathForDirectoriesInDomains(NSAutosavedInformationDirectory, NSUserDomainMask, NO); // ~/Library/Autosave Information
    self.directorys = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, NO); // ~/Desktop
    self.directorys = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, NO); // ~/Library/Caches
    self.directorys = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, NO); // ~/Library/Application Support
    self.directorys = NSSearchPathForDirectoriesInDomains(NSDownloadsDirectory, NSUserDomainMask, NO); // ~/Downloads
    self.directorys = NSSearchPathForDirectoriesInDomains(NSInputMethodsDirectory, NSUserDomainMask, NO); // ~/Library/Input Methods
    self.directorys = NSSearchPathForDirectoriesInDomains(NSMoviesDirectory, NSUserDomainMask, NO); // ~/Movies
    self.directorys = NSSearchPathForDirectoriesInDomains(NSMusicDirectory, NSUserDomainMask, NO); // ~/Music
    self.directorys = NSSearchPathForDirectoriesInDomains(NSPicturesDirectory, NSUserDomainMask, NO); // ~/Pictures
    self.directorys = NSSearchPathForDirectoriesInDomains(NSPrinterDescriptionDirectory, NSUserDomainMask, NO); //
    self.directorys = NSSearchPathForDirectoriesInDomains(NSSharedPublicDirectory, NSUserDomainMask, NO); // ~/Public
    self.directorys = NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, NO); // ~/Library/PreferencePanes
    self.directorys = NSSearchPathForDirectoriesInDomains(NSItemReplacementDirectory, NSUserDomainMask, NO); //
    self.directorys = NSSearchPathForDirectoriesInDomains(NSAllApplicationsDirectory, NSUserDomainMask, NO); // ~/Applications、~/Applications/Utilities、~/Developer/Applications、~/Applications/Demos"
    self.directorys = NSSearchPathForDirectoriesInDomains(NSAllLibrariesDirectory, NSUserDomainMask, NO); // ~/Library、~/Developer
    
    /*
     1.
     2.
     3./Users/zhuchaopeng388/Library/Developer/CoreSimulator/Devices/8D557EBD-4180-4535-93B4-F9D9CD9D008F/data/Containers/Data/Application/39284E1B-9ACA-4FA3-AC1B-5B0AB6217A72
     4./Users/zhuchaopeng388/Library/Developer/CoreSimulator/Devices/8D557EBD-4180-4535-93B4-F9D9CD9D008F/data/Containers/Data/Application/39284E1B-9ACA-4FA3-AC1B-5B0AB6217A72
     5./Users/zhuchaopeng388/Library/Developer/CoreSimulator/Devices/8D557EBD-4180-4535-93B4-F9D9CD9D008F/data/Containers/Data/Application/39284E1B-9ACA-4FA3-AC1B-5B0AB6217A72/tmp/
     6./
     */
    self.path = NSUserName();
    self.path = NSFullUserName();
    self.path = NSHomeDirectory();
    self.path = NSHomeDirectoryForUser(@"zcp");
    self.path = NSTemporaryDirectory();
    self.path = NSOpenStepRootDirectory();
    
    
    // 总结：
    // 1.document目录
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // 2.library目录：caches、preferences
    NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES);
    // 3.tmp目录
    NSTemporaryDirectory();
}

- (void)setDirectorys:(NSArray *)directorys {
    _directorys = directorys;
    NSLog(@"%@", directorys);
}

- (void)setPath:(NSString *)path {
    _path = path;
    NSLog(@"%@", self.path);
}

#pragma mark - testSettings

// 读取Settings.bundle中的设置
- (void)testSettings {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    // 如果app第一次启动，则设置默认值
    [userDefaults setObject:@"zcp" forKey:@"user_name"];
    [userDefaults setObject:@"bobo4" forKey:@"cheat_code"];
    
    
    NSString *userName = [userDefaults stringForKey:@"user_name"];
    NSString *cheatCode = [userDefaults stringForKey:@"cheat_code"];
    NSString *area = [userDefaults stringForKey:@"area"];
    NSLog(@"%@ %@ %@", userName, cheatCode, area);
}

#pragma mark - testBlock

- (void)testBlock {
//    NSString *ip3 = [self.class getLocalIPAddress:YES];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"ytaxi://hellobike.com/home"]];
}

#pragma mark - 获取设备当前网络IP地址
+ (NSString *)getNetworkIPAddress {
    //方式一：淘宝api
    NSURL *ipURL = [NSURL URLWithString:@"http://ip.taobao.com/service/getIpInfo.php?ip=myip"];
    NSData *data = [NSData dataWithContentsOfURL:ipURL];
    NSDictionary *ipDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSString *ipStr = nil;
    if (ipDic && [ipDic[@"code"] integerValue] == 0) {
        //获取成功
        ipStr = ipDic[@"data"][@"ip"];
    }
    return (ipStr ? ipStr : @"0.0.0.0");
}

+ (NSString *)getNetworkIPAddress2 {
    //方式二：新浪api
    NSError *error;
    NSURL *ipURL = [NSURL URLWithString:@"http://pv.sohu.com/cityjson?ie=utf-8"];

    NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
    //判断返回字符串是否为所需数据
    if ([ip hasPrefix:@"var returnCitySN = "]) {
        //对字符串进行处理，然后进行json解析
        //删除字符串多余字符串
        NSRange range = NSMakeRange(0, 19);
        [ip deleteCharactersInRange:range];
        NSString * nowIp =[ip substringToIndex:ip.length-1];
        //将字符串转换成二进制进行Json解析
        NSData * data = [nowIp dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict);
        return dict[@"cip"] ? dict[@"cip"] : @"0.0.0.0";
    }
    return @"0.0.0.0";
}

#pragma mark - 获取设备当前本地IP地址
+ (NSString *)getLocalIPAddress:(BOOL)preferIPv4 {
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    NSLog(@"addresses: %@", addresses);
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop) {
        address = addresses[key];
        //筛选出IP地址格式
        if([self isValidatIP:address]) *stop = YES;
    } ];
    return address ? address : @"0.0.0.0";
}

+ (BOOL)isValidatIP:(NSString *)ipAddress {
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            NSString *result=[ipAddress substringWithRange:resultRange];
            //输出结果
            NSLog(@"%@",result);
            return YES;
        }
    }
    return NO;
}

+ (NSDictionary *)getIPAddresses {
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

@end
