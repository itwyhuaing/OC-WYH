//
//  FirstVC.m
//  CommonHandleDemo
//
//  Created by hnbwyh on 2018/2/26.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "FirstVC.h"
#import "UILabel+CopySpeciality.h"

@interface FirstVC ()

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = FALSE;
    self.title = @"FirstVC";
    
}

- (void)setUpUI{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    CGRect rect = CGRectZero;
    rect.size.width = screenSize.width;
    rect.size.height = screenSize.height / 3.0;
    
    UILabel *l = [[UILabel alloc] init];
    [l setFrame:rect];
    [self.view addSubview:l];
    l.numberOfLines = 0;
    l.isCopyable = TRUE;
    l.backgroundColor = [UIColor greenColor];
    l.text = @"在这物欲横流的人世间，人生一世实在是够苦。你存心做一个与世无争的老实人吧，人家就利用你欺侮你。你稍有才德品貌，人家就嫉妒你排挤你。 你大度退让，人家就侵犯你损害你。你要不与人争，就得与世无求，同时还要维持实力准备斗争。你要和别人和平共处，就先得和他们周旋，还得准备随时吃亏。 \n \n  少年贪玩，青年迷恋爱情，壮年汲汲于成名成家，暮年自安于自欺欺人。 \n \n 人寿几何，顽铁能炼成的精金，能有多少？但不同程度的锻炼，必有不同程度的成绩；不同程度的纵欲放肆，必积下不同程度的顽劣。";
    
    rect.origin.y = CGRectGetMaxY(l.frame) + 10.0;
    rect.size.height = screenSize.height - rect.origin.y;
    UITextView *tv = [[UITextView alloc] initWithFrame:rect];
    [self.view addSubview:tv];
    tv.backgroundColor = [UIColor greenColor];
    tv.text = @"在这物欲横流的人世间，人生一世实在是够苦。你存心做一个与世无争的老实人吧，人家就利用你欺侮你。你稍有才德品貌，人家就嫉妒你排挤你。 你大度退让，人家就侵犯你损害你。你要不与人争，就得与世无求，同时还要维持实力准备斗争。你要和别人和平共处，就先得和他们周旋，还得准备随时吃亏。 \n \n  少年贪玩，青年迷恋爱情，壮年汲汲于成名成家，暮年自安于自欺欺人。 \n \n 人寿几何，顽铁能炼成的精金，能有多少？但不同程度的锻炼，必有不同程度的成绩；不同程度的纵欲放肆，必积下不同程度的顽劣。";
    
    
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view resignFirstResponder];
//}

@end
