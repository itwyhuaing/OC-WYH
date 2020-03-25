//
//  RTMethodHandleVC.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/11/13.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "RTMethodHandleVC.h"

@interface RTMethodHandleVC ()

@end

@implementation RTMethodHandleVC

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.title = NSStringFromClass([self class]);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"\n\n %s \n\n",__FUNCTION__);
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"\n\n %s \n\n",__FUNCTION__);
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"\n\n %s \n\n",__FUNCTION__);
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"\n\n %s \n\n",__FUNCTION__);
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"\n\n %s \n\n",__FUNCTION__);
}

@end
