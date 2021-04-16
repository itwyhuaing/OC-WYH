//
//  AVAudioRecorderVC.m
//  AVFoundationDemo
//
//  Created by hnbwyh on 2019/10/14.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "AVAudioRecorderVC.h"
#import <AVFoundation/AVFoundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface AVAudioRecorderVC ()<AVAudioPlayerDelegate>

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
    NSString *file = [NSString stringWithFormat:@"%@/custom_recoder.caf",cachePath];
    [self recorderStart:file];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self recorderStop];
}

-(void)dealloc {
    NSLog(@"\n 语音录制-录制容器销毁 \n");
    [self recorderStop];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self recorderStop];
}

#pragma mark - 录音回调

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    NSLog(@"\n\n 语音录制： %s \n flag:%d \n\n",__FUNCTION__,flag);
}

/* if an error occurs while encoding it will be reported to the delegate. */
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error {
    NSLog(@"\n\n 语音录制： %s \n error:%@ \n\n",__FUNCTION__,error);
}

#pragma mark - 开启录音
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
            [MBProgressHUD showHUDAddedTo:self.view animated:TRUE];
            [self.recorder record];
            [self startVoiceTimer];
        }
    }
    
    
}

#pragma mark - 停止录音、停止音量检测
- (void)recorderStop {
    NSLog(@"\n\n 语音录制-停止录音 \n\n");
    [MBProgressHUD hideHUDForView:self.view animated:TRUE];
    [self.recorder stop];
    // 停止录音后释放掉
    self.recorder.delegate = nil;
    self.recorder          = nil;
    [self stopVoiceTimer];
}

#pragma mark - 开启音量检测
- (void)startVoiceTimer {
    NSLog(@"\n\n 语音录制-开始检测音量 \n\n");
    self.voiceTimer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(detectionVoice) userInfo:nil repeats:TRUE];
    [[NSRunLoop currentRunLoop] addTimer:self.voiceTimer forMode:NSRunLoopCommonModes];
    [self.voiceTimer setFireDate:[NSDate distantPast]];
}

- (void)detectionVoice {
    [self.recorder updateMeters];
    double voiceValue = pow(0.05, [self.recorder peakPowerForChannel:0]);
    NSLog(@"\n\n 语音录制-标记 voice :%f \n\n",voiceValue);
}

#pragma mark - 停止音量检测
- (void)stopVoiceTimer {
    NSLog(@"\n\n 语音录制-停止检测音量 \n\n");
    if (self.voiceTimer) {
        //[self.voiceTimer setFireDate:[NSDate distantFuture]];
        if ([self.voiceTimer isValid]) {
            [self.voiceTimer invalidate];
        }
        self.voiceTimer = nil;
    }
}

@end
