//
//  AppDelegate.m
//  GotoDemo
//
//  Created by zhuchaopeng on 16/10/14.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    ViewController *vc1 = [ViewController new];
    vc1.view.backgroundColor = [UIColor redColor];
    vc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"vc1" image:nil selectedImage:nil];
    ViewController *vc2 = [ViewController new];
    vc2.view.backgroundColor = [UIColor greenColor];
    vc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"vc2" image:nil selectedImage:nil];
    ViewController *vc3 = [ViewController new];
    vc3.view.backgroundColor = [UIColor blueColor];
    vc3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"vc3" image:nil selectedImage:nil];
    
    UINavigationController *nv1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    nv1.navigationBar.barTintColor = [UIColor redColor];
    nv1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"nv1" image:nil selectedImage:nil];
    UINavigationController *nv2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    nv2.navigationBar.barTintColor = [UIColor greenColor];
    nv2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"nv2" image:nil selectedImage:nil];
    UINavigationController *nv3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    nv3.navigationBar.barTintColor = [UIColor blueColor];
    nv3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"nv3" image:nil selectedImage:nil];
    
    UITabBarController *tabbar = [[UITabBarController alloc] init];
    
    UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:tabbar];
    rootNav.navigationBar.barTintColor = [UIColor orangeColor];
    [rootNav setNavigationBarHidden:YES];
    
    
    // 1. nav - tab - vc !ok
    /*
        vc的nav是rootNav
     */
//    [tabbar setViewControllers:@[vc1, vc2, vc3]];
//    self.window.rootViewController = rootNav;
    
    // 2. nav - tab - nav - vc
    [tabbar setViewControllers:@[nv1, nv2, nv3]];
    self.window.rootViewController = rootNav;
    
    // 3. tab - nav - vc
//    [tabbar setViewControllers:@[nv1, nv2, nv3]];
//    self.window.rootViewController = tabbar;
    
    
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
