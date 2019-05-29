//
//  UIViewController+Track.h
//  RuntimeExample
//
//  Created by Joe on 2019/5/29.
//  Copyright © 2019年 tony. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Track)

- (void)track_viewWillAppear:(BOOL)animated;
- (void)track_viewDidAppear:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
