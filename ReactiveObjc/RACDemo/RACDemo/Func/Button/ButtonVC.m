//
//  ButtonVC.m
//  RACDemo
//
//  Created by hnbwyh on 2019/5/7.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "ButtonVC.h"

@interface ButtonVC ()
@property (nonatomic,strong) UIButton *btn;
@end

@implementation ButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);
    [self test];
}


- (void)test {
    [[self.btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"\n 点击事件 : %@ \n",x);
    }];
}

-(UIButton *)btn {
    if (!_btn) {
        _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btn setTitle:@"点击事件" forState:UIControlStateNormal];
        _btn.backgroundColor = [UIColor grayColor];
        _btn.layer.borderColor = [UIColor blackColor].CGColor;
        _btn.layer.borderWidth = 0.8f;
        _btn.layer.cornerRadius= 6.0;
        [self.view addSubview:_btn];
        _btn.sd_layout
        .topSpaceToView(self.view, 100.0)
        .centerXEqualToView(self.view)
        .widthIs(166.0)
        .heightIs(36.0);
    }
    return _btn;
}

@end
