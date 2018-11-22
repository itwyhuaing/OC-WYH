//
//  PredicateTestModel.h
//  DataStoreDemo
//
//  Created by hnbwyh on 2018/7/26.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PredicateTestModel : NSObject

@property (nonatomic,copy)          NSString    *modelID;
@property (nonatomic,copy)          NSString    *name;
@property (nonatomic,assign)        NSInteger   age;

+(id)modelWithName:(NSString *)name age:(NSInteger)age fid:(NSString *)fid;

@end
