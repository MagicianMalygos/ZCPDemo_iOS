//
//  SquareButton.m
//  Demo
//
//  Created by 朱超鹏 on 2017/10/11.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "SquareButton.h"

@implementation SquareButton

+ (UIButton *)instanceSquareButton {
    SquareButton *squareButton      = [SquareButton buttonWithType:UIButtonTypeCustom];
    [squareButton resetup];
    [squareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [squareButton addTarget:squareButton action:@selector(clickSquareButton:) forControlEvents:UIControlEventTouchUpInside];
    [squareButton addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:squareButton action:@selector(longPressSquareButton:)]];
    return squareButton;
}

- (void)resetup {
    self.identity   = SquareButtonNumIdentity;
    self.status     = SquareButtonBackStatus;
    self.showNum    = 0;
    self.marked     = NO;
}

#pragma mark - event response

- (void)clickSquareButton:(SquareButton *)squareButton {
    if (self.delegate && [self.delegate respondsToSelector:@selector(squareButtonIsClicked:)]) {
        [self.delegate squareButtonIsClicked:self];
    }
}
                                                                                                                
- (void)longPressSquareButton:(UILongPressGestureRecognizer *)gesture {
    if (self.status != SquareButtonBackStatus || gesture.state != UIGestureRecognizerStateBegan) {
        return;
    }
    self.marked = !self.isMarked;
    if (self.delegate && [self.delegate respondsToSelector:@selector(squareButtonIsLongPressed:)]) {
        [self.delegate squareButtonIsLongPressed:self];
    }
}

#pragma mark - getters and setters

- (void)setStatus:(SquareButtonStatus)status {
    _status = status;
    if (status == SquareButtonBackStatus) {
        self.backgroundColor = [UIColor colorFromHexRGB:BackColor];
        [self setTitle:@"" forState:UIControlStateNormal];
    } else if (status == SquareButtonFrontStatus) {
        if (self.identity == SquareButtonNumIdentity) {
            self.backgroundColor = [UIColor colorFromHexRGB:NumColor];
        } else if (self.identity == SquareButtonMineIdentity && !self.isMarked) {
            self.backgroundColor = [UIColor colorFromHexRGB:MineColor];
        }
        NSString *showNum = (self.showNum > 0) ? [NSString stringWithFormat:@"%d", self.showNum] : @"";
        [self setTitle:showNum forState:UIControlStateNormal];
    }
}

- (void)setMarked:(BOOL)marked {
    _marked = marked;
    if (marked) {
        [self setTitle:@"雷" forState:UIControlStateNormal];
    } else {
        [self setTitle:@"" forState:UIControlStateNormal];
    }
}

@end
