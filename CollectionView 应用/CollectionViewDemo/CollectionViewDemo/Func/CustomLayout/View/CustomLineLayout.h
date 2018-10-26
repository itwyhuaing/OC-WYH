//
//  CustomLineLayout.h
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/10/24.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_WIDTH_6          375.0   //同上
#define kScreenWidth            [UIScreen mainScreen].bounds.size.width
#define kScreenHeight           [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTHRATE_6      (kScreenWidth / SCREEN_WIDTH_6)  // 以 6 为基准
#define ITEM_SIZE_W             (345.0 * SCREEN_WIDTHRATE_6)
#define ITEM_SIZE_H             (190.0 * SCREEN_WIDTHRATE_6)

@interface CustomLineLayout : UICollectionViewFlowLayout

@end
