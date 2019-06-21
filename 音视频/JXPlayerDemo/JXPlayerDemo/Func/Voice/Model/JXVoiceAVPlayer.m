//
//  JXVoiceAVPlayer.m
//  JXPlayerDemo
//
//  Created by hnbwyh on 2019/1/28.
//  Copyright © 2019年 JiXia. All rights reserved.
//

#import "JXVoiceAVPlayer.h"
#import <AVFoundation/AVFoundation.h>

@interface JXVoiceAVPlayer ()
@property (nonatomic,strong) AVPlayer               *avplayer;
@property (nonatomic,strong) id                     timeObserver;
@end

@implementation JXVoiceAVPlayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 设置锁屏封面信息
        [self updateLockScreenInfo];
    }
    return self;
}

-(void)playVoiceWithURLString:(NSString *)URLString{
    AVPlayerItem *item;
    if (URLString && [URLString hasPrefix:@"http"]) {
        item = [self playRemoteResourceWithURLString:URLString];
    } else {
        item = [self playLocalResource];
    }
    [self playVoiceWithItem:item];
}

- (AVPlayerItem *)playLocalResource{
    // 读取本地资源并创建播放实例
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"Voice02" ofType:@"mp3"];
    NSURL    *sourceURL  = [NSURL fileURLWithPath:sourcePath];
    AVPlayerItem *item   = [[AVPlayerItem alloc] initWithURL:sourceURL];
    return item;
}

- (AVPlayerItem *)playRemoteResourceWithURLString:(NSString *)URLString{
    // 读取远程资源并创建播放实例
    NSURL    *sourceURL  = [NSURL URLWithString:URLString];
    AVPlayerItem *item   = [[AVPlayerItem alloc] initWithURL:sourceURL];
    return item;
}

- (void)playVoiceWithItem:(AVPlayerItem *)item{
    if (item) {
        // 替换当前的播放资源
        [self.avplayer replaceCurrentItemWithPlayerItem:item];
        // 开始播放
        [self.avplayer play];
        
        // 监听
        [self jx_addObservers];
        
        
        __weak typeof(self) weakSelf = self;
        self.timeObserver = [self.avplayer addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue()
                                                                   usingBlock:^(CMTime time) {
                                                                       NSTimeInterval  curTime      = CMTimeGetSeconds(time);
                                                                       NSTimeInterval  totalTime    = CMTimeGetSeconds(weakSelf.avplayer.currentItem.duration);
                                                                       if (curTime) {
                                                                           NSTimeInterval   scale = curTime / totalTime;
                                                                           if (weakSelf.playedScale) {
                                                                               weakSelf.playedScale(scale);
                                                                           }
                                                                       }
                                                                   }];
        
        
    }
}


#pragma mark ------------ 播放管理

