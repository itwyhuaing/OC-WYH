//
//  DataManager.h
//  JXObjCategary
//
//  Created by hnbwyh on 2018/7/16.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DataManager : NSObject

//- (NSMutableArray *)loadTitles;
//- (NSMutableArray *)loadCntDetails;
- (NSMutableArray *)loadListDataSource;

- (CGFloat)caculateAutoHeightWithCnt:(NSString *)cnt defaultValue:(CGFloat)defaultValue;

@end
