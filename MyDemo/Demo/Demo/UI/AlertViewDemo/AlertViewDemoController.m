//
//  AlertViewDemoController.m
//  UIAlertViewDemo
//
//  Created by apple on 16/3/9.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "AlertViewDemoController.h"

@interface AlertViewDemoController () <UIAlertViewDelegate>

/// 切换显示alerView或是actionSheetView
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

/// alert title输入
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
/// alert message输入
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
/// alert title是否设置成nil
@property (weak, nonatomic) IBOutlet UISwitch *titleIsNilSwitch;
/// alert message是否设置成nil
@property (weak, nonatomic) IBOutlet UISwitch *messageIsNilSwitch;

@end

@implementation AlertViewDemoController

- (instancetype)initWithQuery:(NSDictionary *)query {
    if (self = [super initWithNibName:@"AlertViewDemoController" bundle:nil]) {
    }
    return self;
}

- (IBAction)clickShowButton {
    
    /*
     顺序：
     1.action的顺序是根据add的先后顺序从上到下排列。针对alertView如果仅有两个actin，那么将从左到右排列。
     2.cancel类型的action不管什么时候add都会排到最末尾，并与其他action隔开。针对alertView如果仅有两个action，那么cancel类型的action显示在左边。
     
     颜色：
     1.default类型的action字体颜色为 蓝色
     2.cacel类型的action字体颜色为 蓝色加粗
     3.destructive类型的action字体颜色为 红色
     
     其他：
     1.如果alert中添加了两个cancel类型的action，则会crash，信息如下：
     Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'UIAlertController can only have one action with a style of UIAlertActionStyleCancel'。
     2.如果alert的title和message是@""而不是nil，alert仍会显示title、message的白色区域。
     */
    
    UIAlertControllerStyle style = (self.segment.selectedSegmentIndex == 0)?UIAlertControllerStyleAlert:UIAlertControllerStyleActionSheet;
    NSString *title = (!self.titleIsNilSwitch.isOn) ? self.titleTextField.text : nil;
    NSString *message = (!self.messageIsNilSwitch.isOn) ? self.messageTextField.text : nil;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    for (int i = 1; i <= 6; i++) {
        @autoreleasepool {
            NSString *title = [NSString stringWithFormat:@"action%i", i];
            UIAlertActionStyle actionStyle = UIAlertActionStyleDefault;
            if (i == 3) {
                title = @"Cancel";
                actionStyle = UIAlertActionStyleCancel;
            } else if (i == 4) {
                title = @"Destructive";
                actionStyle = UIAlertActionStyleDestructive;
            }
            UIAlertAction *action = [UIAlertAction actionWithTitle:title style:actionStyle handler:nil];
            [alert addAction:action];
        }
    }
    [self presentViewController:alert animated:YES completion:nil];
}

@end
