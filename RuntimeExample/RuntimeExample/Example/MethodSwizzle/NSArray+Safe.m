//
//  NSArray+Safe.m
//  RuntimeExample
//
//  Created by Joe on 2019/5/29.
//  Copyright © 2019年 tony. All rights reserved.
//

#import "NSArray+Safe.h"
#import "objc/runtime.h"

@implementation NSArray (Safe)

/*
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeArrayObjectAtIndex:)];
    });
}

- (void)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector {
    Class cls = [self class];
    
    Method originalMethod = class_getInstanceMethod(cls, origSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    
    BOOL didAddMethod = class_addMethod(cls,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(cls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (id)safeArrayObjectAtIndex:(NSInteger)index {
    if(index<[self count]){
        return [self safeArrayObjectAtIndex:index];
    }else{
        NSLog(@"index is beyond bounds ");
    }
    return nil;
}
*/


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeArrayObjectAtIndex:)];
    });
}

- (void)swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector {
    /*
     这是因为Method Swizzling对NSArray这些的类簇是不起作用的。因为这些类簇类，其实是一种抽象工厂的设计模式。抽象工厂内部有很多其它继承自当前类的子类，抽象工厂类会根据不同情况，创建不同的抽象对象来进行使用。例如我们调用NSArray的objectAtIndex:方法，这个类会在方法内部判断，内部创建不同抽象类进行操作。
     所以也就是我们对NSArray类进行操作其实只是对父类进行了操作，在NSArray内部会创建其他子类来执行操作，真正执行操作的并不是NSArray自身，所以我们应该对其“真身”进行操作。
     */
    Class cls = [self class];
    
    //Method originalMethod = class_getInstanceMethod(cls, origSelector);
    //Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    
    Method originalMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), origSelector);
    Method swizzledMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), newSelector);
    
    BOOL didAddMethod = class_addMethod(cls,
                                        origSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(cls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (id)safeArrayObjectAtIndex:(NSInteger)index {
    if(index<[self count]){
        return [self safeArrayObjectAtIndex:index];
    }else{
        NSLog(@"index is beyond bounds ");
    }
    return nil;
}


@end
