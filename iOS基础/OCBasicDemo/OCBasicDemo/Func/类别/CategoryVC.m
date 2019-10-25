//
//  CategoryVC.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/10/25.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "CategoryVC.h"
#import "NSObject+Tst.h"
#import "TstObj+TC.h"
#import "TstObj.h"

@interface CategoryVC ()



@end

@implementation CategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    TstObj *obj = [TstObj new];
    [obj testNSObjectMethod];
    [obj testTstObjMethod];
}

@end
