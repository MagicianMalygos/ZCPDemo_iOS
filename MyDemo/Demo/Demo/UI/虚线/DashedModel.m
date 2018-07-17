//
//  DashedModel.m
//  Demo
//
//  Created by 朱超鹏 on 2017/10/10.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "DashedModel.h"

@implementation DashedModel

- (id)copyWithZone:(NSZone *)zone {
    DashedModel *model  = [[DashedModel alloc] init];
    model.lengthsV      = self.lengthsV.mutableCopy;
    model.phaseV        = self.phaseV;
    model.countV        = self.countV;
    
    model.lineWidth     = self.lineWidth;
    model.lineColor     = self.lineColor;
    
    model.type          = self.type;
    return model;
}

@end
