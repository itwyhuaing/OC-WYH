//
//  YHChartLine.m
//  YHChartViewDemo
//
//  Created by wyh on 15/12/22.
//  Copyright © 2015年 lachesismh. All rights reserved.
//


#import "YHChartLine.h"

@interface YHChartLine ()

@property (nonatomic,assign) id<YHChartLineDelegate> delegate;

@property (nonatomic,retain) UIView *baseView; // superView

@property (nonatomic,retain) NSArray *xMarks;  // x 标度数组

@property (nonatomic,retain) NSArray *yMarks; // y 标度数组

@property (nonatomic,retain) NSArray *yValues; // y 标度数组

@property (nonatomic,assign) CGFloat xAxisSpace;

@property (nonatomic,assign) CGFloat yAxisSpace;

@property (nonatomic,assign) CGPoint coordinateSystemOrigin;

@end


@implementation YHChartLine

#pragma mark -  =============== 外部可调用

-(id)initWithFrame:(CGRect)rect pointsShowStyle:(YHChartLinePointsShowStyle)pointsShowStyle delegate:(id<YHChartLineDelegate>)delegate{
    self = [super initWithFrame:rect];
    if (self) {
        
        self.pointsShowStyle = pointsShowStyle;
        self.delegate = delegate;
        
        [self loadDefaultPropertys];
        
    }
    return self;
}

- (void)showInView:(UIView *)view{

    [self reSetLayoutForNewFrame:self.bounds];
    
    [view addSubview:self];
}

-(void)reSetLayoutForNewFrame:(CGRect)rect{

    [self drawCoordinateSystem];
    
}

- (void)reFreshChartLine:(YHChartLinePointsShowStyle)pointsShowStyle drawView:(UIView *)view{
    
    [self drawCoordinateSystem];
}

-(void)markAreaWithRange{

}

- (void)markLineWithValue{

}

#pragma mark -  =============== selfMethods

#pragma mark－ loadDefaultPropertys
- (void)loadDefaultPropertys{
    
    self.gridTyle = YHChartLineGridHorizontalAndVertical;
    self.isMarkMvaule = NO;
    self.axisColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor];
    self.axisWidth = 1;
    self.axisTyle = YHChartLineSquareSolid;
    self.gridLineColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
    self.gridLineWidth = 1;
    self.gridLineTyle = YHChartLineSquareSolid;
    self.curveColor = [UIColor blackColor].CGColor;
    self.curveWidth = 1;
    self.curveTyle = YHChartLineSquareSolid;
    self.lineDashPattern = @[@8,@8];;
    self.isAnimation = NO;
    self.xAxisLableSize = CGSizeMake(15, 15);
    self.yAxisLableSize = CGSizeMake(30, 15);
    self.axisMarkLableFont = [UIFont systemFontOfSize:10.0];
    self.axisMarkLableColor = [UIColor grayColor];
    self.isAutoAdjustRectForAxisMarkLable = YES;
    self.axisUnitLableSize = CGSizeMake(35, 20);
    self.axisUnitLableFont = [UIFont systemFontOfSize:12.0];
    self.axisUnitLableColor = [UIColor grayColor];
    self.isAutoAdjustRectForAxisUnitLable = YES;
    
     // 坐标系原点
    self.coordinateSystemOrigin = CGPointMake(self.yAxisLableSize.width,
                                              self.bounds.size.height - self.xAxisLableSize.height);
    
    
}

#pragma mark－ drawCoordinate 坐标系
- (void)drawCoordinateSystem{
    
    // X 标度
    if ([self.delegate respondsToSelector:@selector(chartLineXAxisMarks)]) {
        self.xMarks = [self.delegate chartLineXAxisMarks];
        [self drawXAxis];
    }
    
    // Y 标度
    if ([self.delegate respondsToSelector:@selector(chartLineYAxisMarks)]) {
        self.yMarks = [self.delegate chartLineYAxisMarks];
        [self drawYAxis];
    }
    
    if (self.pointsShowStyle == YHChartLinePointsShowCurve) {
        
        // Y 值数组
        if ([self.delegate respondsToSelector:@selector(chartLineYValuesForPoints)]) {
            self.yValues = [self.delegate chartLineYValuesForPoints];
        }
        
        [self drawPointsToCoordinateSystem];
        
    } else {
        
        
        
        [self ShowPointSetOnCoordinateSystem];
        
    }
    
    
    
}

