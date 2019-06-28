//
//  TrVC.m
//  TargetPrj
//
//  Created by hnbwyh on 2019/6/26.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "TrVC.h"
#import "AppDelegate.h"

@interface TrVC ()

@end

@implementation TrVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor purpleColor];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [app configTabBarVCWithType:WindowRootTabBarTypeYiMing];
        NSLog(@"\n 切换 -> 移民 : \n %@ \n ",app.window.rootViewController);
    });
}

@end
