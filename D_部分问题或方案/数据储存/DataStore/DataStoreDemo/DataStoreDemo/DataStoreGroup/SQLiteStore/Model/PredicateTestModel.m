//
//  PredicateTestModel.m
//  DataStoreDemo
//
//  Created by hnbwyh on 2018/7/26.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "PredicateTestModel.h"

@implementation PredicateTestModel

+(id)modelWithName:(NSString *)name age:(NSInteger)age fid:(NSString *)fid{
    PredicateTestModel *model = [PredicateTestModel new];
    model.name      = name;
    model.age       = age;
    model.modelID   = fid;
    return model;
}

-(NSString *)description{
    NSString *s = [NSString stringWithFormat:@"\n\nname=%@\n age=%ld \n modelID=%@\n\n",_name,_age,_modelID];
    return s;
}

@end
