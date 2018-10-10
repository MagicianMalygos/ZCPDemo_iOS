//
//  Test3.m
//  RuntimeDemo
//
//  Created by apple on 16/2/26.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "RuntimeTest3.h"

@interface MyClass3 : NSObject
@end
@implementation MyClass3
- (void)t:(double)d {
}
@end

@interface CrashHelper : NSObject
- (void)iWillCrash;
@end
@implementation CrashHelper
- (void)iWillCrash {
    NSLog(@"I clear a crash.");
}
@end

@interface NewCrashHelper : CrashHelper
- (void)invincible;
@end
@implementation NewCrashHelper
- (void)invincible {
    NSLog(@"I clear a crash. I`m invincible.");
}
@end

@interface FakeCrashHelper : NSObject
@end
@implementation FakeCrashHelper
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    class_addMethod(self, sel, (IMP)fake, "v@:");
    return YES;
}
void fake() {
    NSLog(@"Haha, You idiot!");
}
@end

static NewCrashHelper *helper;
static MyClass3 *class3;

@implementation RuntimeTest3

- (void)t:(int)i {
}

- (void)cognize {
    helper = [NewCrashHelper new];
    class3 = [MyClass3 new];
    
    // Objective-C在编译时，会依据每一个方法的名字、参数序列，生成一个唯一的整型标识(Int类型的地址)，这个标识就是SEL
    // 两个类之间，不管它们是父类与子类的关系，还是之间没有这种关系，只要方法名相同，那么方法的SEL就是一样的
    SEL sel = @selector(copy);
    SEL sel2 = @selector(t:);
    NSLog(@"sel: %p, %p", sel, sel2);
    
    // 获取SEL
    SEL sel_copy1 = sel_registerName("copy");
    SEL sel_copy2 = @selector(copy);
    SEL sel_copy3 = NSSelectorFromString(@"copy");
    NSLog(@"%p %p %p", sel_copy1, sel_copy2, sel_copy3);
    
    // 方法操作相关函数
    /*
     
    // 调用指定方法的实现
    id method_invoke ( id receiver, Method m, ... );
    // 调用返回一个数据结构的方法的实现
    void method_invoke_stret ( id receiver, Method m, ... );
    // 获取方法名
    SEL method_getName ( Method m );
    // 返回方法的实现
    IMP method_getImplementation ( Method m );
    // 获取描述方法参数和返回值类型的字符串
    const char * method_getTypeEncoding ( Method m );
    // 获取方法的返回值类型的字符串
    char * method_copyReturnType ( Method m );
    // 获取方法的指定位置参数的类型字符串
    char * method_copyArgumentType ( Method m, unsigned int index );
    // 通过引用返回方法的返回值类型字符串
    void method_getReturnType ( Method m, char *dst, size_t dst_len );
    // 返回方法的参数的个数
    unsigned int method_getNumberOfArguments ( Method m );
    // 通过引用返回方法指定位置参数的类型字符串
    void method_getArgumentType ( Method m, unsigned int index, char *dst, size_t dst_len );
    // 返回指定方法的方法描述结构体
    struct objc_method_description * method_getDescription ( Method m );
    // 设置方法的实现
    IMP method_setImplementation ( Method m, IMP imp );
    // 交换两个方法的实现
    void method_exchangeImplementations ( Method m1, Method m2 );
     
    // 返回给定选择器指定的方法的名称
    const char * sel_getName ( SEL sel );
    // 在Objective-C Runtime系统中注册一个方法，将方法名映射到一个选择器，并返回这个选择器
    SEL sel_registerName ( const char *str );
    // 在Objective-C Runtime系统中注册一个方法
    SEL sel_getUid ( const char *str );
    // 比较两个选择器
    BOOL sel_isEqual ( SEL lhs, SEL rhs );
     
    // 方法调用
    objc_msgSend(receiver, selector)    （该方法有两个隐藏参数：消息接收对象(self)、方法的selector(_cmd)，他们在定义方法的源代码中没有声明，实在编译器被插入实现代码的）
    // 如果消息中还有其它参数，则该方法的形式如下所示
    objc_msgSend(receiver, selector, arg1, arg2, ...)
    1. 首先它找到selector对应的方法实现。因为同一个方法可能在不同的类中有不同的实现，所以我们需要依赖于接收者的类来找到的确切的实现。
    2. 它调用方法实现，并将接收者对象及方法的所有参数传给它。
    3. 最后，它将实现返回的值作为它自己的返回值。
    
    当消息发送给一个对象时，objc_msgSend通过对象的isa指针获取到类的结构体，然后在方法分发表里面查找方法的selector。
    如果 没有找到selector，则通过objc_msgSend结构体中的指向父类的指针找到其父类，并在父类的分发表里面查找方法的selector。
    依此，会一直沿着类的继承体系到达NSObject类。一旦定位到selector，函数会就获取到了实现的入口点，并传入相应的参数来执行方法的具体实 现。
    如果最后没有定位到selector，则会走消息转发流程
    
    // 方法的动态绑定可以让我们写代码时更具有灵活性（可以把消息转发给我们想要的对象，或者随意交换一个方法的实现等），灵活性的提升带来了性能上的损耗（因为我们需要去查找方法的实现，而不像函数调用那样直接）
    */
    
    typedef void (*mySET)(id, SEL, BOOL);
    mySET setter = (mySET)[self methodForSelector:@selector(log)];
    
    START_COUNT_TIME(start1);
    for (int i = 0 ; i < 500; i++) {
//        objc_msgSend(self, @selector(log));  // 编译报错
    }
    NSLog(@"Consume time: %lf ms", (double)END_COUNT_TIME(start1)/CLOCKS_PER_SEC * 1000);
    
    // i值不同，两者耗时多少比较结果也不同
    START_COUNT_TIME(start2);
    for (int i = 0 ; i < 500; i++) {
        setter(self, @selector(log), YES);
    }
    NSLog(@"Consume time: %lf ms", (double)END_COUNT_TIME(start2)/CLOCKS_PER_SEC * 1000);
    
    START_COUNT_TIME(start3);
    for (int i = 0 ; i < 500; i++) {
        [self log];
    }
    NSLog(@"Consume time: %lf ms", (double)END_COUNT_TIME(start3)/CLOCKS_PER_SEC * 1000);
    
    // 运行时方法调用
    // 当一个对象无法接收指定消息时，不能以[object message]的方式调用方法，编译器会报错，但如果以perform...的形式来调用，则需要等到运行时才能确定object是否能接收message消息，如果不能则crash
    if ([self respondsToSelector:@selector(log)]) {
        START_COUNT_TIME(start4);
        for (int i = 0 ; i < 500; i++) {
            [self performSelector:@selector(log)];
        }
        NSLog(@"Consume time: %lf ms", (double)END_COUNT_TIME(start4)/CLOCKS_PER_SEC * 1000);
    }
    
    // 消息转发
    [self performSelector:@selector(iWillCrash)];    // 崩溃的代码
//    [RuntimeTest3 performSelector:@selector(iWillCrash)];
    // 通过消息转发避免程序崩溃：1.动态方法解析，2.备用接收者，3.完整消息转发
}

