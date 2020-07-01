//
//  LayerPathController.m
//  CALayerDemo
//
//  Created by hnbwyh on 2020/6/24.
//  Copyright © 2020 ZhiXingJY. All rights reserved.
//

#import "LayerPathController.h"

@interface LayerPathController ()

// UIImageView
@property (nonatomic,strong) UIImageView *t_imgV;
@property (nonatomic,strong) UIImageView *b_imgV;

@end

@implementation LayerPathController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self testImageView];
}

- (void)testImageView {
    [self addImageView];
    [self addlayer];
}

- (void)addImageView {
    [self.view addSubview:self.b_imgV];
    [self.view addSubview:self.t_imgV];
}

-(UIImageView *)t_imgV {
    if (!_t_imgV) {
        CGRect rect = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200);
        _t_imgV = [UIImageView new];
        [_t_imgV setFrame:rect];
        _t_imgV.image = [UIImage imageNamed:@"t"];
        _t_imgV.contentMode = UIViewContentModeScaleAspectFill;
        _t_imgV.clipsToBounds = TRUE;
    }
    return _t_imgV;
}

- (UIImageView *)b_imgV {
    if (!_b_imgV) {
        CGRect rect = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200);
        _b_imgV = [UIImageView new];
        [_b_imgV setFrame:rect];
        _b_imgV.image = [UIImage imageNamed:@"b"];
        _b_imgV.contentMode = UIViewContentModeScaleAspectFill;
        _b_imgV.clipsToBounds = TRUE;
    }
    return _b_imgV;
}

- (void)addlayer {
// 1. 绘制所需 path
    // 绘制等同于 t_imgV 的 path
    CGRect rect = self.t_imgV.frame;
    rect.origin = CGPointZero;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    // 添加 path - 贝塞尔曲线 画一个圆形
    CGPoint p = CGPointMake(rect.size.width, rect.size.height);
    [path appendPath:[UIBezierPath bezierPathWithArcCenter:p radius:rect.size.height startAngle:0 endAngle:2*M_PI clockwise:NO]];
    CAShapeLayer *slyr = [CAShapeLayer layer];
    slyr.path = path.CGPath;
// 2. 修改显示
    self.t_imgV.layer.mask = slyr;
}

@end
