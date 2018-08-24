//
//  Animation2VC.m
//  AnimationDemo
//
//  Created by hnbwyh on 2018/8/22.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "Animation2VC.h"

@interface Animation2VC ()

@property (nonatomic,strong) UIImageView        *logoImg;
@property (nonatomic,strong) UILabel            *nameLab;
@property (nonatomic,strong) UILabel            *desLab;

@end

@implementation Animation2VC

#pragma mark ------ life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addRect];
    [self addSubViews];
    [self addAttributesAndCnt];
    //[self test];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self animationDaDaLogo];
    [self animationDaDaLabel];
}

#pragma mark ------ data animation

- (void)initData{
    self.nameLab.alpha                  = 0.f;
    self.desLab.alpha                   = 0.f;
    self.nameLab.layer.transform        = CATransform3DMakeScale(0.5, 0.5, 1.0);
    self.desLab.layer.transform         = CATransform3DMakeScale(0.5, 0.5, 1.0);
}

- (void)animationDaDaLabel{
    [UIView animateWithDuration:6.5f animations:^{
        self.nameLab.alpha                  = 0.5f;
        self.desLab.alpha                   = 0.5f;
        self.nameLab.layer.transform        = CATransform3DMakeScale(1.5, 1.5, 1.0);
        self.desLab.layer.transform         = CATransform3DMakeScale(1.5, 1.5, 1.0);
    } completion:^(BOOL finished) {
        self.nameLab.alpha                  = 1.f;
        self.desLab.alpha                   = 1.f;
        self.nameLab.layer.transform        = CATransform3DMakeScale(1.f, 1.f, 1.f);
        self.desLab.layer.transform         = CATransform3DMakeScale(1.f, 1.f, 1.f);
    }];
}


- (void)animationDaDaLogo{
    
}


#pragma mark ------ init subviews

- (void)addRect{
    CGFloat sw = [UIScreen mainScreen].bounds.size.width;
    CGFloat sh = [UIScreen mainScreen].bounds.size.height;
    CGRect rect = CGRectZero;
    rect.size = CGSizeMake(80.0, 80.0);
    rect.origin.x = sw/2.0 - rect.size.width/2.0;
    rect.origin.y = sh/2.0 - rect.size.height - 60.0;
    [self.logoImg setFrame:rect];
    
    rect.size.height = 60.0;
    rect.size.width  = sw;
    rect.origin.x    = 0.0;
    rect.origin.y    = CGRectGetMaxY(self.logoImg.frame) + 16.0f;
    [self.nameLab setFrame:rect];
    
    rect.origin.y    = CGRectGetMaxY(self.nameLab.frame) + 16.0f;
    [self.desLab setFrame:rect];
}

- (void)addSubViews{
    [self.view addSubview:self.logoImg];
    [self.view addSubview:self.nameLab];
    [self.view addSubview:self.desLab];
}

- (void)addAttributesAndCnt{
    self.logoImg.contentMode            = UIViewContentModeScaleAspectFill;
    self.logoImg.clipsToBounds          = TRUE;
    self.logoImg.image                  = [UIImage imageNamed:@"1"];
    self.nameLab.text                   = @"嗒嗒";
    self.nameLab.textColor              = [UIColor redColor];
    self.nameLab.textAlignment          = NSTextAlignmentCenter;
    self.desLab.text                    = @"可靠配送，立即送达";
    self.desLab.textColor               = [UIColor redColor];
    self.desLab.textAlignment           = NSTextAlignmentCenter;
}

- (void)test{
    self.logoImg.backgroundColor        = [UIColor orangeColor];
    self.nameLab.backgroundColor        = [UIColor purpleColor];
    self.desLab.backgroundColor         = [UIColor cyanColor];
}

#pragma mark ------ lazy load

-(UIImageView *)logoImg{
    if (!_logoImg) {
        _logoImg = [[UIImageView alloc] init];
    }
    return _logoImg;
}

-(UILabel *)nameLab{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] init];
    }
    return _nameLab;
}

-(UILabel *)desLab{
    if (!_desLab) {
        _desLab = [[UILabel alloc] init];
    }
    return _desLab;
}

@end
