//
//  UIView+JXView.m
//  JXObjCategary
//
//  Created by hnbwyh on 2018/9/4.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "UIView+JXView.h"

@implementation UIView (JXView)

+ (UIView *)cardStyleView{
/** 设置阴影是通过 layer 属性其核心代码
  shadowColor       - 阴影颜色
  shadowOpacity     - 阴影透明度
  shadowRadius      - 阴影半径
  这里需要注意的是：
  shadowOffset      - 阴影偏移
  layer.masksToBounds 的设置 TRUE 之后会消除阴影效果；但 clipsToBounds 属性对阴影效果无影响
 */
    UIView *card                  = [UIView new];
    card.backgroundColor          = [UIColor whiteColor];
    card.layer.shadowColor        = [UIColor colorWithWhite:0.3 alpha:1.0].CGColor;
    card.layer.shadowOpacity      = 0.8;
    card.layer.shadowRadius       = 6.0;
    card.layer.shadowOffset       = CGSizeMake(8.0, 8.0);
    return card;
}

+(UIView *)gradeColorViewWithFrame:(CGRect)rect{
    UIView *rlt = [[UIView alloc] initWithFrame:rect];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)[UIColor blackColor].CGColor, (__bridge id)[UIColor blackColor].CGColor, (__bridge id)[UIColor whiteColor].CGColor];
    gradientLayer.locations = @[@0.1, @0.2,@1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    [rlt.layer addSublayer:gradientLayer];
    return rlt;
}


@end
