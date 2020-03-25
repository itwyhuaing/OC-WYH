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
    NSLog(@"\n\n 音乐播放 \n\n");
    [self audioPlayTest];
}

- (void)audioPlayTest {
    // 直接读取工程资源
//    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"Voice02" ofType:@"mp3"]; //
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"recoder" ofType:@"caf"]; //
    NSURL    *sourceURL  = [NSURL fileURLWithPath:sourcePath];
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:sourceURL error:nil];
    

    // 先把资源写进文件，然后再从文件中读取
//    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"Voice02" ofType:@"mp3"];
//    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, TRUE) firstObject];
//    NSString *cache_file = [NSString stringWithFormat:@"%@/voice_music.caf",cachePath];
//    NSData *wd = [NSData dataWithContentsOfFile:sourcePath];
//    [wd writeToFile:cache_file atomically:TRUE];
//    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:cache_file] error:nil];
    

    self.audioPlayer = audioPlayer;
    audioPlayer.delegate       = (id)self;
    audioPlayer.volume         = 0.8;
    [audioPlayer prepareToPlay];
    [audioPlayer play];
}

#pragma mark ------ AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"\n\n %s \n flag: %d \n\n",__FUNCTION__,flag);
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error {
    NSLog(@"\n\n %s \n error:%@ \n\n",__FUNCTION__,error);
}

@end
