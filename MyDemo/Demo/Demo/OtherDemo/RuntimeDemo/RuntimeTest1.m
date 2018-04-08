//
//  RuntimeTest1.m
//  RuntimeDemo
//
//  Created by apple on 16/2/25.
//  Copyright © 2016年 zcp. All rights reserved.
//

#import "RuntimeTest1.h"

// - - - - - - - - - - - - - - - - - - - -
#pragma mark - 方法
// - - - - - - - - - - - - - - - - - - - -
void testMetaClass (id self, SEL _cmd, id info) {
    // 打印实例对象地址
    NSLog(@"This object is %p", self);
    // 打印实例对象的类的地址，和实例对象的父类的地址
    NSLog(@"Class is %@, super class is %@", [self class], [self superclass]);
    
    // 打印isa指针指向地址
    Class currentClass = [self class];
    for (int i = 0; i < 4; i++) {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = objc_getClass((__bridge void *)currentClass);
    }
    
    // 打印NSObject类的地址
    NSLog(@"NSObject`s class is %p", [NSObject class]);
    // 打印NSObject类的元类地址*（即为NSObject类的isa指针所指向的地址）
    NSLog(@"NSobject`s meta class is %p", objc_getClass((__bridge void *)[NSObject class]));
}
void subMethod(id self, SEL _cmd) {
    NSLog(@"Run subMethod");
}

// - - - - - - - - - - - - - - - - - - - -
#pragma mark - 类
// - - - - - - - - - - - - - - - - - - - -
@interface MyClass : NSObject <NSObject> {
    NSInteger _instance1;
    NSString *_instance2;
}
@property (nonatomic, assign) NSUInteger integer;
@property (nonatomic, copy) NSString *string;
@property (nonatomic, strong) NSArray *array;
+ (void)classMethod;
- (void)method1;
- (void)method2;
- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2;
@end
@implementation MyClass
+ (void)classMethod {
}
- (void)method1 {
    NSLog(@"Call method method1");
}
- (void)method2 {
}
- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2 {
    NSLog(@"arg1:%ld, arg2:%@", arg1, arg2);
}
@end

// - - - - - - - - - - - - - - - - - - - -
#pragma mark - 测试类
// - - - - - - - - - - - - - - - - - - - -
@implementation RuntimeTest1

// 类与对象基础数据结构
- (void)ex_registerClassPair {
    // 创建一个新类和元类(metaClass)，其父类为NSError
    Class newClass = objc_allocateClassPair([NSError class], "TestClass", 0);
    // 向该新类中添加testMetaClass方法
    // types为返回值和参数类型：v表示返回值为void（若返回值为int则为i）、@表示id、:表示SEL
    class_addMethod(newClass, NSSelectorFromString(@"testMetaClass"), (IMP)testMetaClass, "V@:@");
    // 注册该新类和元类
    objc_registerClassPair(newClass);
    
    // 实例化新类
    id instance = [[newClass alloc] initWithDomain:@"some domain" code:0 userInfo:nil];
    // 执行新类的testMetaClass方法
    SuppressPerformSelectorLeakWarning(
        [instance performSelector:NSSelectorFromString(@"testMetaClass") withObject:@""];
    );
}