// 添加监听
- (void)jx_addObservers {
    [self.avplayer.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    [self.avplayer.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playFinied:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

// 移除监听
- (void)jx_removeObservers {
    // 播放器状态监听
    [self.avplayer.currentItem removeObserver:self forKeyPath:@"status"];
    // 缓冲进度/时间监听
    [self.avplayer.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    // 播放进度/时间监听
    [self.avplayer removeTimeObserver:self.timeObserver];
    // 播放过程监听
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

// 通知回调
- (void)playFinied:(id)info{
    NSLog(@" \n\n playFinied \n\n ");
}

// 监听回到
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"status"]) {
        switch (self.avplayer.status) {
            case AVPlayerStatusReadyToPlay:
            {
                NSLog(@"\n\n AVPlayerStatusReadyToPlay \n\n");
            }
                break;
            case AVPlayerStatusFailed:
            {
                NSLog(@"\n\n AVPlayerStatusFailed \n\n");
            }
                break;
            case AVPlayerStatusUnknown:
            {
                NSLog(@"\n\n AVPlayerStatusUnknown \n\n");
            }
                break;
                
            default:
                break;
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *loadedTimeRanges = self.avplayer.currentItem.loadedTimeRanges;
        NSValue *firstValue       = loadedTimeRanges.firstObject;
        CMTimeRange firstRange    = firstValue.CMTimeRangeValue;
        // 缓冲总时长
        NSTimeInterval loadedTime = CMTimeGetSeconds(firstRange.start) + CMTimeGetSeconds(firstRange.duration);
        // 音乐总时间
        NSTimeInterval totalTime  = CMTimeGetSeconds(self.avplayer.currentItem.duration);
        // 缓冲百分比
        NSTimeInterval scale      = loadedTime/totalTime;
        if (self.loadedScale) {
            self.loadedScale(scale);
        }
        
    }
    
}

- (void)remoteControlEventWithVC:(UIViewController *)vc isResign:(BOOL)isResign{
    if (vc) {
        if (!isResign) {
            [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
            [vc becomeFirstResponder];
        } else {
            [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
            [vc resignFirstResponder];
        }
    }
}


- (void)remoteControlReceivedEvent:(UIEvent *)event{
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlTogglePlayPause:
            {
                NSLog(@"UIEventSubtypeRemoteControlTogglePlayPause");
            }
                break;
            case UIEventSubtypeRemoteControlPlay:
            {
                NSLog(@"UIEventSubtypeRemoteControlPlay");
                [self.avplayer play];
            }
                break;
            case UIEventSubtypeRemoteControlPause:
            {
                NSLog(@"UIEventSubtypeRemoteControlPause");
                [self.avplayer pause];
            }
                break;
            case UIEventSubtypeRemoteControlStop:
            {
                NSLog(@"UIEventSubtypeRemoteControlStop");
            }
                break;
            case UIEventSubtypeRemoteControlNextTrack:
            {   // 下一曲
                NSLog(@"UIEventSubtypeRemoteControlNextTrack");
            }
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
            {   // 上一曲
                NSLog(@"UIEventSubtypeRemoteControlPreviousTrack");
            }
                break;
            case UIEventSubtypeRemoteControlEndSeekingForward:
            {
                NSLog(@"UIEventSubtypeRemoteControlEndSeekingForward");
            }
                break;
            case UIEventSubtypeRemoteControlEndSeekingBackward:
            {
                NSLog(@"UIEventSubtypeRemoteControlEndSeekingBackward");
            }
                break;
            case UIEventSubtypeRemoteControlBeginSeekingForward:
            {
                NSLog(@"UIEventSubtypeRemoteControlBeginSeekingForward");
            }
                break;
            case UIEventSubtypeRemoteControlBeginSeekingBackward:
            {
                NSLog(@"UIEventSubtypeRemoteControlBeginSeekingBackward");
            }
                break;
                
            default:
                break;
        }
    }
}


- (void)updateLockScreenInfo{
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    
    //更新锁屏时的歌曲信息
    MPMediaItemArtwork *artWork = [[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"6"]];
    [info setObject:@"Title 测试" forKey:MPMediaItemPropertyTitle];
    //[info setObject:@"Artist" forKey:MPMediaItemPropertyAlbumArtist];
    //[info setObject:@"Lyrics" forKey:MPMediaItemPropertyLyrics];
    //[info setObject:@"Genre" forKey:MPMediaItemPropertyGenre];
    [info setObject:@"Artist 测试" forKey:MPMediaItemPropertyArtist];
    //[info setObject:@"Rating" forKey:MPMediaItemPropertyRating];
    [info setObject:artWork forKey:MPMediaItemPropertyArtwork];
    //[info setObject:@"AssetURL" forKey:MPMediaItemPropertyAssetURL];
    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:info];
}

#pragma mark ------ outer methed

-(void)playBackEnable:(BOOL)able{
    if (able) { // 后台播放能力
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive:TRUE error:nil];
    } else {
        
    }
}

// 播放
- (void)playAction:(MPRemoteCommandCenter *)cnter{
    [self.avplayer play];
}

// 暂停
- (void)pauseAction:(MPRemoteCommandCenter *)cnter{
    [self.avplayer pause];
}



#pragma mark ------ lazy load

-(AVPlayer *)avplayer{
    if (!_avplayer) {
        _avplayer = [[AVPlayer alloc] init];
    }
    return _avplayer;
}

@end
