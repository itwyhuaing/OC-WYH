//
//  VoiceAVPlayerVC.h
//  JXPlayerDemo
//
//  Created by hnbwyh on 2019/1/25.
//  Copyright © 2019年 JiXia. All rights reserved.
//

#import "BaseFuncVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface VoiceAVPlayerVC : BaseFuncVC

+ (instancetype)currentAVPlayerVC;

// 后台播放能力
- (void)playBackEnable:(BOOL)able;

@end

NS_ASSUME_NONNULL_END
