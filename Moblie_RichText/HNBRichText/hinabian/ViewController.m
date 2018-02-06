//
//  ViewController.m
//  hinabian
//
//  Created by hnbwyh on 15/6/1.
//  Copyright (c) 2015年 hnbwyh. All rights reserved.
//

#import "ViewController.h"
#import "HNBRichTextPostingVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    HNBRichTextPostingVC *vc = [[HNBRichTextPostingVC alloc] init];
    vc.choseTribeCode = @"";
    [self.navigationController pushViewController:vc animated:YES];
}

@end
