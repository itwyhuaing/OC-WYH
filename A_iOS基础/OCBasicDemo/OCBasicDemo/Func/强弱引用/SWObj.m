//
//  SWObj.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2020/3/16.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import "SWObj.h"

@implementation SWObj

-(void)dealloc {
    NSLog(@" \n \n  %s 已销毁 : %@ \n \n",__FUNCTION__,self.name);
}

@end
