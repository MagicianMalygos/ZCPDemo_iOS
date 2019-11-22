//
//  DashedCell.m
//  Demo
//
//  Created by 朱超鹏 on 2017/10/10.
//  Copyright © 2017年 zcp. All rights reserved.
//

#import "DashedCell.h"

@implementation DashedCell

- (void)setupContentView {
    [self.contentView addSubview:self.dashedView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.dashedView.frame = self.bounds;
}

- (void)updateWithViewModel:(DashedCellViewModel *)viewModel {
    [super updateWithViewModel:viewModel];
    [self.dashedView configureWithModel:viewModel.model];
}

- (DashedView *)dashedView {
    if (!_dashedView) {
        _dashedView = [[DashedView alloc] init];
    }
    return _dashedView;
}

@end

@implementation DashedCellViewModel

- (instancetype)init {
    if (self = [super init]) {
        self.cellClass = [DashedCell class];
        self.cellReuseIdentifier = [DashedCell cellReuseIdentifier];
        self.cellHeight = @150;
    }
    return self;
}

@end
