//
//  PersonInfo.h
//  LXYHOCFunctionsDemo
//
//  Created by wangyinghua on 2017/6/8.
//  Copyright © 2017年 lachesismh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHBaseModel.h"

@interface PersonInfo : YHBaseModel

@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger age;
@property (nonatomic,strong) NSArray *subs;
@property (nonatomic,strong) NSDictionary *classRoom;

@end
