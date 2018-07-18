//
//  FirstVC.m
//  BackGestureDemo
//
//  Created by hnbwyh on 2018/7/18.
//  Copyright © 2018年 ZhiXingLife. All rights reserved.
//

#import "FirstVC.h"
#import "SecondVC.h"

@interface FirstVC ()<UIGestureRecognizerDelegate>

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass([self class]);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor               = [UIColor whiteColor];
    
    // 隐藏返回按钮
    self.navigationItem.hidesBackButton = TRUE;
    UILabel *l = [[UILabel alloc] init];
    [self.view addSubview:l];
    [l setFrame:self.view.bounds];
    l.textColor = [UIColor cyanColor];
    l.backgroundColor  = [UIColor orangeColor];
    l.numberOfLines = 0;
    l.text = @"1.点击任意处跳转至下一级 \n 2.右滑返回 \n ";
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled  = TRUE;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    NSLog(@" gestureRecognizerShouldBegin : %@ \n %@",gestureRecognizer,[gestureRecognizer class]);
    BOOL rlt = FALSE;
    // 手势
    if(gestureRecognizer == self.navigationController.interactivePopGestureRecognizer){
        // 控制器堆栈
        if(self.navigationController.viewControllers.count >= 2){
            rlt = TRUE;
        }
    }
    return rlt;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SecondVC *vc = [[SecondVC alloc] init];
    [self.navigationController pushViewController:vc animated:TRUE];
}

@end
