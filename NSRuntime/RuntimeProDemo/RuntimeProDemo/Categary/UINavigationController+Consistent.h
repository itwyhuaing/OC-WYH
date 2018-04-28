//
//  UINavigationController+Consistent.h
//  RuntimeProDemo
//
//  Created by hnbwyh on 2018/2/1.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import <UIKit/UIKit.h>

static char const * const ObjectTagKey = "ObjectTag";
@interface UINavigationController (Consistent)

@property (readwrite,getter = isViewTransitionInProgress) BOOL viewTransitionInProgress;

@end
