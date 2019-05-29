//
//  NSMutableArray+Safe.m
//  RuntimeExample
//
//  Created by Joe on 2019/5/29.
//  Copyright © 2019年 tony. All rights reserved.
//

#import "NSMutableArray+Safe.h"
#import "objc/runtime.h"

@implementation NSMutableArray (Safe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        id obj = [[self alloc] init];
        [obj swizzleMethod:@selector(addObject:) withMethod:@selector(safeMutableArrayAddObject:)];
        [obj swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(safeMutableArrayObjectAtIndex:)];
        [obj swizzleMethod:@selector(removeObjectAtIndex:) withMethod:@selector(safeMutableArrayRemoveObjectAtIndex:)];
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
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)safeMutableArrayAddObject:(id)anObject {
    if (anObject) {
        [self safeMutableArrayAddObject:anObject];
    }else{
        NSLog(@"obj is nil");
    }
}

- (id)safeMutableArrayObjectAtIndex:(NSInteger)index {
    if(index<[self count]){
        return [self safeMutableArrayObjectAtIndex:index];
    }else{
        NSLog(@"index is beyond bounds ");
    }
    return nil;
}

- (void)safeMutableArrayRemoveObjectAtIndex:(NSUInteger)index {
    if (index >= [self count]) {
        return;
    }
    
    return [self safeMutableArrayRemoveObjectAtIndex:index];
}

@end
