//
//  ViewController.m
//  TargetPrj
//
//  Created by hnbwyh on 2019/6/21.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor whiteColor];
    
#ifdef kTargetFH
    NSLog(@"海房");
#else
    NSLog(@"移民");
#endif

    
}

@end