// 1. 动态方法解析：对象在接收到未知的消息时，首先会调用所属类的该类方法.
// 这个方法就是为了让我们给类加实例方法用的，好像返回NO和YES没什么区别，无论返回什么，加了方法就会执行顺利执行，不加方法就会走后续的消息转发
// 试了下这个返回值也不是用作respondsToSelector、instancesRespondToSelector的返回值
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    NSString *selectorString = NSStringFromSelector(sel);
//    if ([selectorString isEqualToString:@"iWillCrash"]) {
//        class_addMethod([self class], @selector(iWillCrash), (IMP)kidding, "v@:");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}
// 类方法如果这步处理不了，就没有后续了，直接crash
//+ (BOOL)resolveClassMethod:(SEL)sel {
//    NSString *selectorString = NSStringFromSelector(sel);
//    if ([selectorString isEqualToString:@"iWillCrash"]) {
//        class_addMethod(objc_getMetaClass(object_getClassName(self)), @selector(iWillCrash), (IMP)kidding, "v@:");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}
//
//void kidding() {
//    NSLog(@"Crash? I`m kidding you.");
//}

// 2. 备用接收者：如果在上一步无法处理消息，则Runtime会继续调用以下方法。无法处理类方法
// 如果此处返回nil，那么会继续走后续的方法
// 此处返回的对象会接手该消息，然后会走返回对象的消息发送流程。引起crash的对象的消息发送流程至此结束。
// 此处返回的对象只要能够处理aSelector方法就行，即使是它父类去处理
- (id)forwardingTargetForSelector:(SEL)aSelector {
//    return [FakeCrashHelper new];
    NSString *selectorString = NSStringFromSelector(aSelector);
    if ([selectorString isEqualToString:@"iWillCrash"]) {
        return helper;
    }
    return [super forwardingTargetForSelector:aSelector];
}

// 3. 完整消息转发：如果在上一步无法处理消息，则Runtime会继续调用以下方法
// 如果返回nil则不会再走forwardInvocation，直接crash
// 只要不为nil，返回值可以是任何signature，
// 方法签名跟方法名什么没有关系，只是能够表示方法的返回类型和参数类型的一个类
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
//    signature = [NewCrashHelper instanceMethodSignatureForSelector:@selector(invincible)];
//    signature = [NSMethodSignature signatureWithObjCTypes:"@@::::@@"];
    if (!signature) {
        if ([helper.class instancesRespondToSelector:aSelector]) {
            signature = [helper.class instanceMethodSignatureForSelector:aSelector];
        }
    }
    return signature;
}
// 此处的NSInvocation中的signature是上一步返回的，但是好像没什么作用。里面的selector仍旧是那个导致crash的方法，target是导致crash的那个对象
// 这里可以什么都不处理，那么就忽略掉了方法调用导致的crash。
// 如果想要处理一些事情，可以做任何事
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([helper.class instancesRespondToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:helper];
    }
}

- (void)log {
//    NSLog(@"log!");
    // 模拟耗时操作
    int c = 0;
    for (int i = 0; i < 100000; i ++) {
        int a  = 19;
        int b  = 18;
        c = (a + b) * i % 2537;
    }
}

@end
