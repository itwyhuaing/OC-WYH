//
//  PersonInfo.h
//  LXYHOCFunctionsDemo
//
//  Created by wangyinghua on 2017/6/8.
//  Copyright © 2017年 lachesismh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInfo : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger age;
@property (nonatomic,strong) NSArray *subs;
@property (nonatomic,strong) NSDictionary *classRoom;

@end
