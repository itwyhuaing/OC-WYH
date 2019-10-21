//
//  ScrollBannerVC.m
//  CustomLibProject
//
//  Created by hnbwyh on 2019/10/18.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "ScrollBannerVC.h"
#import "ScrollBannerView.h"
#import "BannerMacro.h"
#import "CLTestVC.h"

@interface ScrollBannerVC ()

@property (nonatomic,strong) ScrollBannerView *banner;

@end

@implementation ScrollBannerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.banner];
    [self.banner reFreshBannerViewWithDataSource:@[@"image_01.jpeg",@"image_02.jpeg",
                                                   @"image_03.jpeg",@"image_04.jpeg"]];
    [self addObservers];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"\n %s \n",__FUNCTION__);
    // 第一次进入该页面不应执行
    //[self turnOnNotify];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"\n %s \n",__FUNCTION__);
    //[self turnOffNotify];
}

-(void)dealloc {
    NSLog(@"\n %s \n",__FUNCTION__);
    [self removeObservers];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CLTestVC *vc = [CLTestVC new];
    [self.navigationController pushViewController:vc animated:FALSE];
}

#pragma mark ------ 应用程序后台与前台之间切换监听

- (void)addObservers {
    // 监听应用程序状态
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillEnterForeground) name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appWillResignActive)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillEnterForegroundNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationWillResignActiveNotification
                                                  object:nil];
}

- (void)appWillEnterForeground {
    NSLog(@"\n appWillEnterForeground \n");
    [self turnOnNotify];
}

- (void)appWillResignActive {
    NSLog(@"\n appWillResignActive \n");
    [self turnOffNotify];
}

- (void)turnOnNotify {
    [[NSNotificationCenter defaultCenter] postNotificationName:kScrollBannerViewTimerOnNotify
                                                        object:nil];
}

- (void)turnOffNotify {
    [[NSNotificationCenter defaultCenter] postNotificationName:kScrollBannerViewTimerOffNotify
                                                        object:nil];
}

#pragma mark ------ lazy load

-(ScrollBannerView *)banner {
    if (!_banner) {
        _banner = [[ScrollBannerView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 200) autoPlayTimeInterval:3.0];
    }
    return _banner;
}

#pragma mark ------ private method

- (BOOL)isTopController {
    BOOL rlt = FALSE;
    NSArray *vcs = self.navigationController.viewControllers;
    if (vcs && vcs.count > 0) {
        UIViewController *topVC = vcs.firstObject;
        if ([topVC isKindOfClass:self.class]) {
            rlt = TRUE;
        }
    }
    return rlt;
}

@end
