//
//  NotificationVC.m
//  RACDemo
//
//  Created by hnbwyh on 2019/5/5.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "NotificationVC.h"

@interface NotificationVC ()

@property (nonatomic,strong) UITextField        *tf;
@property (nonatomic,strong) RACDisposable      *keyBordDisposable;

@end

@implementation NotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title                = NSStringFromClass(self.class);
    [self configUI];
    [self subScribe];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (void)configUI{
    self.tf.backgroundColor = [UIColor cyanColor];
}

- (void)subScribe {
    // 输入监听
    [[self.tf rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        //NSLog(@"x = \n %@",x);
    }];
    
    // 键盘通知监听
    self.keyBordDisposable = [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        //NSLog(@"key-x = \n %@",x);
    }];
    
    // 绑定
    RAC(self.tf,backgroundColor) = [self.tf.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return [value isEqualToString:@"888"] ? [UIColor redColor] : [UIColor purpleColor];
    }];
    
    // 添加监听条件
    [[self.tf.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 3;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"\n 数据测试 : %@\n",x);
    }];
}

-(void)dealloc{
    NSLog(@" %s ",__FUNCTION__);
    [self.keyBordDisposable dispose];
}

-(UITextField *)tf{
    if (!_tf) {
        _tf = [[UITextField alloc] initWithFrame:CGRectZero];
        _tf.placeholder = @"请输入内容";
        [self.view addSubview:_tf];
        _tf.sd_layout
        .leftSpaceToView(self.view, 10.0)
        .rightSpaceToView(self.view, 10.0)
        .topSpaceToView(self.view, 100.0)
        .heightIs(36.0);
    }
    return _tf;
}

@end
