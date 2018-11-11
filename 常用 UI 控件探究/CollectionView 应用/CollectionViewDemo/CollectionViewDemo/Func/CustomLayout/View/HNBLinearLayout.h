//
//  HNBLinearLayout.h
//  FineHouse
//
//  Created by 蔡成汉 on 2018/8/31.
//  Copyright © 2018年 Hinabian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNBLinearLayout : UICollectionViewLayout

// item max width, default is 134.0
@property (nonatomic, assign) CGFloat itemWidth;

// item min scale, default is 0.82
@property (nonatomic, assign) CGFloat itemScale;

// item min alpha, default is 0.5
@property (nonatomic, assign) CGFloat itemAlpha;

// item spacing, default is 15 pt
@property (nonatomic, assign) CGFloat itemSpacing;

// item fix offset, default is 0 pt
@property (nonatomic, assign) CGFloat fixOffset;

@end
