//
//  TravelCellNode.m
//  Demo
//
//  Created by zcp on 2019/5/7.
//  Copyright © 2019 zcp. All rights reserved.
//

#import "TravelCellNode.h"

@interface TravelCellNode ()

@property (nonatomic, strong) ASTextNode *timeNode;
@property (nonatomic, strong) ASTextNode *tagNode;
@property (nonatomic, strong) ASDisplayNode *sourceBallNode;
@property (nonatomic, strong) ASDisplayNode *destinationBallNode;
@property (nonatomic, strong) ASTextNode *sourceAddrNode;
@property (nonatomic, strong) ASTextNode *destinationAddrNode;
@property (nonatomic, strong) ASTextNode *statusNode;
@property (nonatomic, strong) ASTextNode *amountNode;

@end

@implementation TravelCellNode

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    [self addSubnode:self.timeNode];
    [self addSubnode:self.tagNode];
    [self addSubnode:self.sourceBallNode];
    [self addSubnode:self.sourceAddrNode];
    [self addSubnode:self.destinationBallNode];
    [self addSubnode:self.destinationAddrNode];
    [self addSubnode:self.statusNode];
    [self addSubnode:self.amountNode];
}

- (void)updateWithTravelModel:(TravelModel *)model {
    self.timeNode.attributedText = [[NSAttributedString alloc] initWithString:model.time attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0]}];
    self.sourceAddrNode.attributedText = [[NSAttributedString alloc] initWithString:model.sourceAddr attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0]}];
    self.destinationAddrNode.attributedText = [[NSAttributedString alloc] initWithString:model.destinationAddr attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0]}];
    self.statusNode.attributedText = [[NSAttributedString alloc] initWithString:model.status attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0]}];
    self.amountNode.attributedText = [[NSAttributedString alloc] initWithString:model.amount attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14.0]}];
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    ASInsetLayoutSpec *timeSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 20, 0, 10) child:self.timeNode];
    ASInsetLayoutSpec *sourceSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 20, 0, 10) child:self.sourceAddrNode];
    ASInsetLayoutSpec *destinationSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 20, 0, 10) child:self.destinationAddrNode];
    
    ASStackLayoutSpec *verticalSpec1 = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsStart children:@[timeSpec, sourceSpec, destinationSpec]];
    
    ASInsetLayoutSpec *statusSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 0, 0, 20) child:self.statusNode];
    
    ASInsetLayoutSpec *amountSpec = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(0, 0, 0, 20) child:self.amountNode];
    
    ASStackLayoutSpec *verticalSpec2 = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical spacing:0 justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsEnd children:@[statusSpec, amountSpec]];
    
    ASStackLayoutSpec *horizontalSpec = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal spacing:0 justifyContent:ASStackLayoutJustifyContentSpaceBetween alignItems:ASStackLayoutAlignItemsStretch children:@[verticalSpec1, verticalSpec2]];
    
    return horizontalSpec;
}


#pragma mark - getters

- (ASTextNode *)timeNode {
    if (!_timeNode) {
        _timeNode = [[ASTextNode alloc] init];
    }
    return _timeNode;
}

- (ASTextNode *)tagNode {
    if (!_tagNode) {
        _tagNode = [[ASTextNode alloc] init];
    }
    return _tagNode;
}

- (ASDisplayNode *)sourceBallNode {
    if (!_sourceBallNode) {
        _sourceBallNode = [[ASDisplayNode alloc] init];
    }
    return _sourceBallNode;
}

- (ASTextNode *)sourceAddrNode {
    if (!_sourceAddrNode) {
        _sourceAddrNode = [[ASTextNode alloc] init];
    }
    return _sourceAddrNode;
}

- (ASDisplayNode *)destinationBallNode {
    if (!_destinationBallNode) {
        _destinationBallNode = [[ASDisplayNode alloc] init];
    }
    return _destinationBallNode;
}

- (ASTextNode *)destinationAddrNode {
    if (!_destinationAddrNode) {
        _destinationAddrNode = [[ASTextNode alloc] init];
    }
    return _destinationAddrNode;
}

- (ASTextNode *)statusNode {
    if (!_statusNode) {
        _statusNode = [[ASTextNode alloc] init];
    }
    return _statusNode;
}

- (ASTextNode *)amountNode {
    if (!_amountNode) {
        _amountNode = [[ASTextNode alloc] init];
    }
    return _amountNode;
}

@end
