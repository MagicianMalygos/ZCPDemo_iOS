//
//  DashedSettingView.m
//  Demo
//
//  Created by 朱超鹏(外包) on 17/1/12.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "DashedSettingView.h"

@implementation DashedSettingView

- (IBAction)clickGoButton:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickGoButton:)]) {
        [self.delegate clickGoButton:sender];
    }
}

- (IBAction)clickMoveButton:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickMoveButton:)]) {
        [self.delegate clickMoveButton:sender];
    }
}

@end
