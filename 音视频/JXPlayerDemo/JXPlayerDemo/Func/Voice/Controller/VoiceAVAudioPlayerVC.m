//
//  VoiceAVAudioPlayerVC.m
//  JXPlayerDemo
//
//  Created by hnbwyh on 2019/1/25.
//  Copyright © 2019年 JiXia. All rights reserved.
//

#import "VoiceAVAudioPlayerVC.h"
#import <AVFoundation/AVFoundation.h>

@interface VoiceAVAudioPlayerVC ()

// 必须是全局强引用的实例对象
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;

@end

@implementation VoiceAVAudioPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self routerFunctionByType:self.type];
}

- (void)routerFunctionByType:(FuncType)tp{
    switch (tp) {
        case FuncTypeVoiceAVAudioSystem:
        {
            [self exampleSystemVoice];
        }
            break;
        case FuncTypeVoiceAVAudioCustom:
        {
            [self exampleCustomVoice];
        }
            break;
            
            
        default:
            break;
    }
}

- (void)exampleSystemVoice{
    NSLog(@" \n %s \n ",__FUNCTION__);
}

- (void)exampleCustomVoice{
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"Voice02" ofType:@"mp3"];
    NSURL    *sourceURL  = [NSURL fileURLWithPath:sourcePath];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:sourceURL error:nil];
    
    _audioPlayer.delegate       = (id)self;
    _audioPlayer.volume         = 0.8;
    _audioPlayer.numberOfLoops  = -1;
    //    _audioPlayer.currentTime    = ;
    [_audioPlayer prepareToPlay];
    [_audioPlayer play];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    NSLog(@"\n audioPlayerDidFinishPlaying \n");
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error{
    NSLog(@"\n audioPlayerDecodeErrorDidOccur \n");
}

@end
