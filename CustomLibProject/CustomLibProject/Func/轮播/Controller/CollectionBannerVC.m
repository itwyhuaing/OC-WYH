//
//  CollectionBannerVC.m
//  CustomLibProject
//
//  Created by hnbwyh on 2019/10/18.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "CollectionBannerVC.h"
#import "CollectionBanner.h"
#import "CLVBannerMacro.h"

@interface CollectionBannerVC ()

@property (nonatomic,strong) CollectionBanner *clvBanner;

@end

@implementation CollectionBannerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.clvBanner];
    self.clvBanner.dataSource = @[@"0",@"1",@"2",@"3"];
}

-(CollectionBanner *)clvBanner {
    if (!_clvBanner) {
        _clvBanner = [[CollectionBanner alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 200)];
    }
    return _clvBanner;
}

@end
