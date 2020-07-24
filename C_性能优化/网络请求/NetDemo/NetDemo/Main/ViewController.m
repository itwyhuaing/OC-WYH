//
//  ViewController.m
//  NetDemo
//
//  Created by hnbwyh on 2018/10/12.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "ViewController.h"
#import "ReqSender.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [ReqSender reqServerForShopAdditionWithName:@"name"
//                                        address:@"address"
//                                 detail_address:@"detail_address"
//                                           tels:@"tels"
//                                         mobies:@"mobies"
//                                business_images:@"business_images"
//                                  permit_images:@"permit_images"
//                                 succeedHandler:^(id  _Nonnull JSON) {
//
//                                  } failHandler:^(id  _Nonnull error) {
//
//                                }];
    
    [ReqSender reqServerForShopListWithKey:@""
                            succeedHandler:^(id  _Nonnull JSON) {

    } failHandler:^(id  _Nonnull error) {

    }];
}

@end
