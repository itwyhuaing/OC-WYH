//
//  CheckInputVC.m
//  PredicateDemo
//
//  Created by hnbwyh on 2019/6/6.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "CheckInputVC.h"

@interface CheckInputVC ()<UITextFieldDelegate>

@property (nonatomic,strong) UITextField *txtField;

@end

@implementation CheckInputVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.txtField.backgroundColor = [UIColor cyanColor];
}

-(UITextField *)txtField {
    if (!_txtField) {
        CGFloat sw = [UIScreen mainScreen].bounds.size.width;
        _txtField = [[UITextField alloc] initWithFrame:CGRectMake(10.0, 100.0, sw-20.0, 60.0)];
        _txtField.placeholder = @"请输入内容";
        _txtField.keyboardType = UIKeyboardTypeDefault;
        [_txtField addTarget:self action:@selector(hasChangedTextField:) forControlEvents:UIControlEventValueChanged];
        _txtField.delegate = (id)self;
        [self.view addSubview:_txtField];
    }
    return _txtField;
}

#pragma  - UITextFieldDelegate

- (void)hasChangedTextField:(UITextField *)txtField {
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return TRUE;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 正则校验手机号 ：1[345678] + 11 位
    [self checkMobileNumWithInput:self.txtField.text];
    // 正则校验密码规则 ： 6-8 位字母与数字
    //[self checkPwdWithInput:self.txtField.text];
}

- (BOOL)checkMobileNumWithInput:(NSString *)txt {
    BOOL rlt = FALSE;
    NSString *zz = @"^1[345678]\\d{9}$";
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",zz];
    BOOL isPred = [regex evaluateWithObject:txt];
    if (isPred) {
        rlt = TRUE;
        NSLog(@"\n 测试点checkMobileNumWithInput - TRUE \n");
    }else {
        NSLog(@"\n 测试点checkMobileNumWithInput - FALSE \n");
    }
    return rlt;
}

- (BOOL)checkPwdWithInput:(NSString *)txt {
    BOOL rlt = FALSE;
    /**^(?=[a-z\d]*[0-9][a-z\d]*)(?=[a-z\d]*[a-z][a-z\d]*)[a-z\d]{6,8}$*/
    NSString *zz = @"(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,8}";
    NSPredicate *regex = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",zz];
    BOOL isPred = [regex evaluateWithObject:txt];
    if (isPred) {
        rlt = TRUE;
        NSLog(@"\n 测试点checkPwdWithInput - TRUE \n");
    }else {
        NSLog(@"\n 测试点checkPwdWithInput - FALSE \n");
    }
    return rlt;
}


@end
