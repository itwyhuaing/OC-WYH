//
//  FunctionTipView.h
//  YHCALayerProject
//
//  Created by hnbwyh on 17/2/7.
//  Copyright © 2017年 hnbwyh. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 参考< http://www.jianshu.com/p/50c46c72e3dd > 及 公司项目 hnb主App
 * 功能指引 ：采用镂空 + 透明图片 的方式展示
 * 其中镂空效果支持 ： 方形 or 圆形  ； 实线 or 虚线
 * 所需要的主要参数 ：镂空相对于 window 的坐标 ，透明图片相对于 window 的坐标 ， 图片名称
 * 注意 ： 因为蒙层铺满整个屏幕，所以传入的坐标需要是相对于 window 的坐标
 */


/**< 交互代理方法>*/
@class FunctionTipView;
@protocol FunctionTipViewDelegate <NSObject>
@optional
- (void)functionTipView:(FunctionTipView *)tipView didTouchEvent:(UITouch *)touch;

@end

/**< 镂空部分形状样式 - 圆形 or 方形>*/
typedef enum : NSUInteger {
    CircleType = 100,
    SquareType,
} ShapeType;

/**< 镂空部分线条样式 - 实线 or 虚线>*/
typedef enum : NSUInteger {
    DashLineType = 200,
    SolidLineType,
} LineType;

@interface FunctionTipView : UIView

- (instancetype)initWithHollowRectA:(CGRect)rectA tipRectB:(CGRect)rectB;

@property (nonatomic,weak) id<FunctionTipViewDelegate> delegate;
@property (nonatomic,assign) ShapeType shapeType;
@property (nonatomic,assign) LineType lineType;
@property (nonatomic,copy) NSString *tipImageName;

@property (nonatomic,assign) CGRect hollowRect;
@property (nonatomic,assign) CGRect tipRect;

@end
