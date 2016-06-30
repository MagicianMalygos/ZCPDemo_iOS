//
//  MySingleton.h
//  JumpToVC
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <objc/runtime.h>

#ifndef MySingleton_h
#define MySingleton_h


#if __has_feature(objc_instancetype)

    #undef      DEF_SINGLETON
    #define     DEF_SINGLETON( ... )  \
                + (instancetype)sharedInstance;

    #undef      IMP_SINGLETON
    #define     IMP_SINGLETON  \
                + (instancetype)sharedInstance \
                { \
                    static dispatch_once_t once; \
                    static id __singleton__; \
                    dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } ); \
                    return __singleton__; \
                }
#endif


#endif /* MySingleton_h */
