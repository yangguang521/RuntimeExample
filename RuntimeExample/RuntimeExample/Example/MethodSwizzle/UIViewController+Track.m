//
//  UIViewController+Track.m
//  RuntimeExample
//
//  Created by Joe on 2019/5/29.
//  Copyright © 2019年 tony. All rights reserved.
//

#import "UIViewController+Track.h"
#import "objc/runtime.h"

@implementation UIViewController (Track)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzleMethod([self class], @selector(viewWillAppear:), @selector(track_viewWillAppear:));
        swizzleMethod([self class], @selector(viewDidAppear:), @selector(track_viewDidAppear:));
    });
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    // the method might not exist in the class, but in its superclass
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // class_addMethod will fail if original method already exists
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    // the method doesn’t exist and we just added one
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)track_viewWillAppear:(BOOL)animated {
    // call original implementation
    [self track_viewWillAppear:animated];
}

- (void)track_viewDidAppear:(BOOL)animated {
    // call original implementation
    [self track_viewDidAppear:animated];
}

@end
