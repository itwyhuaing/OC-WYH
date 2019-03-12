//
//  CaculateManager.m
//  BlockDemo
//
//  Created by hnbwyh on 2019/3/8.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "CaculateManager.h"

@implementation CaculateManager

-(CaculateManager * _Nonnull (^)(CGFloat))add{
    return ^CaculateManager *(CGFloat num){
        self->_result += num;
        return self;
    };
}

@end
