//
//  UIView+Title.m
//  RuntimeExample
//
//  Created by Joe on 2019/5/29.
//  Copyright © 2019年 tony. All rights reserved.
//

#import "UIView+Title.h"
#import "objc/runtime.h"

@implementation UIView (Title)

- (void)setTitle:(NSString *)title {
    objc_setAssociatedObject(self, @"title", title, OBJC_ASSOCIATION_COPY);
}

- (NSString *)title {
    return objc_getAssociatedObject(self, @"title");
}

@end
