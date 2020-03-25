//
//  NSDictionary+ValueForKey.m
//  hinabian
//
//  Created by hnbwyh on 16/8/31.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//

#import "NSDictionary+ValueForKey.h"

@implementation NSDictionary (ValueForKey)

- (id)returnValueWithKey:(NSString *)key{

    id tmp = [self valueForKey:key];

    if ([tmp isKindOfClass:[NSNull class]]) {
        tmp = nil;
    }
    //NSLog(@" key :%@ =========== > %@",key,tmp);
    return tmp;
}

@end
