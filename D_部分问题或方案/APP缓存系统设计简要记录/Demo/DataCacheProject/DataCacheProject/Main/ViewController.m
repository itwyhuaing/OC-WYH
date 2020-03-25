//
//  ViewController.m
//  DataCacheProject
//
//  Created by hnbwyh on 2018/3/13.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "ViewController.h"
#import "WebVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    WebVC *vc = [[WebVC alloc] init];
    [self.navigationController pushViewController:vc animated:TRUE];
    
}


@end
