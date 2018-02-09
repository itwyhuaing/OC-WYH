//
//  AnnimationTestController.m
//  YHDropListMenu
//
//  Created by wyh on 15/12/16.
//  Copyright © 2015年 lachesismh. All rights reserved.
//

#import "AnnimationTestController.h"

@interface AnnimationTestController ()

@property (nonatomic,retain) UILabel *dispLable;

@end

@implementation AnnimationTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"动画测试";
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startBtn setFrame:CGRectMake(0, 0, 50, 30)];
    [startBtn setTitle:@"启动" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:startBtn];
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [lable setText:@"测试"];
    lable.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:lable];
    self.dispLable = lable;
}

#pragma mark - 启动

- (void)startAnimation{

//    [self rotateAnimation];
    
    [self rollUp];
    
}

#pragma mark - 旋转

- (void)rotateAnimation{

    [UIView animateWithDuration:0.3 animations:^{
        
//        self.dispLable.transform = CGAffineTransformRotate(self.dispLable.transform, M_PI);
        self.dispLable.transform = CGAffineTransformMakeRotation(M_PI);
        
    }];
    
}

#pragma mark -  收起或展开

- (void)rollUp{
    
    if (self.dispLable.frame.origin.y < 0) { // 下移
        
        [self.view addSubview:self.dispLable];
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.dispLable.transform = CGAffineTransformTranslate(self.dispLable.transform, 0, self.dispLable.frame.size.height);
            
        }];
        
    } else { // 上移
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.dispLable.transform = CGAffineTransformTranslate(self.dispLable.transform, 0, -self.dispLable.frame.size.height);
            
        } completion:^(BOOL finished) {
            
            [self.dispLable removeFromSuperview];
            
        }];
        
    }
   
    
}

#pragma mark - 

#pragma mark - 

#pragma mark - 

#pragma mark - 

#pragma mark - 

#pragma mark - 

#pragma mark - 

#pragma mark - 

#pragma mark - 

#pragma mark -

@end
