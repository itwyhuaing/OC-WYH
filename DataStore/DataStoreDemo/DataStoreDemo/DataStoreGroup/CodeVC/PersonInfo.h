//
//  PersonInfo.h
//  LXYHOCFunctionsDemo
//
//  Created by wangyinghua on 2017/6/8.
//  Copyright © 2017年 lachesismh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YHBaseModel.h"
#import "Son.h"

@interface PersonInfo : YHBaseModel

@property (nonatomic,copy)   NSString       *name;
@property (nonatomic,assign) NSInteger      age;
@property (nonatomic,assign) CGFloat        mark;
@property (nonatomic,strong) NSArray        *subs;
@property (nonatomic,strong) NSDictionary   *classRoom;

// 测试数据类型的解归档存储及属性的遍历
@property (nonatomic,strong) Son            *son;
@property (nonatomic,assign) NSUInteger     ageTest;
@property (nonatomic,assign) double         markTest;
@property (nonatomic,assign) BOOL           boolTest;
@property (nonatomic,assign) int            intTest;
@property (nonatomic,assign) float          floatTest;

@property (nonatomic,copy)   NSString       *addStr;
@property (nonatomic,strong) NSArray        *addArr;
@property (nonatomic,strong) NSDictionary   *addDic;
@property (nonatomic,assign) CGFloat        addFloat;

@end
