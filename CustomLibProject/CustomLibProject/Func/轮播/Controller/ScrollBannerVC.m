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

@interface ScrollBannerVC ()

@property (nonatomic,strong) ScrollBannerView *banner;

@end

@implementation ScrollBannerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(ScrollBannerView *)banner {
    if (!_banner) {
        
        
        
        _banner = [[ScrollBannerView alloc] initWithFrame:CGRectMake(0, 100, <#CGFloat width#>, <#CGFloat height#>) autoPlayTimeInterval:<#(NSTimeInterval)#>];
    }
    return _banner;
}

@end
