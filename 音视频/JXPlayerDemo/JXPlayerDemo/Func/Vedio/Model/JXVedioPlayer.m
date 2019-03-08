//
//  JXVedioPlayer.m
//  JXPlayerDemo
//
//  Created by hnbwyh on 2019/3/8.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JXVedioPlayer.h"

@interface JXVedioPlayer ()

@property (nonatomic,strong) AVPlayer           *vedioPlayer;
@property (nonatomic,strong) AVPlayerLayer      *playerLayer;

@end


@implementation JXVedioPlayer

-(AVPlayerLayer *)playVedioWithURLString:(NSString *)URLString{
    if (URLString) {
        // 加载资源
        NSURL *itemURL;
        if ([URLString hasPrefix:@"http"]) {
            itemURL = [NSURL URLWithString:URLString];
        } else {
            itemURL = [NSURL fileURLWithPath:URLString];
        }
        AVPlayerItem *vedioItem = [AVPlayerItem playerItemWithURL:itemURL];
        AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:vedioItem];
        AVPlayerLayer *layer_player = [AVPlayerLayer playerLayerWithPlayer:player];
        layer_player.videoGravity = AVLayerVideoGravityResizeAspectFill;
        layer_player.contentsScale= [UIScreen mainScreen].scale;
        layer_player.frame        = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 200);
        
        layer_player.backgroundColor = [UIColor redColor].CGColor;
        
        self.vedioPlayer = player;
        self.playerLayer = layer_player;
        
        // 添加监听
        [self jx_addObservers];
    }
    return self.playerLayer;
}

// 添加监听
- (void)jx_addObservers{
    [self.vedioPlayer.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [self.vedioPlayer.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}

// 移除监听
- (void)jx_removeObservers {
    [self.vedioPlayer.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.vedioPlayer.currentItem removeObserver:self forKeyPath:@"status"];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    AVPlayerItem *curItem = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSLog(@"loadedTimeRanges");
    } else if ([keyPath isEqualToString:@"status"]){
        NSLog(@"status");
        if (curItem.status == AVPlayerItemStatusReadyToPlay) {
            [self.vedioPlayer play];
        }
    }
}

#pragma mark --- lazy load

-(AVPlayer *)vedioPlayer{
    if (!_vedioPlayer) {
        _vedioPlayer = [[AVPlayer alloc] init];
    }
    return _vedioPlayer;
}


-(AVPlayerLayer *)playerLayer{
    if (!_playerLayer) {
        _playerLayer = [[AVPlayerLayer alloc] initWithLayer:self.vedioPlayer];
    }
    return _playerLayer;
}

@end
