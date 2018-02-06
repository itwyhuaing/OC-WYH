//
//  NSURL+InitWithString.m
//  hinabian
//
//  Created by 何松泽 on 17/3/9.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import "NSURL+InitWithString.h"

@implementation NSURL (InitWithString)

-(id)withOutNilString:(NSString *)URLString
{
    if ([URLString rangeOfString:@" "].location != NSNotFound) {
        URLString = [URLString stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    id URL = [[NSURL alloc]initWithString:URLString];
    
    return URL;
}

@end
