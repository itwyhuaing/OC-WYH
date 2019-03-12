//
//  CaculateManager.h
//  BlockDemo
//
//  Created by hnbwyh on 2019/3/8.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CaculateManager : NSObject

@property (nonatomic,assign) CGFloat result;

- (CaculateManager *(^)(CGFloat num))add;

@end

NS_ASSUME_NONNULL_END
