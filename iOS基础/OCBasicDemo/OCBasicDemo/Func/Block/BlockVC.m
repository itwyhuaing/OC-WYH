//
//  BlockVC.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/11/26.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "BlockVC.h"
#import "ChainVC.h"
#import "BlockTestVC.h"

@interface BlockVC ()

@end

@implementation BlockVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 测试 block 在链式编程中的应用
    UIViewController *vc = [ChainVC new];
    // 测试截获“瞬间值”
    vc = [BlockTestVC new];
    [self.navigationController pushViewController:vc animated:FALSE];
}

@end
