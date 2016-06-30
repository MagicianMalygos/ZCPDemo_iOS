//
//  NSObject+Category.m
//  haofang
//
//  Created by PengFeiMeng on 4/19/14.
//  Copyright (c) 2014 平安好房. All rights reserved.
//

#import "NSObject+Category.h"

@implementation NSObject (Category)

- (void)logIvarList{
    unsigned int outCount   = 0;
    Ivar * ivarList         = class_copyIvarList([self class], &outCount);
    
    for (int i = 0; i < outCount; i++) {
        Ivar ivar           = ivarList[i];
        const char * name   = ivar_getName(ivar);
        const char * class  = class_getName([self class]);
        const char * type   = ivar_getTypeEncoding(ivar);
        id value            = object_getIvar(self, ivar);
        NSLog(@"\nclass:%s \nname:%s \ntype:%s \nvalue:%@ \npointer:%p",class,name,type,value,value);
    }
    free(ivarList);
}

- (BOOL)isNilOrNull{
    if ((self != nil) && (self != [NSNull null])) {
        return NO;
    }
    return YES;
}


- (id)performSelector:(SEL)aSelector withObjects:(NSArray *)objects{
    // 方法签名
    NSMethodSignature * signature   = [self methodSignatureForSelector:aSelector];
    
    if (signature) {
        NSString * selectorString       = NSStringFromSelector(aSelector);
        NSInteger colonCount            = [self countOfAppearanceOfString:@":" inString:selectorString];
        
        // 判断传入参数数量是否跟方法中参数数量相同
        if (objects) {
            if (objects.count != colonCount) {
                return nil;
            }
        }else{
            if (colonCount) {
                return nil;
            }
        }
        
        // 调用对象
        NSInvocation * invocation   = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:self];
        [invocation setSelector:aSelector];
        
        // 传入参数
        if (objects && objects.count) {
            for (int i = 0; i < objects.count; i++) {
                id obj = [objects objectAtIndex:i];
                [invocation setArgument:&obj atIndex:i+2];
            }
        }
        
        // 调用
        [invocation invoke];
        if (signature.methodReturnLength) {
            id returnValue;
            [invocation getReturnValue:&returnValue];
            
            return returnValue;
        }else{
            return nil;
        }
    }
    return nil;
}

- (NSInteger)countOfAppearanceOfString:(NSString *)string inString:(NSString *)originalString{
    NSInteger count           = 0;
    
    if (originalString) {
        if ([originalString rangeOfString:string].location != NSNotFound) {
            NSArray * components = [originalString componentsSeparatedByString:string];
            
            if (components && components.count) {
                count   = components.count - 1;
            }
        }
    }
    
    return count;
}

- (NSString *)stringValue{
    NSString * string = [NSString stringWithFormat:@"%@",self];
    
    return string;
}


+ (NSString *)contentTypeForImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
    }
    return nil;
}


- (id)objectForKey:(id <NSCopying>)aKey{
    id object = nil;
    
    return object;
}
@end


@implementation NSObject (Release)

- (void) paDealloc {
#if __has_feature(objc_arc)
    
#else
    [self dealloc];
#endif
}

- (void) paRelease {
#if __has_feature(objc_arc)
    
#else
    [self release];
#endif
}

@end

