//
//  CategaryVC.m
//  RuntimeProDemo
//
//  Created by hnbwyh on 2018/4/26.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "CategaryVC.h"
#import "NSDictionary+JXCategary.h"

@interface CategaryVC ()

@end

@implementation CategaryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"CategaryVC";
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSDictionary *data = @{@"data":@{
//                                   @"arr":@{},
//                                   @"str":@[],
//                                   @"dic":@"68"
//                                   }};
//    NSDictionary *dictx = [data jxValueWithKey:@"data" targetCls:[NSDictionary class]];
//    NSArray *arr = [dictx jxValueWithKey:@"arr" targetCls:[NSArray class]];
//    NSLog(@" \n 解析结果 \n dictx:%@  \n arr:%@ \n",dictx,arr);
//
//    NSString *str1 = nil;
//    NSArray *arr1 = nil;
//    NSDictionary *dict1 = nil;
//
//    NSString *str2 = @"str2";
//    NSArray *arr2 = @[@"arr2"];
//    NSDictionary *dict2 = @{@"key":@"dict2"};
//
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
//    [dic setValue:str1 forKey:@"str1"];
//    [dic setValue:str2 forKey:@"str2"];
//    [dic setValue:arr1 forKey:@"arr1"];
//    [dic setValue:arr2 forKey:@"arr2"];
//    [dic setValue:dict1 forKey:@"dict1"];
//    [dic setValue:dict2 forKey:@"dict2"];
//
//
//    NSLog(@" \n 组装结果 \n dic:%@ \n",dic);
    
    // https://itunes.apple.com/cn/app/海那边-移民海外投资服务平台/id998252357?mt=8
    NSURL *appUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id998252357?mt=8"]];
    [self openScheme:appUrl options:@{} complete:^(BOOL success) {
        NSLog(@"%d",success);
    }];
    
}


- (void)openScheme:(NSURL *)schemeURL options:(NSDictionary *)option complete:(void(^)(BOOL success))complete
{
    UIApplication *application = [UIApplication sharedApplication];
    if (@available(iOS 10.0, *)) {
        [application openURL:schemeURL options:option completionHandler:^(BOOL success) {
            if (complete) {
                complete(success);
            }
        }];
    } else {
        // Fallback on earlier versions
        [application openURL:schemeURL];
        BOOL success = [application canOpenURL:schemeURL];
        if (complete) {
            complete(success);
        }
    }
    
}


@end
