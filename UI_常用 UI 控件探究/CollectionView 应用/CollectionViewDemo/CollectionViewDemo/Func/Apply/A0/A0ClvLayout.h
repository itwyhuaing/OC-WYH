//
//  A0ClvLayout.h
//  CollectionViewDemo
//
//  Created by hnbwyh on 2020/6/24.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^OperateSignalBlock)(NSInteger location);
@interface A0ClvLayout : UICollectionViewLayout

@property (nonatomic,assign,readonly) NSInteger location;

@property (nonatomic,copy) OperateSignalBlock signal;

@end

NS_ASSUME_NONNULL_END
