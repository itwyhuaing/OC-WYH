//
//  AnalyzationUICotrolVC.m
//  RuntimeProDemo
//
//  Created by hnbwyh on 2020/8/14.
//  Copyright © 2020 ZhiXingJY. All rights reserved.
//

#import "AnalyzationUICotrolVC.h"

@interface AnalyzationUICotrolVC ()

@end

@implementation AnalyzationUICotrolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);CGRect rect = CGRectMake(100, 300, 200, 30);
        [self createButtonWithFrame:rect title:@"点击测试 - 111"];

        rect.origin.y += 200;
        [self createButtonWithFrame:rect title:@"点击测试 - 222"];
        
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    BOOL isBtn = FALSE;
    if (isBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *itemImage = [UIImage imageNamed:@"btn_fanhui_black"];
        [btn setFrame:CGRectMake(0, 0, 36.0, 36.0)];
        [btn setImage:itemImage forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(hnbBasePopVC) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem = back;
    }else {
//        UIImage *itemImage = [UIImage imageNamed:@"btn_fanhui_black"];
//        UIBarButtonItem *customBackItem = [[UIBarButtonItem alloc] initWithImage:[itemImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(hnbBasePopVC)];
        
        UIBarButtonItem *customBackItem = [[UIBarButtonItem alloc] init];
        customBackItem.image = [UIImage imageNamed:@"btn_fanhui_black"];
        customBackItem.target = self;
        customBackItem.action = @selector(hnbBasePopVC);
        
        
        self.navigationItem.leftBarButtonItem = customBackItem;
    }
    
}



- (UIButton *)createButtonWithFrame:(CGRect)rect title:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //btn.custom_acceptEventInterval = 2.0;
    [btn setFrame:rect];
    btn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:btn];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickEventBtn:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


- (void)hnbBasePopVC{
    [self.navigationController popViewControllerAnimated:TRUE];
}

#pragma mark ------ 获取属性列表与方法列表

- (void)clickEventBtn:(UIButton *)btn{
    NSLog(@" %s --- %@ ",__FUNCTION__,btn.titleLabel.text);
}
@end
