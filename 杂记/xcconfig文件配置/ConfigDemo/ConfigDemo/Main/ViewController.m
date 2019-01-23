//
//  ViewController.m
//  ConfigDemo
//
//  Created by hnbwyh on 2019/1/23.
//  Copyright © 2019年 JiXia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *l = [[UILabel alloc] init];
    [l setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    [self.view addSubview:l];
    l.backgroundColor = [UIColor cyanColor];
    l.textColor = [UIColor blackColor];
    l.font = [UIFont systemFontOfSize:19.0];
    
    NSString *value = [NSString stringWithFormat:@"%@ - %@",API_URL,JXPRODUCT_NAME];
    l.text = value;
    
    
}


@end
