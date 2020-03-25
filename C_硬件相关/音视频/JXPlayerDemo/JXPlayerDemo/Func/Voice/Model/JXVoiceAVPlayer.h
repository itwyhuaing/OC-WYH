//
//  JXVoiceAVPlayer.h
//  JXPlayerDemo
//
//  Created by hnbwyh on 2019/1/28.
//  Copyright © 2019年 JiXia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^UpdateScaleValue)(NSTimeInterval ti);
@interface JXVoiceAVPlayer : NSObject

// 缓冲进度
@property (nonatomic,copy) UpdateScaleValue loadedScale;

// 播放进度
@property (nonatomic,copy) UpdateScaleValue playedScale;

// 播放音频
- (void)playVoiceWithURLString:(NSString *)URLString;

// 播放
- (void)playAction:(MPRemoteCommandCenter *)cnter;

// 暂停
- (void)pauseAction:(MPRemoteCommandCenter *)cnter;

// 移除监听
- (void)jx_removeObservers;

// 后台播放能力
- (void)playBackEnable:(BOOL)able;


/**
 远程控制

 @param vc 所属控制器
 @param isResign 注册(FALSE) or 注销(TRUE)
 */
- (void)remoteControlEventWithVC:(UIViewController *)vc isResign:(BOOL)isResign;

- (void)remoteControlReceivedEvent:(UIEvent *)event;

@end

NS_ASSUME_NONNULL_END
