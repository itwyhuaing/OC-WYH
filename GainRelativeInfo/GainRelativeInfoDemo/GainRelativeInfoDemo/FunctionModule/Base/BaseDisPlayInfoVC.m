//
//  BaseDisPlayInfoVC.m
//  GainRelativeInfoDemo
//
//  Created by hnbwyh on 17/7/5.
//  Copyright © 2017年 hainbwyh. All rights reserved.
//

#import "BaseDisPlayInfoVC.h"

@interface BaseDisPlayInfoVC ()

@end

@implementation BaseDisPlayInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, 35, 35)];
    [btn addTarget:self action:@selector(rightNavBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitle:@"启动" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    if (self.navigationController.viewControllers.count > 1) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setFrame:CGRectMake(0, 0, 35, 35)];
        [backBtn addTarget:self action:@selector(backNavBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        backBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [backBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        self.navigationItem.leftBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
    
    _displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,
                                                              64 + 60,
                                                              [UIScreen mainScreen].bounds.size.width - 20,
                                                              [UIScreen mainScreen].bounds.size.height - 64 - 60 - 49)];
    _displayLabel.textColor = [UIColor blueColor];
    _displayLabel.font = [UIFont systemFontOfSize:15.f];
    _displayLabel.numberOfLines = 0;
    _displayLabel.hidden = NO;
    _displayLabel.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_displayLabel];
    
    _displayLabel.text = @" 1> 点击启动按钮 \n \n \n 2> 展示打印信息";
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *vcstring = NSStringFromClass([self class]);
    self.title = vcstring;
}


- (void)rightNavBtnClick:(UIButton *)btn{
    NSLog(@" %s ",__FUNCTION__);
}

- (void)backNavBtnClick:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
