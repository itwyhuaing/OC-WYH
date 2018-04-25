//
//  ViewController.m
//  SchemeDemoA
//
//  Created by hnbwyh on 2018/4/20.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSString *URLString = @"schemedemob://";
    NSURL *URL = [NSURL URLWithString:URLString];
    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
        NSLog(@" 11 complete ");
        [[UIApplication sharedApplication] openURL:URL options:@{} completionHandler:^(BOOL success) {
            NSLog(@" 22 complete ");
        }];
    }
    
}

@end
