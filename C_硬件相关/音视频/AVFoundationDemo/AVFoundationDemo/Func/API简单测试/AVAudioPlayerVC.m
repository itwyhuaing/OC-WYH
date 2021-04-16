//
//  AVAudioPlayerVC.m
//  AVFoundationDemo
//
//  Created by hnbwyh on 2019/10/14.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "AVAudioPlayerVC.h"
#import <AVFoundation/AVFoundation.h>

@interface AVAudioPlayerVC () <AVAudioPlayerDelegate>

@property (nonatomic,strong)    AVAudioPlayer *audioPlayer;

@end

@implementation AVAudioPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self audioPlayTest];
}

- (void)audioPlayTest {
// 播放资源
    NSUInteger tp = 0;
    
    // 1、直接读取工程资源
    NSString *local_sourcePath = [[NSBundle mainBundle] pathForResource:@"recoder" ofType:@"caf"]; // [[NSBundle mainBundle] pathForResource:@"Voice02" ofType:@"mp3"];
    NSURL    *local_sourceURL  = [NSURL fileURLWithPath:local_sourcePath];
    
    // 2、先把资源写进文件，然后再从文件中读取
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, TRUE) firstObject];
    NSString *cache_file = [NSString stringWithFormat:@"%@/voice_music.caf",cachePath];
    NSData *wd = [NSData dataWithContentsOfFile:local_sourcePath];
    [wd writeToFile:cache_file atomically:TRUE];
    NSURL *cache_sourceURL = [NSURL URLWithString:cache_file];
    
    // 3、工程中自行录制资源播放 - 注：需要退出一次应用才可正常播放
    NSString *custom_cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, TRUE) firstObject];
    NSString *custom_file      = [NSString stringWithFormat:@"%@/custom_recoder.caf",custom_cachePath];
    NSURL    *custom_sourceURL = [[NSFileManager defaultManager] fileExistsAtPath:custom_file] ? [NSURL URLWithString:custom_file] : [NSURL URLWithString:@"test"];
    
    tp = 2;
    NSURL    *sourceURL = local_sourceURL;
    if (tp == 1) {
        sourceURL = cache_sourceURL;
    }else if (tp == 2) {
        sourceURL = custom_sourceURL;
    }
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:sourceURL error:nil];
    self.audioPlayer = audioPlayer;
    audioPlayer.delegate       = (id)self;
    audioPlayer.volume         = 1.0;
    if ([audioPlayer prepareToPlay]) {
        NSLog(@"\n\n 语音播放 \n\n");
        [audioPlayer play];
    }
}

#pragma mark ------ AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"\n\n 语音播放： %s \n flag: %d \n\n",__FUNCTION__,flag);
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error {
    NSLog(@"\n\n 语音播放： %s \n error:%@ \n\n",__FUNCTION__,error);
}

@end
