//
//  AppDelegate.m
//  FlutterDemo
//
//  Created by zcp on 2019/4/3.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <Flutter/Flutter.h>

@interface AppDelegate () <FlutterAppLifeCycleProvider>

@property (nonatomic, strong) FlutterPluginAppLifeCycleDelegate *flutterLifeCycleDelegate;

@end

@implementation AppDelegate

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return [self.flutterLifeCycleDelegate application:application didFinishLaunchingWithOptions:launchOptions];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [self.flutterLifeCycleDelegate applicationWillResignActive:application];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self.flutterLifeCycleDelegate applicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self.flutterLifeCycleDelegate applicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self.flutterLifeCycleDelegate applicationDidBecomeActive:application];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [self.flutterLifeCycleDelegate applicationWillTerminate:application];
}

#pragma mark - FlutterAppLifeCycleProvider

- (void)addApplicationLifeCycleDelegate:(nonnull NSObject<FlutterPlugin> *)delegate {
    [self.flutterLifeCycleDelegate addDelegate:delegate];
}

#pragma mark - getters

- (FlutterPluginAppLifeCycleDelegate *)flutterLifeCycleDelegate {
    if (!_flutterLifeCycleDelegate) {
        _flutterLifeCycleDelegate = [[FlutterPluginAppLifeCycleDelegate alloc] init];
    }
    return _flutterLifeCycleDelegate;
}

@end
