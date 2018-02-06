//
//  UpLoadImageProgressTip.h
//  hinabian
//
//  Created by hnbwyh on 2017/8/22.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    UpLoadImageProgressTipNone = 999,
    UpLoadImageProgressTipSuccess,
    UpLoadImageProgressTipFailure,
    UpLoadImageProgressTipRemove,
} UpLoadImageProgressTipState;


@interface UpLoadImageProgressTip : UIView

/**
 * 记录提示条当前的状态
 * 默认为 None ，suc - > fai - > remove 或 suc - > remove
 */
@property (nonatomic,assign) UpLoadImageProgressTipState currentState;

/**
 * 单例
 */
+ (instancetype)defaultInstance;

/**
 * 展示
 */
- (void)displayUpLoadImageProgressTiporiginY:(CGFloat)originY;

/**
 * 移除
 */
- (void)removeUpLoadImageProgressTip;

/**
 * 修改显示
 */
- (void)updateUpLoadImageProgressTipText:(NSString *)text;

@end
