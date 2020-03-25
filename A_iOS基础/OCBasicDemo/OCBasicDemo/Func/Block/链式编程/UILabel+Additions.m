//
//  UILabel+Additions.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/11/27.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "UILabel+Additions.h"

@implementation UILabel (Additions)

// 返回一个 Block 类型变量
+(UILabel * _Nonnull (^)(CGRect))label {
    // Block 申明 及 实现
    return ^(CGRect rect){
        return [[UILabel alloc] initWithFrame:rect];
    };
}

-(UILabel * _Nonnull (^)(UIColor * _Nonnull))titleColor{
    return ^(UIColor *clr){
        self.textColor = clr;
        return self;
    };
}

-(UILabel * _Nonnull (^)(UIColor * _Nonnull))bgColor {
    return ^(UIColor *clr){
        self.backgroundColor = clr;
        return self;
    };
}

@end
