//
//  Movie.h
//  数据库Demo
//
//  Created by vera on 15-4-3.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject


//初始化
- (id)initWithDic:(NSDictionary *)dic;

//名字
@property (nonatomic, copy) NSString *name;
//图片地址
@property (nonatomic, copy) NSString *imageUrlString;

@end
