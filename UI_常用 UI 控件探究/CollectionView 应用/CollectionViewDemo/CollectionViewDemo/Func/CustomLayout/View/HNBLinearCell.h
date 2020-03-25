//
//  HNBLinearCell.h
//  FineHouse
//
//  Created by 蔡成汉 on 2018/8/31.
//  Copyright © 2018年 Hinabian. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HomeHotCityDataModel;

@interface HNBLinearCell : UICollectionViewCell

// 页面数据源
@property (nonatomic, strong) HomeHotCityDataModel *data;

@end
