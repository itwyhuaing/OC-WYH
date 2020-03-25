//
//  Movie.m
//  数据库Demo
//
//  Created by vera on 15-4-3.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        self.name = dic[@"title"];
        self.imageUrlString = dic[@"img"];
        NSLog(@" title :%@ --- imageUrlString : %@",self.name,self.imageUrlString);
    }
    
    return self;
}

@end
