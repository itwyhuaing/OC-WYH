//
//  BaseASCell.m
//  ASDKProjectDemo
//
//  Created by hnbwyh on 17/7/10.
//  Copyright © 2017年 hainbwyh. All rights reserved.
//

#import "BaseASCell.h"

@interface BaseASCell ()

@property (nonatomic,strong) BaseDataModel *dataModel;

@end

@implementation BaseASCell

-(instancetype)initWithDataModel:(BaseDataModel *)dataModel{

    if (self = [super init]) {
        _dataModel = dataModel;

    }
    return self;
}

@end