// 类与对象操作函数
- (void)classOperationContent {
    // 类
    class_getName([NSObject class]);                            // 获取类名 char*
    class_getSuperclass([UITextField class]);                   // 获取类的父类 Class
    class_isMetaClass([NSObject class]);                        // Class是否是一个元类 BOOL
    
    // 获取实例大小
    class_getInstanceSize([NSObject class]);                    // 获取实例大小 size_t
    
    // 成员变量， Objective-C不支持往已存在的类中添加实例变量，这个方法只能在objc_allocateClassPair函数与objc_registerClassPair之间调用
    class_getInstanceVariable([UITextField class], "text");     // 获取实例成员变量信息 Ivar
    class_getClassVariable([UITextField class], "text");        // 获取类成员变量信息 Ivar
    // 添加成员变量 BOOL， 参数：类，变量名，以字节为单位的最小对齐方式，参数类型
//        class_addIvar(__unsafe_unretained Class cls, const char *name, size_t size, uint8_t alignment, const char *types);
    unsigned int outCount;
    class_copyIvarList([UITextField class], &outCount);         // 获取整个成员变量列表 Ivar* ，必须用free()来释放返回的数组
    
    // 属性
    class_getProperty([UITextField class], "text");             // 获取指定属性 objc_property_t
    class_copyPropertyList([UITextField class], &outCount);     // 获取属性列表 objc_property_t
    //    class_addProperty(__unsafe_unretained Class cls, const char *name, const objc_property_attribute_t *attributes, unsigned int attributeCount);  // 添加属性 void
    //    class_replaceProperty(__unsafe_unretained Class cls, const char *name, const objc_property_attribute_t *attributes, unsigned int attributeCount);  // 替换属性 BOOL
    
    // 方法， 与实例变量不同，Objective-C可以往类中动态添加方法
    class_getInstanceMethod([NSObject class], @selector(description));  // 获取实例方法 Method
    class_getClassMethod([NSObject class], @selector(new));             // 获取类方法 Method
    class_copyMethodList([NSObject class], &outCount);                  // 获取所有方法的数组 Method*
    // 添加方法 BOOL，class_addMethod的实现会覆盖父类的方法实现，但不会取代本类中已存在的实现，如果本类中包含一个同名的实现，则函数会返回NO
    //    class_addMethod(__unsafe_unretained Class cls, SEL name, IMP imp, const char *types);
    // 替代方法的实现 IMP
    //    class_replaceMethod(__unsafe_unretained Class cls, SEL name, IMP imp, const char *types);
    // 返回方法的具体实现 IMP
    class_getMethodImplementation([NSObject class], @selector(new));
//    class_getMethodImplementation_stret([NSObject class], @selector(alloc));  // 编译报错
    class_respondsToSelector([NSObject class], @selector(init));        // 类实例是否响应指定的selector BOOL
    /**
     *  一个Objective-C方法是一个简单的C函数，它至少包含两个参数—self和_cmd。所以，我们的实现函数(IMP参数指向的函数)至少需要两个参数，如下所示：
     *  void myMethodIMP(id self, SEL _cmd) {
     *      // implementation ....
     *  }
     *
     */
    
    // 协议
    Protocol *protocol;
    class_addProtocol([NSObject class], protocol);          // 添加协议 BOOL
    class_conformsToProtocol([NSObject class], protocol);   // 类是否实现指定协议 BOOL
    class_copyProtocolList([NSObject class], &outCount);    // 类实现的协议列表 Protocol*
    
    // 版本
    class_getVersion([NSObject class]);                     // 获取版本号 int
    class_setVersion([NSObject class], 8);                  // 设置版本号 void
    
}
- (void)classOperation {
    MyClass *myClass = [[MyClass alloc] init];
    unsigned int outCount = 0;
    Class cls = myClass.class;
    
    // 类名
    NSLog(@"Class name: %s", class_getName(cls));
    NSLog(@"= = = = = = = = = = = = = = = = = = = =");
    
    // 父类
    NSLog(@"Super class name: %s", class_getName(class_getSuperclass(cls)));
    NSLog(@"= = = = = = = = = = = = = = = = = = = =");
    
    // 元类
    NSLog(@"MyClass is%@ a meta-class", class_isMetaClass(cls)? @"": @"n`t");
    Class meta_class = objc_getMetaClass(class_getName(cls));
    NSLog(@"%s`s meta-class is %s", class_getName(cls), class_getName(meta_class));
    NSLog(@"= = = = = = = = = = = = = = = = = = = =");
    
    // 版本
    NSLog(@"Class version: %d", class_getVersion(cls));
    
    // 变量实例大小
    NSLog(@"Instance size: %zu", class_getInstanceSize(cls));
    NSLog(@"= = = = = = = = = = = = = = = = = = = =");
    
    // 成员变量
    Ivar *ivars = class_copyIvarList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"Instance variable`s name: %s at index %d", ivar_getName(ivar), i);
    }
    free(ivars);
    Ivar string = class_getInstanceVariable(cls, "_string");
    if (string != NULL) {
        NSLog(@"Instance variable %s", ivar_getName(string));
    }
    NSLog(@"= = = = = = = = = = = = = = = = = = = =");
    
    // 属性
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSLog(@"Property`s name: %s", property_getName(property));
    }
    free(properties);
    objc_property_t array = class_getProperty(cls, "array");
    if (array != NULL) {
        NSLog(@"Property %s", property_getName(array));
    }
    NSLog(@"= = = = = = = = = = = = = = = = = = = =");
    
    // 方法
    Method *methods = class_copyMethodList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methods[i];
        NSLog(@"Method`s signature: %@", NSStringFromSelector(method_getName(method)));
    }
    free(methods);
    Method method1 = class_getInstanceMethod(cls, @selector(method1));
    if (method1 != NULL) {
        NSLog(@"Method %@", NSStringFromSelector(method_getName(method1)));
    }
    Method classMethod = class_getClassMethod(cls, @selector(classMethod));
    if (classMethod != NULL) {
        NSLog(@"Class method: %@", NSStringFromSelector(method_getName(classMethod)));
    }
    NSLog(@"MyClass is%@ responsed to selector: method3WithArg1:arg2:", class_respondsToSelector(cls, @selector(method3WithArg1:arg2:))? @"": @"n`t");
    IMP imp = class_getMethodImplementation(cls, @selector(method1));
    imp();
    NSLog(@"= = = = = = = = = = = = = = = = = = = =");
    
    // 协议
    Protocol * __unsafe_unretained *protocols = class_copyProtocolList(cls, &outCount);
    Protocol *protocol;
    for (int i = 0; i < outCount; i++) {
        protocol = protocols[i];
        NSLog(@"Protocol name: %s", protocol_getName(protocol));
    }
    NSLog(@"MyClass is%@ responsed to protocol %s", class_conformsToProtocol(cls, protocol)? @"": @"n`t", protocol_getName(protocol));
    
}

