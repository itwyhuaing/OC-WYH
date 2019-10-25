//
//  TstObj.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/10/25.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "TstObj.h"

@implementation TstObj

// 重写类别方法
- (BOOL)testMethod {
    NSLog(@" %s ",__FUNCTION__);
    return TRUE;
}

- (BOOL)testTstObjMethod {
    NSLog(@" %s ",__FUNCTION__);
    return TRUE;
}

@end
