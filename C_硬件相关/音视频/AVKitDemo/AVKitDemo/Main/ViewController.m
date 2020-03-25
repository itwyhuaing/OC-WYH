//
//  ViewController.m
//  AVKitDemo
//
//  Created by hnbwyh on 2019/10/12.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "ViewController.h"
#import "APISampleTestVC.h"
#import "APISampleTestVC2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor   =   [UIColor whiteColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    APISampleTestVC *vc = [APISampleTestVC new];
    [self.navigationController pushViewController:vc animated:TRUE];
}

@end
