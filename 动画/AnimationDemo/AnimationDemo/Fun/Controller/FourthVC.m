//
//  FourthVC.m
//  AnimationDemo
//
//  Created by hnbwyh on 2018/10/10.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "FourthVC.h"

@interface FourthVC ()

@property (nonatomic, strong) UIImageView *demoImageView;

@end

@implementation FourthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.demoImageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2.0-50.0, 100, 100, 100)];
    self.demoImageView.image = [UIImage imageNamed:@"11"];
    [self.view addSubview:self.demoImageView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor           = [UIColor whiteColor];
    self.title                          = NSStringFromClass(self.class);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.8 animations:^{
//        CGAffineTransform transform            = CGAffineTransformMakeRotation(M_PI_2 * 0.5);
//        self.demoImageView.transform           = CGAffineTransformTranslate(transform, -30, 60);
        
        CGAffineTransform tf = CGAffineTransformConcat(CGAffineTransformMakeRotation(M_PI_2 * 0.5), CGAffineTransformMakeTranslation(-30, 60));
        self.demoImageView.transform            = tf;
    }];
}

@end
