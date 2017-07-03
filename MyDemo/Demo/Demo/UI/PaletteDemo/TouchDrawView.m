//
//  TouchDrawView.m
//  Demo
//
//  Created by zhuchaopeng on 16/10/10.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "TouchDrawView.h"
#import "Line.h"

@implementation TouchDrawView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setMultipleTouchEnabled:YES];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 5.0f);
    CGContextSetLineCap(context, kCGLineCapRound);
    [RANDOM_COLOR set];
    for (Line *line in self.drawLines) {
        [[UIColor colorFromHexRGB:line.color] set];
        CGContextMoveToPoint(context, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(context, [line end].x, [line end].y);
        CGContextStrokePath(context);
    }
}

#pragma mark - private
- (void)addLine:(Line *)line {
//    [[self.undoManager prepareWithInvocationTarget:self] removeObject:line];
    [self.drawLines addObject:line];
}

- (void)removeLine:(Line *)line {
    if ([self.drawLines containsObject:line]) {
        [self.drawLines removeObject:line];
    }
}

- (void)removeLineByEndPoint:(CGPoint)point {
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        Line *evaluatedLine = (Line *)evaluatedObject;
        return (evaluatedLine.end.x == point.x) && (evaluatedLine.end.y == point.y);
    }];
    NSArray *result = [self.drawLines filteredArrayUsingPredicate:predicate];
    if (result && result.count > 0) {
        [self.drawLines removeObject:result[0]];
    }
}

#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.undoManager beginUndoGrouping];
    for (UITouch *touch in touches) {
        CGPoint loc = [touch locationInView:self];
        Line *newLine = [[Line alloc] init];
        newLine.begin = loc;
        newLine.end = loc;
        newLine.color = self.currColor;
        self.currLine = newLine;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        [self.currLine setColor:self.currColor];
        CGPoint loc = [touch locationInView:self];
        [self.currLine setEnd:loc];
        
        if (self.currLine) {
            [self addLine:self.currLine];
        }
        Line *newLine = [[Line alloc] init];
        [newLine setBegin:loc];
        [newLine setEnd:loc];
        [newLine setColor:self.currColor];
        self.currLine = newLine;
    }
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setNeedsDisplay];
//    [self.undoManager endUndoGrouping];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setNeedsDisplay];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

#pragma mark - getter / setter
- (NSMutableArray *)drawLines {
    if (!_drawLines) {
        _drawLines = [NSMutableArray array];
    }
    return _drawLines;
}
- (NSString *)currColor {
    
    NSString *hexString = @"";
    for (int i = 0; i < 6; i++) {
        int num = RANDOM(0, 15);
        NSString *s = @"0";
        char c;
        
        if (num > 9) {
            c = (num - 10 + 'A');
            s = [NSString stringWithFormat:@"%c", c];
        } else {
            s = [NSString stringWithFormat:@"%d", num];
        }
        hexString = [hexString stringByAppendingString:s];
    }
    
    return hexString;
}

@end
