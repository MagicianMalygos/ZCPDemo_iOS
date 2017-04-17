//
//  AppDelegate.m
//  Demo
//
//  Created by apple on 16/3/10.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "AppDelegate.h"
#import "ZCPDemoHomeController.h"
#import "AppManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        
    // share相关
    [WeiboSDK enableDebugMode:YES];  // 设置调试模式
    [WeiboSDK registerApp:kAppKey];  // 向微博注册第三方应用
    
    ZCPDemoHomeController *vc = [ZCPDemoHomeController new];
    vc.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
//    [AppManager checkAppVersion];
//    [AppManager checkAppVersion_custom];
    
    [self cal:8.05];
    [self cal:8.00];
    [self cal:7.95];
    [self cal:7.94];
    [self cal:7.93];
    [self cal:7.92];
    [self cal:7.91];
    [self cal:7.90];
    [self cal:7.85];
    [self cal:7.84];
    return YES;
}

- (void)cal:(float)min {
    float r = 0;
    r += (min - 7.71)*200;
    r += (min - 7.70)*200;
    r += (min - 8.00)*400;
    r += (min - 7.99)*700;
    r -= 5 + (1500 * min)*0.1/100;
    r -= 5 * 4;
    NSLog(@"%f : %f", min, r);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
}

@end
