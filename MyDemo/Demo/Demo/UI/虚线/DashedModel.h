//
//  DashedModel.h
//  Demo
//
//  Created by 朱超鹏 on 2017/10/10.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DashedModel : NSObject {
@public
    CGFloat lengthsV[10];
}

@property (nonatomic, assign) float   phaseV;
//@property (nonatomic, assign) CGFloat *lengthsV;
//@property (nonatomic, strong) NSValue *lengthValue;
@property (nonatomic, assign) float   countV;
@property (nonatomic, assign) CGRect  dashedViewFrame;

@end