// 动态创建类和对象
- (void)dynamicCreateContent {
    // 实例方法和实例变量应该添加到类自身上，而类方法应该添加到类的元类上
    // 创建一个新类和元类 Class，extraBytes通常指定为0，该参数是分配给类和元类对象尾部的索引ivars的字节数
    Class newClass = objc_allocateClassPair([NSObject class], "NewClass", 0);
    // 销毁一个类及相关联的类 void，如果程序运行中还存在类或其子类的实例，则不能调用针对类调用该方法
    objc_disposeClassPair(newClass);
    // 在应用中注册由objc_allocateClassPair创建的类 void
    objc_registerClassPair(newClass);
    
    // 创建类实例 id (MRC)
//    class_createInstance(Class cls, size_t extraBytes);
    // 在指定位置创建类实例 id (MRC)
//    objc_constructInstance(Class cls, void *bytes);
    // 销毁类实例 void* (MRC)
//    objc_destructInstance(id obj);
    
}
- (void)dynamicCreate {
    Class cls = objc_allocateClassPair([MyClass class], "MySubClass", 0);               // 创建类MySubClass及元类，继承自MyClass
    class_addMethod(cls, NSSelectorFromString(@"subMethod"), (IMP)subMethod, "v@:");    // 为类添加subMethod方法
    class_replaceMethod(cls, NSSelectorFromString(@"method1"), (IMP)subMethod, "v@:");  // 用subMethod方法的实现替换method1方法的实现
    class_addIvar(cls, "_ivar1", sizeof(NSString *), log2(sizeof(NSString *)), "@");    // 添加变量
    
    objc_property_attribute_t type = {"T", "@\"NSString\""};
    objc_property_attribute_t ownerShip = {"C", ""};
    objc_property_attribute_t backingIvar = {"V", "_ivar1"};
    objc_property_attribute_t attrs[] = {type, ownerShip, backingIvar};
    
    class_addProperty(cls, "property2", attrs, 3);                                      // 添加属性
    objc_registerClassPair(cls);                                                        // 注册MySubClass类
    
    id instance = [[cls alloc] init];
    SuppressPerformSelectorLeakWarning(
        [instance performSelector: NSSelectorFromString(@"subMethod")];                 // 执行类的subMethod方法
    );
    SuppressPerformSelectorLeakWarning(
        [instance performSelector: NSSelectorFromString(@"method1")];                   // 执行类的method1方法
    );
}

- (void)instanceOperationFouctionContent {
    // 返回指定对象的一份拷贝 id (MRC)
//    object_copy(id obj, size_t size);
    // 释放指定对象占用的内存id (MRC)
//    object_dispose(id obj);
    
    // 修改类实例的实例变量的值 Ivar (MRC)
//    object_setInstanceVariable(id obj, const char *name, void *value);
    // 获取对象实例变量的值 Ivar (MRC)
//    object_getInstanceVariable(id obj, const char *name, void **outValue);
    // 返回指向给定对象分配的任何额外字节的指针 void* (MRC)
//    object_getIndexedIvars(id obj);
    // 返回对象中实例变量的值 id
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList([NSObject class], &outCount);
    Ivar ivar = ivars[0];
    object_getIvar([NSObject class], ivar);
    // 设置对象中实例变量的值 void
    object_setIvar([NSObject class], ivar, @"");
    
    // 返回给定对象的类名 const char*
    object_getClassName([NSObject new]);
    // 返回对象的类 Class
    object_getClass([NSObject new]);
    // 设置对象的类
    object_setClass([NSObject new], [NSObject class]);
    
    // 获取已注册的类定义的列表 int
    objc_getClassList(NULL, 0);
    // 创建并返回一个指向所有已注册类的列表指针 Class*
//    objc_copyClassList(unsigned int *outCount);
    // 返回指定类的类定义 Class
    objc_lookUpClass("NSObject");
    objc_getClass("NSObject");
    objc_getRequiredClass("NSObject");
    // 返回指定类的元类 Class
    objc_getMetaClass("NSObject");
    
};
- (void)operationFouction {
    int numClasses;
    Class classes[9999];
    
    numClasses = objc_getClassList(NULL, 0);
    if (numClasses > 0) {
        numClasses = objc_getClassList(classes, numClasses);
        
        NSLog(@"Number of classes: %d", numClasses);
        
        for (int i = 0; i < 10; i++) {
            Class cls = classes[i];
            NSLog(@"Class name: %s", class_getName(cls));
        }
//        free(classes);
    }
};

@end


