//
//  ThirdVC.m
//  GainRelativeInfoDemo
//
//  Created by hnbwyh on 17/7/5.
//  Copyright © 2017年 hainbwyh. All rights reserved.
//

#import "ThirdVC.h"

@interface ThirdVC ()

@end

@implementation ThirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)rightNavBtnClick:(UIButton *)btn{
    NSLog(@" %s ",__FUNCTION__);
    
    
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKey:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    int type = 0;
    for (UIView *v in children) {
        if ([v isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[v valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSString *statusString = @"Wifi";
    switch (type) {
        case 0:
            statusString = @"unreachable";
            break;
        case 1:
            statusString = @"2G";
            break;
        case 2:
            statusString = @"3G";
            break;
        case 3:
            statusString = @"4G";
            break;
        case 4:
            statusString = @"LTE";
            break;
        case 5:
            statusString = @"wifi";
            break;
            
        default:
            break;
    }
    
    self.displayLabel.text = [NSString stringWithFormat:@"当前网络：%@",statusString];
    
}

@end
