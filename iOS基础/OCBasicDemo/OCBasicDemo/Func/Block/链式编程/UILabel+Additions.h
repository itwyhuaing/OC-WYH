//
//  UILabel+Additions.h
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/11/27.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Additions)

+ (UILabel *(^)(CGRect rect))label;

- (UILabel *(^)(UIColor *clr))titleColor;

- (UILabel *(^)(UIColor *clr))bgColor;

@end

NS_ASSUME_NONNULL_END
