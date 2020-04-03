//
//  UIAdapter.m
//  hinabian
//
//  Created by hnbwyh on 2019/6/20.
//  Copyright © 2019 深圳市海那边科技有限公司. All rights reserved.
//

#import "UIAdapter.h"

@implementation UIAdapter

+ (CGFloat)deviceWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)deviceHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (BOOL)device4_7Inch {
    BOOL rlt = FALSE;
    CGRect rct = [UIScreen mainScreen].bounds;
    CGFloat w = CGRectGetWidth(rct);
    CGFloat h = CGRectGetHeight(rct);
    if (w == 375.0 && h == 667.0) {
        rlt = TRUE;
    }
    return rlt;
}


+ (BOOL)device5_5Inch {
    BOOL rlt = FALSE;
    CGRect rct = [UIScreen mainScreen].bounds;
    CGFloat w = CGRectGetWidth(rct);
    CGFloat h = CGRectGetHeight(rct);
    if (w == 414.0 && h == 736.0) {
        rlt = TRUE;
    }
    return rlt;
}


+ (BOOL)device5_8Inch {
    BOOL rlt = FALSE;
    CGRect rct = [UIScreen mainScreen].bounds;
    CGFloat w = CGRectGetWidth(rct);
    CGFloat h = CGRectGetHeight(rct);
    if (w == 375.0 && h == 812.0) {
        rlt = TRUE;
    }
    return rlt;
}


+ (BOOL)device6_1Inch {
    BOOL rlt = FALSE;
    CGRect rct = [UIScreen mainScreen].bounds;
    CGFloat w = CGRectGetWidth(rct);
    CGFloat h = CGRectGetHeight(rct);
    if ((w == 414.0 && h == 896.0) && [UIScreen mainScreen].scale == 2.0) {
        rlt = TRUE;
    }
    return rlt;
}


+ (BOOL)device6_5Inch {
    BOOL rlt = FALSE;
    CGRect rct = [UIScreen mainScreen].bounds;
    CGFloat w = CGRectGetWidth(rct);
    CGFloat h = CGRectGetHeight(rct);
    if ((w == 414.0 && h == 896.0) && [UIScreen mainScreen].scale == 3.0) {
        rlt = TRUE;
    }
    return rlt;
}


+ (BOOL)isTidyTopScreen {
    BOOL rlt = FALSE;
    rlt = ([UIAdapter device5_8Inch] || [UIAdapter device6_1Inch] || [UIAdapter device6_5Inch]);
    return rlt;
}

+ (CGFloat)statusHeight {
    CGFloat rlt = [self isTidyTopScreen] ? 44.0 : 20.0;
    return rlt;
}

+ (CGFloat)navHeight {
    return 44.0;
}

+ (CGFloat)tabBarHeight {
    return 49.0;
}


+ (CGFloat)heightToSuitScreenBootom {
    CGFloat h = 0.0;
    if ([UIAdapter isTidyTopScreen]) {
        h = 34.0f;
    }
    return h;
}

+(CGFloat)scaleBy375W {
    CGFloat rlt = 1.0;
    CGFloat realW = [UIScreen mainScreen].bounds.size.width;
    rlt = realW/375.0;
    return rlt;
}

+(CGFloat)scaleBy414W {
    CGFloat rlt = 1.0;
    CGFloat realW = [UIScreen mainScreen].bounds.size.width;
    rlt = realW/414.0;
    return rlt;
}


+ (CGFloat)heightForExTopAndBottom{
    return [self deviceHeight] - [self statusHeight] - [self navHeight] - [self heightToSuitScreenBootom] - [self tabBarHeight];
}

@end
