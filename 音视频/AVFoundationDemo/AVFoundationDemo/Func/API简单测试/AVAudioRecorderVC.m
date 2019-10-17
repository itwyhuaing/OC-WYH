//
//  AVAudioRecorderVC.m
//  AVFoundationDemo
//
//  Created by hnbwyh on 2019/10/14.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "AVAudioRecorderVC.h"
#import <AVFoundation/AVFoundation.h>

@interface AVAudioRecorderVC ()<AVAudioPlayerDelegate>

@property (nonatomic,strong) AVAudioPlayer      *audioPlayer;

@property (nonatomic,strong) AVAudioRecorder    *recorder;

@property (nonatomic,strong) NSTimer            *voiceTimer;

@end

@implementation AVAudioRecorderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);
    
    // 启动录音
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, TRUE) firstObject];
    NSString *file = [NSString stringWithFormat:@"%@/recoder.caf",cachePath];
    [self recorderStart:file];
    // 设置停止时间
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf recorderStop];
    });
}

-(void)dealloc {
    [self recorderStop];
    if (self.voiceTimer) {
        self.voiceTimer.isValid ? [self.voiceTimer invalidate] : nil;
        self.voiceTimer = nil;
    }
}

#pragma mark ====== 播放录音操作
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"\n\n 播放录音 touchesBegan \n\n" );
    
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, TRUE) firstObject];
    NSString *file = [NSString stringWithFormat:@"%@/recoder.caf",cachePath];
    NSURL    *sourceURL  = [NSURL fileURLWithPath:file];
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:sourceURL error:nil];
    self.audioPlayer = audioPlayer;
    audioPlayer.delegate       = (id)self;
    audioPlayer.volume         = 0.8;
    [audioPlayer prepareToPlay];
    [audioPlayer play];
}

#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSLog(@"\n\n %s \n 播放录音 flag : %d \n\n",__FUNCTION__,flag);
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error {
    NSLog(@"\n\n %s \n 播放录音 error :%@ \n\n",__FUNCTION__,error);
}

#pragma mark ====== 录音操作

-(void)recorderStart:(NSString *)filePath {
    if (!filePath || filePath.length <= 0) {
        return;
    }
    // 参数设置 格式、采样率、录音通道、线性采样位数、录音质量
    NSMutableDictionary *recorderDict = [NSMutableDictionary dictionary];
    [recorderDict setValue:[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [recorderDict setValue:[NSNumber numberWithInt:16000] forKey:AVSampleRateKey];
    [recorderDict setValue:[NSNumber numberWithInt:2] forKey:AVNumberOfChannelsKey];
    [recorderDict setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [recorderDict setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    // 生成录音文件
    NSURL *urlAudioRecorder = [NSURL fileURLWithPath:filePath];
    self.recorder = [[AVAudioRecorder alloc] initWithURL:urlAudioRecorder
                                                settings:recorderDict
                                                   error:nil];
    // 开启音量检测
    self.recorder.meteringEnabled = TRUE;
    self.recorder.delegate        = (id)self;
    
    if (self.recorder) {
        // 录音时设置 audioSession 属性，是否不兼容 iOS 7
        AVAudioSession *recordSession = [AVAudioSession sharedInstance];
        [recordSession setCategory:AVAudioSessionCategoryRecord error:nil];
        [recordSession setActive:TRUE error:nil];
        if ([self.recorder prepareToRecord]) {
            [self.recorder record];
            [self startVoiceTimer];
        }
    }
    
    
}

- (void)recorderStop {
    if (self.recorder) {
        if ([self.recorder isRecording]) {
            [self.recorder stop];
            // 停止录音后释放掉
            self.recorder.delegate = nil;
            self.recorder          = nil;
        }
    }
    [self stopVoiceTimer];
}

- (void)startVoiceTimer {
    NSLog(@"\n\n 开始检测音量 \n\n");
    self.voiceTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(detectionVoice) userInfo:nil repeats:TRUE];
    [[NSRunLoop currentRunLoop] addTimer:self.voiceTimer forMode:NSRunLoopCommonModes];
    [self.voiceTimer setFireDate:[NSDate distantPast]];
}

- (void)stopVoiceTimer {
    NSLog(@"\n\n 停止检测音量 \n\n");
    if (self.voiceTimer) {
        [self.voiceTimer setFireDate:[NSDate distantFuture]];
        if ([self.voiceTimer isValid]) {
            [self.voiceTimer invalidate];
        }
        self.voiceTimer = nil;
    }
}

- (void)detectionVoice {
    [self.recorder updateMeters];
    double voiceValue = pow(0.05, [self.recorder peakPowerForChannel:0]);
    NSLog(@"\n\n 标记 voice :%f \n\n",voiceValue);
}

@end
