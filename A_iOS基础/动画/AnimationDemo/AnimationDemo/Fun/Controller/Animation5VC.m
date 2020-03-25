//
//  Animation5VC.m
//  AnimationDemo
//
//  Created by hnbwyh on 2018/8/22.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "Animation5VC.h"
#import "UIImageView+JXImageView.h"
#import "UIImage+Addition.h"


@interface Animation5VC ()

@property (nonatomic,strong) UIView *fv;
@property (nonatomic,strong) UIView *sv;

@end

@implementation Animation5VC

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect rect = CGRectMake(30, 100, 200, 100);
    _fv = [[UIView alloc] initWithFrame:rect];
    _sv = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 180, 80)];
    _fv.backgroundColor = [UIColor redColor];
    _sv.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:_fv];
    [_fv addSubview:_sv];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _fv.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0);
    for (UIView *v in _fv.subviews) {
        v.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0);
    }
}

@end
