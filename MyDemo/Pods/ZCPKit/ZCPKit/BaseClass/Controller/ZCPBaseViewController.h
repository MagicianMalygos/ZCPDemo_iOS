//
//  ZCPBaseViewController.h
//  ZCPKit
//
//  Created by zcp on 2019/1/10.
//  Copyright © 2019 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+ZCPBase.h"
#import "UIViewController+ZCPRouter.h"

NS_ASSUME_NONNULL_BEGIN

/**
 控制器基类。
 只能通过实现协议加相应的功能。如果想要进行扩展，则需要新增UIViewController或ZCPBaseViewController对应功能的分类，定义对应的协议。然后让ZCPBaseViewController实现该协议。
 */
@interface ZCPBaseViewController : UIViewController <ZCPViewControllerBaseProtocol, ZCPNavigatorProtocol>

@end

NS_ASSUME_NONNULL_END
