//
//  APISampleTestVC.m
//  AVKitDemo
//
//  Created by hnbwyh on 2019/10/12.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "APISampleTestVC.h"
#import <AVKit/AVKit.h>

@interface APISampleTestVC () <AVRoutePickerViewDelegate>

@end

@implementation APISampleTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    AVRoutePickerView *avPickView = [[AVRoutePickerView alloc] initWithFrame:CGRectMake(10.0,
                                                                                        80.0,
                                                                                        CGRectGetWidth(screenBounds)-20.0,
                                                                                        200.0)];
    avPickView.activeTintColor    = [UIColor redColor];
    avPickView.delegate           = (id)self;
    [self.view addSubview:avPickView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark ------ AVRoutePickerViewDelegate

-(void)routePickerViewWillBeginPresentingRoutes:(AVRoutePickerView *)routePickerView {
    NSLog(@"\n\n routePickerViewWillBeginPresentingRoutes \n\n");
}

-(void)routePickerViewDidEndPresentingRoutes:(AVRoutePickerView *)routePickerView {
    NSLog(@"\n\n routePickerViewDidEndPresentingRoutes \n\n");
}

@end