- (void)drawXAxis{

    self.xAxisSpace = (self.bounds.size.width - self.yAxisLableSize.width - self.axisUnitLableSize.width) / (self.xMarks.count - 1);
    
    //标度
    CGRect rect = CGRectZero;
    rect.size = self.xAxisLableSize;
    CGPoint center = CGPointZero;
    for (NSInteger cou = 0; cou < self.xMarks.count; cou ++) {
        center.x = self.coordinateSystemOrigin.x + self.xAxisSpace * cou;
        center.y = self.coordinateSystemOrigin.y + rect.size.height / 2.0;
        UILabel *xLable = [self createLableWithFrame:rect];
        xLable.textAlignment = NSTextAlignmentLeft;
        xLable.text = self.xMarks[cou];
        xLable.font = self.axisMarkLableFont;
        xLable.textColor = self.axisMarkLableColor;
        if (self.isAutoAdjustRectForAxisMarkLable) {
            [self autoAdjustRectOfLable:xLable];
        }
        [xLable setCenter:center];
        rect = xLable.frame; // 纪录后方便单位lable 的位置计算
        
        // 竖线
        if (self.gridTyle == YHChartLineGridHorizontalAndVertical) {
            UIBezierPath *path = [UIBezierPath bezierPath];
            center.y = self.coordinateSystemOrigin.y;
            [path moveToPoint:center];
            [path addLineToPoint:CGPointMake(center.x, self.axisUnitLableSize.height + self.yAxisLableSize.height/2.0)];
            [path closePath];
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = path.CGPath;
            if (0 == cou) { // 轴线
                shapeLayer.strokeColor = self.axisColor;
                shapeLayer.lineWidth = self.axisWidth;
            }else{
                shapeLayer.strokeColor = self.gridLineColor;
                shapeLayer.lineWidth = self.gridLineWidth;
            }
            shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
            [self.layer addSublayer:shapeLayer];
        }
    
    }
    
    // 绘制单位显示 Lable
    rect.size = self.axisUnitLableSize;
    rect.origin.x = center.x;
    rect.origin.y = self.bounds.size.height - self.xAxisLableSize.height - self.axisUnitLableSize.height;
    UILabel *xAxisUnitLable = [self createLableWithFrame:rect];
    xAxisUnitLable.text = @"日期";
    xAxisUnitLable.font = self.axisUnitLableFont;
    xAxisUnitLable.textColor = self.axisUnitLableColor;
    // 尺寸自适应
    if (self.isAutoAdjustRectForAxisUnitLable) {
        [self autoAdjustRectOfLable:xAxisUnitLable];
    }
}


- (void)drawYAxis{
    
    self.yAxisSpace = (self.bounds.size.height - self.xAxisLableSize.height - self.axisUnitLableSize.height - self.yAxisLableSize.height/2.0) / (self.yMarks.count - 1);
    
    CGRect rect = CGRectZero;
    rect.size = self.yAxisLableSize;
    CGPoint center = CGPointZero;
    for (NSInteger cou = 0; cou < self.yMarks.count; cou ++) {
        center.y = self.coordinateSystemOrigin.y - self.yAxisSpace * cou;
        center.x = self.yAxisLableSize.width / 2.0;
        UILabel *yLable = [self createLableWithFrame:rect];
        yLable.textAlignment = NSTextAlignmentCenter;
        NSNumber *num = self.yMarks[cou];
        yLable.text = [NSString stringWithFormat:@"%@",num];
        yLable.font = self.axisMarkLableFont;
        yLable.textColor = self.axisMarkLableColor;
        yLable.textAlignment = NSTextAlignmentCenter;
        if (0 == cou) {
            center.y -= 5;
            yLable.center = center;
            center.y += 5;
        }else{
            yLable.center = center;
        }
        
        rect = yLable.frame; // 纪录后方便单位lable 的位置计算
        // 绘制横线
        if (self.gridTyle == YHChartLineGridHorizontal || self.gridTyle == YHChartLineGridHorizontalAndVertical) {
            
            center.x += 15;
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:center];
            [path addLineToPoint:CGPointMake(self.yAxisLableSize.width + self.xAxisSpace * (self.xMarks.count - 1), center.y)];
            [path closePath];
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = path.CGPath;
            if (0 == cou) { // 轴线
                shapeLayer.strokeColor = self.axisColor;
                shapeLayer.lineWidth = self.axisWidth;
            }else{
                shapeLayer.strokeColor = self.gridLineColor;
                shapeLayer.lineWidth = self.gridLineWidth;
            }
            shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
            [self.layer addSublayer:shapeLayer];
        }
    }
    
    // 绘制单位显示 Lable
    rect.size = self.axisUnitLableSize;
    rect.origin.y = (rect.origin.y > self.axisUnitLableSize.height) ? (rect.origin.y - self.axisUnitLableSize.height) : (0);
    UILabel *yAxisUnitLable = [self createLableWithFrame:rect];
    yAxisUnitLable.backgroundColor = [UIColor clearColor];
    yAxisUnitLable.text = @"mml/d";
    yAxisUnitLable.font = self.axisUnitLableFont;
    yAxisUnitLable.textColor = self.axisUnitLableColor;
    // 尺寸自适应
    if (self.isAutoAdjustRectForAxisUnitLable) {
        [self autoAdjustRectOfLable:yAxisUnitLable];
    }
}

