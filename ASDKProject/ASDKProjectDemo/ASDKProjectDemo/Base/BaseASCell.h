//
//  BaseASCell.h
//  ASDKProjectDemo
//
//  Created by hnbwyh on 17/7/10.
//  Copyright © 2017年 hainbwyh. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "BaseDataModel.h"

@interface BaseASCell : ASCellNode

- (instancetype)initWithDataModel:(BaseDataModel *)dataModel;

@end
