//
//  AnalyzationGestureVC.m
//  RuntimeProDemo
//
//  Created by hnbwyh on 2020/8/14.
//  Copyright © 2020 ZhiXingJY. All rights reserved.
//

#import "AnalyzationGestureVC.h"

@interface AnalyzationGestureVC () <UIGestureRecognizerDelegate>

@end

@implementation AnalyzationGestureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);
    
    CGRect rect = CGRectMake(100, 200, 100, 100);
    [self.view addSubview:[self imageviewForRect:rect]];
    rect.origin.y = 100;
    [self.view addSubview:[self imageviewForRect:rect]];
}


- (UIImageView *)imageviewForRect:(CGRect)rct {
    
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:rct];
    [imgV setImage:[UIImage imageNamed:@"login_hnb_icon"]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    [imgV addGestureRecognizer:tap];
    imgV.userInteractionEnabled = TRUE;
    return imgV;
    
}


- (void)tapEvent:(UITapGestureRecognizer *)tap {
    NSLog(@"\n %s \n",__FUNCTION__);
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"\n %s \n",__FUNCTION__);
    return TRUE;
}


@end
