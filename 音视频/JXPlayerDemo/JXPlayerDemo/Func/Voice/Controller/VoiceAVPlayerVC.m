//
//  VoiceAVPlayerVC.m
//  JXPlayerDemo
//
//  Created by hnbwyh on 2019/1/25.
//  Copyright © 2019年 JiXia. All rights reserved.
//

#import "VoiceAVPlayerVC.h"
#import <AVFoundation/AVFoundation.h>

@interface VoiceAVPlayerVC ()

@property (nonatomic,strong) AVPlayer               *avplayer;
@property (nonatomic,strong) id                     timeObserver;
@property (nonatomic,strong) UIProgressView         *progess;

@end


@implementation VoiceAVPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
}

- (void)addSubviews{
    UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:@[@"本地资源",@"远程资源"]];
    CGSize sgSize = CGSizeMake(200, 30);
    [segControl setFrame:CGRectMake(CGRectGetMidX(self.progess.frame) - sgSize.width/2.0,
                                    CGRectGetMinY(self.progess.frame) - sgSize.height - 10,
                                    sgSize.width, sgSize.height)];
    [self.view addSubview:segControl];
    [segControl addTarget:self action:@selector(clickEventSegControl:) forControlEvents:UIControlEventValueChanged];
}

- (void)clickEventSegControl:(UISegmentedControl *)sl{
    AVPlayerItem *item;
    switch (sl.selectedSegmentIndex) {
        case 0:
            {
                item = [self playLocalResource];
            }
            break;
        case 1:
            {
                item = [self playRemoteResource];
            }
            break;
            
        default:
            break;
    }
    
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
                                                                           NSLog(@" \n\n 播放进度 ：%f \n\n ",scale);
                                                                       }
                                                                   }];
    }
}

#pragma mark ------------ 本地资源简单播放

- (AVPlayerItem *)playLocalResource{
    // 读取本地资源并创建播放实例
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"Voice02" ofType:@"mp3"];
    NSURL    *sourceURL  = [NSURL fileURLWithPath:sourcePath];
    AVPlayerItem *item   = [[AVPlayerItem alloc] initWithURL:sourceURL];
    return item;
}

- (AVPlayerItem *)playRemoteResource{
    // 读取远程资源并创建播放实例
    NSString *URLString = @"https://hinabian-oss.oss-cn-shenzhen.aliyuncs.com/20190115/87c8e454242f63847661005f7810d953.mp3";
    NSURL    *sourceURL  = [NSURL URLWithString:URLString];
    AVPlayerItem *item   = [[AVPlayerItem alloc] initWithURL:sourceURL];
    return item;
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
        self.progess.progress     = scale;
        NSLog(@"\n\n 缓冲百分比 ：%f \n\n",scale);
        
    }
    
}

-(AVPlayer *)avplayer{
    if (!_avplayer) {
        _avplayer = [[AVPlayer alloc] init];
    }
    return _avplayer;
}

-(UIProgressView *)progess{
    if (!_progess) {
        _progess = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progess.trackTintColor    = [UIColor orangeColor];
        _progess.progressTintColor = [UIColor blueColor];
        [_progess setFrame:CGRectMake(10, 150, [UIScreen mainScreen].bounds.size.width - 20.0, 10)];
        [self.view addSubview:_progess];
    }
    return _progess;
}

// 销毁 - 释放
-(void)dealloc{
    NSLog(@"\n\n dealloc \n\n");
    [self jx_removeObservers];
}
@end