#pragma mark－ drawPointsToCoordinateSystem 显示数据

- (void)drawPointsToCoordinateSystem{
    
   // 折线实线  折线虚线  圆滑实线  圆滑虚线
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat coordinateSystemYHeight = self.bounds.size.height - self.axisUnitLableSize.height - self.xAxisLableSize.height - self.yAxisLableSize.height / 2.0;
    CGFloat yMax = [[self.yMarks lastObject] floatValue];
    CGFloat yMin = [[self.yMarks firstObject] floatValue];
    CGPoint point = CGPointZero;
    for (NSInteger cou = 0; cou < self.yValues.count; cou ++) {
        CGFloat y = [[self.yValues objectAtIndex:cou] floatValue];
        CGFloat y_offset = (y - yMin) / (yMax - yMin) * coordinateSystemYHeight;
        point.x = self.yAxisLableSize.width + self.xAxisSpace * cou;
        point.y = self.coordinateSystemOrigin.y - y_offset;
        // 设置点的视图
        UILabel *lable = [self createLableWithFrame:CGRectMake(0, 0, 10, 10)];
        lable.backgroundColor = [UIColor redColor];
        lable.center = point;
        
        if (cou == 0) {
            [path moveToPoint:point];
        }else{
            [path addLineToPoint:point];
        }
        
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [[UIColor blackColor] CGColor]; //[[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    shapeLayer.lineWidth = 1;
    self.curveTyle = YHChartLineSquareDash;
    if (self.curveTyle == YHChartLineRoundDash || self.curveTyle == YHChartLineSquareDash) { // 虚线
    
        shapeLayer.lineDashPattern = self.lineDashPattern;
        
    }else if (self.curveTyle == YHChartLineRoundSolid || self.curveTyle == YHChartLineSquareSolid){ // 实线
    
        shapeLayer.lineDashPattern = nil;
        
    }
    [self.layer addSublayer:shapeLayer];
    
}

#pragma mark－YHChartLinePointsShowPointSet 点的集合

- (void)ShowPointSetOnCoordinateSystem{

    NSLog(@"重新加载数据");
    
}

#pragma mark - 创建 UILable

- (UILabel *)createLableWithFrame:(CGRect)rect{

    UILabel *lable = [[UILabel alloc] initWithFrame:rect];
    [self addSubview:lable];
//    lable.backgroundColor = [UIColor yellowColor];
    return lable;
}

#pragma mark - Lable赋值时的 宽度自适应
- (void)autoAdjustRectOfLable:(UILabel *)lable
{
    CGSize boundingSize = CGSizeMake(10000, lable.bounds.size.height);
    NSDictionary *dic = @{NSFontAttributeName : lable.font};
    CGRect textRect = [lable.text boundingRectWithSize:boundingSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:NULL];
    CGRect lableRect = lable.frame;
    lableRect.size = textRect.size;
    [lable setFrame:lableRect];
}

@end
