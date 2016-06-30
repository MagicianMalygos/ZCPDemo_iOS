//
//  ClassA.h
//  AccessOCPrivateMethod
//
//  Created by apple on 15/12/1.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassA : NSObject {
    @public
    int varPublic;
    @private
    int varPrivate;
}
@property (nonatomic, assign) int varPublicProperty;
@property (nonatomic, assign) int varName;

+ (void)classMethodA;
- (void)methodA;

@end
