//
//  main.m
//  ZCPKit
//
//  Created by zhuchaopeng on 16/9/18.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AOPManager.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        setupAOP();
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
