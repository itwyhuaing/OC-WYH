//
//  JXViewVC.m
//  JXObjCategary
//
//  Created by hnbwyh on 2018/9/18.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "JXViewVC.h"
#import "JXCategory.h"

@interface JXViewVC ()

@end

@implementation JXViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.cntV setContentSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 800)];
    UIView *v1          = [self test1ShowWithFrame:CGRectMake(0, 0, self.sw, 200)];
    [self.cntV addSubview:v1];
    
    UIView *v2          = [self test2ShowWithFrame:CGRectMake(0, CGRectGetMaxY(v1.frame), self.sw, 200)];
    [self.cntV addSubview:v2];
}


- (UIView *)test1ShowWithFrame:(CGRect)rect{
    UIView *rlt             = [[UIView alloc] initWithFrame:rect];
    [rlt addSubview:[self themLabelWithTitle:@"卡片样式"]];
    UIView *cv = [UIView cardStyleView];
    [cv setFrame:CGRectMake(self.sw/2.0 - 50.0, 30.0, 100, 100)];
    [rlt addSubview:cv];
    return rlt;
}

- (UIView *)test2ShowWithFrame:(CGRect)rect{
    UIView *rlt             = [[UIView alloc] initWithFrame:rect];
    [rlt addSubview:[self themLabelWithTitle:@"颜色渐变"]];
    UIView *hv              = [UIView gradeColorViewWithFrame:CGRectMake(0, 30, self.sw, 30)];
    [rlt addSubview:hv];
    return rlt;
}



- (UILabel *)themLabelWithTitle:(NSString *)title{
    UILabel *them          = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.sw, 30)];
    them.font              = [UIFont systemFontOfSize:16.0];
    them.textColor         = [UIColor redColor];
    them.text              = title;
    return them;
}

@end
