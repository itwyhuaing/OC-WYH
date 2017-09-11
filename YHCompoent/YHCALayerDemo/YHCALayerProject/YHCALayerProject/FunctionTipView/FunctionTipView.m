//
//  FunctionTipView.m
//  YHCALayerProject
//
//  Created by hnbwyh on 17/2/7.
//  Copyright © 2017年 hnbwyh. All rights reserved.
//

#import "FunctionTipView.h"

@interface FunctionTipView ()

//@property (nonatomic,strong) CAShapeLayer *shapeLayer;
//@property (nonatomic,strong) UIBezierPath *bezierPath;
@property (nonatomic,strong) UIImageView *tipImageView;

@end

@implementation FunctionTipView

#pragma mark ------ init

- (instancetype)initWithHollowRectA:(CGRect)rectA tipRectB:(CGRect)rectB
{
    self = [super init];
    if (self) {
    
        _hollowRect = rectA;
        _tipRect = rectB;
        _tipImageView = [[UIImageView alloc] initWithFrame:_tipRect];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6f];
        [self setFrame:[UIScreen mainScreen].bounds];
        [self addSubview:_tipImageView];
        
    }
    return self;
}

#pragma mark ------ updateUI 

- (void)updateUI{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRect:[UIScreen mainScreen].bounds];
    if (_shapeType == SquareType) {
        
        [bezierPath appendPath:[[UIBezierPath bezierPathWithRoundedRect:_hollowRect cornerRadius:0] bezierPathByReversingPath]];
        
    } else {
    
        [bezierPath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(_hollowRect.origin.x+_hollowRect.size.width/2.f, _hollowRect.origin.y+_hollowRect.size.height/2.f)
                                                              radius:_hollowRect.size.height/2.f
                                                          startAngle:0
                                                            endAngle:2*M_PI
                                                           clockwise:NO]];
        
    }
    
    if (_lineType == DashLineType) {
        
        [shapeLayer setLineWidth:2.f];
        [shapeLayer setLineJoin:kCALineJoinRound];
        [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:6],[NSNumber numberWithInt:6], nil]];
        
    }
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    self.layer.mask = shapeLayer;
    
    [_tipImageView setFrame:_tipRect];
    
}

#pragma mark ------

- (void)setTipImageName:(NSString *)tipImageName{

    if (![_tipImageName isEqualToString:tipImageName]) {
        _tipImageName = tipImageName;
        [_tipImageView setImage:[UIImage imageNamed:_tipImageName]];
    }
    
}

-(void)setHollowRect:(CGRect)hollowRect{

    if (!CGRectEqualToRect(_hollowRect, hollowRect)) {
        _hollowRect = hollowRect;
        [self updateUI];
    }
    
}

- (void)setTipRect:(CGRect)tipRect{

    if (!CGRectEqualToRect(_tipRect, tipRect)) {
        _tipRect = tipRect;
        [self updateUI];
    }
    
}

-(void)setShapeType:(ShapeType)shapeType{
    
    _shapeType = shapeType;
    [self updateUI];
    
}

- (void)setLineType:(LineType)lineType{

    _lineType = lineType;
    [self updateUI];
    
}

#pragma mark ------ 点击事件

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    NSArray *ts = [touches allObjects];
    UITouch *t = [ts firstObject];
    if (_delegate && [_delegate respondsToSelector:@selector(functionTipView:didTouchEvent:)]) {
        
//        for (UIView *v in self.subviews) {
//            [v removeFromSuperview];
//        }
        
        [_delegate functionTipView:self didTouchEvent:t];

    }
    
}

@end
