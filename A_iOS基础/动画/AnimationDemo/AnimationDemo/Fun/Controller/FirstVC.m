//
//  FirstVC.m
//  AnimationDemo
//
//  Created by hnbwyh on 2018/10/10.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "FirstVC.h"

@interface FirstVC ()

@property (nonatomic, strong) UIImageView *demoImageView;

@end

@implementation FirstVC

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
        self.demoImageView.transform            = CGAffineTransformMakeTranslation(100.0, 100.0);
    }];
}

@end
