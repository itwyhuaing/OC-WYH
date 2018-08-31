//
//  Animation1VC.m
//  AnimationDemo
//
//  Created by hnbwyh on 2018/8/22.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "Animation1VC.h"

@interface Animation1VC ()

@property (nonatomic,strong) UIImageView *firstV;
@property (nonatomic,strong) UIImageView *secondV;
@property (nonatomic,assign) CGRect      firstRect;
@property (nonatomic,assign) CGRect      secondRect;

@property (nonatomic,assign) CGFloat     gap;
@property (nonatomic,assign) CGFloat     imgWH;

@end

@implementation Animation1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // 参数初始化
    self.gap    = 20.f;
    self.imgWH  = 160.f;
    
    // 布局
    CGRect rct = CGRectZero;
    rct.size   = CGSizeMake(self.imgWH, self.imgWH);
    rct.origin = CGPointMake(self.gap, 100);
    [self.firstV setFrame:rct];
    
    rct.origin.x = CGRectGetMaxX(self.firstV.frame) + self.gap;
    [self.secondV setFrame:rct];
    
    // 赋值
    self.firstV.image       = [UIImage imageNamed:@"11"];
    self.secondV.image      = [UIImage imageNamed:@"22"];
    
    // 视图添加
    [self.view addSubview:self.firstV];
    [self.view addSubview:self.secondV];
    
    // 手势添加
    UIPanGestureRecognizer *pan1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan1:)];
    UIPanGestureRecognizer *pan2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan2:)];
    self.firstV.userInteractionEnabled          = TRUE;
    self.secondV.userInteractionEnabled         = TRUE;
    [self.firstV addGestureRecognizer:pan1];
    [self.secondV addGestureRecognizer:pan2];
    
    // 取初始值
    self.firstRect      = self.firstV.frame;
    self.secondRect     = self.secondV.frame;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //self.view.backgroundColor           = [UIColor redColor];
}


#pragma mark ------ 手势

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // CATransform3D tf = CATransform3DIdentity;

}

- (void)pan1:(UIPanGestureRecognizer *)pan{
    NSLog(@"\n \n %s \n \n ",__FUNCTION__);
}

- (void)pan2:(UIPanGestureRecognizer *)pan{
    
    UIImageView *v2     = (UIImageView *)pan.view;
    CGPoint curPoint    = [pan translationInView:v2.superview];
    //NSLog(@"\n%s\n(%f) - (%f)\n",__FUNCTION__,curPoint.x,curPoint.y);
    if (curPoint.x < 0) {
        // 移动 v2 试图 - 只向左侧移动切留有间距
        CGRect rct2 = self.secondRect;
        //NSLog(@"\n\n(%f)-(%f)\n\n",rct2.origin.x,curPoint.x);
        rct2.origin.x += curPoint.x;
        if (rct2.origin.x >= self.gap * 2.0) {
            [v2 setFrame:rct2];
        }
        
        // v1 做缩放动画
        if (0-curPoint.x >= self.gap) { // 0 - 140 (1.0 - 0.8)
            CGFloat tmp     = (0 - curPoint.x - self.gap)/(self.imgWH - self.gap);
            CGFloat scale   = 1.0 - tmp * 0.2;
            NSLog(@"\n(%f)\n",scale);
            self.firstV.alpha                   = 1 -  tmp * 0.5;
            
            // x y z
            self.firstV.layer.transform         = CATransform3DMakeScale(1 -  tmp * 0.2, 1 -  tmp * 0.2, 1);
        }
    }
}


#pragma mark - lazy load

-(UIImageView *)firstV{
    if (!_firstV) {
        _firstV = [[UIImageView alloc] init];
        _firstV.layer.masksToBounds = TRUE;
        _firstV.layer.cornerRadius  = 6.0f;
        _firstV.backgroundColor = [UIColor redColor];
    }
    return _firstV;
}

-(UIImageView *)secondV{
    if (!_secondV) {
        _secondV = [[UIImageView alloc] init];
        _secondV.layer.masksToBounds = TRUE;
        _secondV.layer.cornerRadius  = 6.0f;
        _secondV.backgroundColor = [UIColor cyanColor];
    }
    return _secondV;
}

@end
