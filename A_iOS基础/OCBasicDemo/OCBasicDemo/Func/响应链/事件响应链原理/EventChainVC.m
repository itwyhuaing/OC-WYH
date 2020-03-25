//
//  EventChainVC.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/10/31.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "EventChainVC.h"
#import "EAView.h"
#import "EBView.h"
#import "ECView.h"

@interface EventChainVC ()

@property (nonatomic,strong) EAView *redv;

@property (nonatomic,strong) EBView *greenv;

@property (nonatomic,strong) ECView *bluev;

@end

@implementation EventChainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.redv];
    [self.redv addSubview:self.greenv];
    [self.redv addSubview:self.bluev];
    CGRect rect = CGRectMake(10.0, 100.0, [UIScreen mainScreen].bounds.size.width - 20.0,
                             [UIScreen mainScreen].bounds.size.height - 110.0);
    [self.redv setFrame:rect];
    rect = CGRectMake(80.0, 130.0, 100.0, 100.0);
    [self.greenv setFrame:rect];
    rect.origin.x += 60.0;
    rect.origin.y += 60.0;
    rect.size.width += 100.0;
    rect.size.height-= 30.0;
    [self.bluev setFrame:rect];
}

-(EAView *)redv {
    if (!_redv) {
        _redv = [EAView new];
        _redv.backgroundColor = [UIColor redColor];
    }
    return _redv;
}


-(EBView *)greenv {
    if (!_greenv) {
        _greenv = [EBView new];
        _greenv.backgroundColor = [UIColor greenColor];
    }
    return _greenv;
}


-(ECView *)bluev {
    if (!_bluev) {
        _bluev = [ECView new];
        _bluev.backgroundColor = [UIColor blueColor];
    }
    return _bluev;
}


@end
