//
//  YHChartLine.h
//  YHChartViewDemo
//
//  Created by wyh on 15/12/22.
//  Copyright © 2015年 lachesismh. All rights reserved.
//

#import "YHChart.h"

//  坐标点显示类型
typedef enum : NSUInteger {
    YHChartLinePointsShowCurve,
    YHChartLinePointsShowPointSet,
} YHChartLinePointsShowStyle;

//  坐标系中网格显示类型
typedef enum : NSUInteger {
    YHChartLineGridNone,                    // 既无横线又无竖线
    YHChartLineGridHorizontal,              // 只有横线
    YHChartLineGridHorizontalAndVertical,   // 既有横线又有竖线
} YHChartLineGridTyle;

//// 绘制曲线的类型
//typedef enum : NSUInteger {
//    YHChartLineCurveSquareSolid,      // 折线 实线
//    YHChartLineCurveSquareDash,      // 折线 虚线
//    YHChartLineCurveRoundSolid,      // 圆滑 实线
//    YHChartLineCurveRoundDash,      // 圆滑 虚线
//} YHChartLineCurveStyle;


// 线条类型
typedef enum : NSUInteger {
    YHChartLineSquareSolid,      // 折线 实线
    YHChartLineSquareDash,      // 折线 虚线
    YHChartLineRoundSolid,      // 圆滑 实线
    YHChartLineRoundDash,      // 圆滑 虚线
} YHChartLineStyle;


@class YHChartLine;

@protocol YHChartLineDelegate <NSObject>

/**
 * X 轴标度数组
 */
- (NSArray *)chartLineXAxisMarks;

/**
 * Y 轴标度数组
 */
- (NSArray *)chartLineYAxisMarks;

/**
 * 坐标点的 Y 值数组
 */
- (NSArray *)chartLineYValuesForPoints;

@end





@interface YHChartLine : YHChart

/**
 * 网格类型
 */
@property (nonatomic,assign) YHChartLineGridTyle gridTyle;

/**
 * 绘制点的方式，默认绘制曲线
 * pointsShowStyle 
 */
@property (nonatomic,assign) YHChartLinePointsShowStyle pointsShowStyle;

/**
 * 最值标记与否
 */
@property (nonatomic,assign) BOOL isMarkMvaule;

/**
 * 坐标轴线的设置
 * axisColor , axisWidth , axisTyle
 */
@property (nonatomic,assign) CGColorRef axisColor;
@property (nonatomic,assign) CGFloat axisWidth;
@property (nonatomic,assign) YHChartLineStyle axisTyle;

/**
 * 网格线的设置
 * gridLineColor , gridLineWidth , gridLineTyle
 */
@property (nonatomic,assign) CGColorRef gridLineColor;
@property (nonatomic,assign) CGFloat gridLineWidth;
@property (nonatomic,assign) YHChartLineStyle gridLineTyle;

/**
 * 所要绘制的曲线设置
 * curveColor , curveWidth , curveTyle , lineDashPattern , isAnimation
 */
@property (nonatomic,assign) CGColorRef curveColor;
@property (nonatomic,assign) CGFloat curveWidth;
@property (nonatomic,assign) YHChartLineStyle curveTyle;
@property (nonatomic,retain) NSArray<NSNumber *> *lineDashPattern; // 虚线条间距的设置
@property (nonatomic,assign) BOOL isAnimation; // 默认无动画

/**
 * 点击时 凸显 出的竖线设置
 *
 */

/**
 * 用于显示坐标轴标度的 Lable 相关设置
 * xAxisLableSize , yAxisLableSize , axisMarkLableFont , axisMarkLableColor , isAxisMarkLableAutoAdjustRect
 * 注意：lable显示部分设置了的文本自适应功能默认是打开的
 */
@property (nonatomic,assign) CGSize xAxisLableSize;
@property (nonatomic,assign) CGSize yAxisLableSize;
@property (nonatomic,retain) UIFont *axisMarkLableFont;
@property (nonatomic,retain) UIColor *axisMarkLableColor;
@property (nonatomic,assign) BOOL isAutoAdjustRectForAxisMarkLable;

/**
 * 用于显示坐标轴单位的 Lable 相关设置 - 通过宽高是否 ＝0 ，判断纵横坐标单位是否显示 
 * axisUnitLableSize , axisUnitLableFont , axisUnitLableColor , isAxisUnitLableAutoAdjustRect
 * 注意：lable显示部分设置了的文本自适应功能默认是打开的
 */
@property (nonatomic,assign) CGSize axisUnitLableSize;
@property (nonatomic,retain) UIFont *axisUnitLableFont;
@property (nonatomic,retain) UIColor *axisUnitLableColor;
@property (nonatomic,assign) BOOL isAutoAdjustRectForAxisUnitLable;

/**
 * 坐标点视图设置
 *
 */
@property (nonatomic,retain) UIView *coordinatePointView;


/**
 * 尺寸布局 及 代理
 */
- (id)initWithFrame:(CGRect)rect pointsShowStyle:(YHChartLinePointsShowStyle)pointsShowStyle delegate:(id<YHChartLineDelegate>)delegate;

/**
 * 尺寸改变时 可重新布局
 */
- (void)reSetLayoutForNewFrame:(CGRect)rect;

/**
 * 显示
 */
- (void)showInView:(UIView *)view;

/**
 * 刷新显示
 */
//- (void)reFreshChartLine:(YHChartLinePointsShowStyle)pointsShowStyle drawView:(UIView *)view;

/**
 * 区域标记
 */
- (void)markAreaWithRange;

/**
 * 线条标记
 */
- (void)markLineWithValue;

@end

/**
 * 线条类型
 */
//@property (nonatomic,assign) YHChartLineCurveStyle curveStyle;//

/**
 * 虚线条的设置
 */
//@property (nonatomic,retain) NSArray<NSNumber *> *lineDashPattern;

/**
 // * 纵坐标Lable的宽度
 // */
//@property (nonatomic,assign) CGFloat yAxisLableWidth;
//
///**
// * 纵坐标Lable的高度
// */
//@property (nonatomic,assign) CGFloat yAxisLableHeight;
//
///**
// * 纵坐标顶部单位显示Lable的高度
// */
//@property (nonatomic,assign) CGFloat yAxisUnitLableHeight;
//
///**
// * 横坐标Lable的高度
// */
//@property (nonatomic,assign) CGFloat xAxisLableHeight;
//
///**
// * 横坐标单位显示Lable的高度
// */
//@property (nonatomic,assign) CGFloat xAxisUnitLableWidth;
//
///**
// * 坐标Lable的文字大小设置
// */
//@property (nonatomic,retain) UIFont *markLableTextFont;//
//
///**
// * 坐标Lable的文字颜色设置
// */
//@property (nonatomic,retain) UIColor *markLableTextColor; //

