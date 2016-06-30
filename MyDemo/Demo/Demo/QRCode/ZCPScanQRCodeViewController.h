//
//  ZCPScanQRCodeViewController.h
//  Demo
//
//  Created by apple on 16/6/6.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SuccessBlock)(NSString *QRCodeInfo);

// 二维码扫描视图控制器
@interface ZCPScanQRCodeViewController : UIViewController

@property (nonatomic, copy) SuccessBlock successBlock;  // 扫描成功执行块
@property (nonatomic, assign) BOOL showQRCodeInfo;      // 设置是否回调二维码扫描结果，如果设置为NO则不执行successBlock块

@end