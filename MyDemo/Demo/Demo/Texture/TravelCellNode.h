//
//  TravelCellNode.h
//  Demo
//
//  Created by zcp on 2019/5/7.
//  Copyright © 2019 zcp. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "TravelModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TravelCellNode : ASCellNode

- (void)updateWithTravelModel:(TravelModel *)model;

@end

NS_ASSUME_NONNULL_END
