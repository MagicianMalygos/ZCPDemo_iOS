//
//  TouchDrawView.h
//  Demo
//
//  Created by zhuchaopeng on 16/10/10.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Line;

@interface TouchDrawView : UIView

@property (nonatomic, strong) NSMutableArray *drawLines;
@property (nonatomic, strong) Line *currLine;
@property (nonatomic, copy) NSString *currColor;

@end
