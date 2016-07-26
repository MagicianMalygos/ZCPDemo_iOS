//
//  LCVodView.h
//  LCPlayerSDKConsumerDemo
//
//  Created by tingting on 16/3/31.
//  Copyright © 2016年 CC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VodStartPlayDelegate <NSObject>

- (void)vodStartPlayUU:(NSString *)uu vu:(NSString *)vu segType:(NSInteger)segType;

@end

@interface LCVodView : UIView


@property (nonatomic, strong)id<VodStartPlayDelegate>delegate;

+(LCVodView *)instanceTextView;


@end
