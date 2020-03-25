//
//  DTestView.m
//  RACDemo
//
//  Created by hnbwyh on 2019/5/5.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "DTestView.h"

@implementation DTestView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@"测试数据-delegate"];
    }
}

@end
