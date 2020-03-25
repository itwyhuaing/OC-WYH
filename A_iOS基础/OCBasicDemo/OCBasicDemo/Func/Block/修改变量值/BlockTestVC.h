//
//  BlockTestVC.h
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/11/28.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

typedef int(^TestBlockFun)(int para);
@interface BlockTestVC : BaseVC

@property (nonatomic,copy) TestBlockFun tBlock;

@end

NS_ASSUME_NONNULL_END
