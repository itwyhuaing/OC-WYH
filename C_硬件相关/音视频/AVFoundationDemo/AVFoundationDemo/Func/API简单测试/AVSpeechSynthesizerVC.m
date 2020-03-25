//
//  AVSpeechSynthesizerVC.m
//  AVFoundationDemo
//
//  Created by hnbwyh on 2019/10/14.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "AVSpeechSynthesizerVC.h"
#import <AVFoundation/AVFoundation.h>


@interface AVSpeechSynthesizerVC ()<AVSpeechSynthesizerDelegate>

@property (nonatomic,strong) AVSpeechSynthesizer *synthesizer;

@end

@implementation AVSpeechSynthesizerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);
    
    // 初始化播报资源
    [self speakHintMessage];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
 
}

- (void)speakHintMessage {
    
    AVSpeechSynthesizer     *synthesizer = [[AVSpeechSynthesizer alloc] init];
    self.synthesizer                     = synthesizer;
    AVSpeechSynthesisVoice  *voice       = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    AVSpeechUtterance       *utterance   = [[AVSpeechUtterance alloc] initWithString:@"看着这么多内容感觉这个框架我们都能学习一大堆东西，我们接着往下总结先。"];
    utterance.rate                       = 0.5;
    utterance.voice                      = voice;
    utterance.pitchMultiplier            = 0.8;
    utterance.postUtteranceDelay         = 0.1;
    synthesizer.delegate                 = (id)self;
    [synthesizer speakUtterance:utterance];
    
    NSLog(@"\n\n\n 系统所支持的语音列表: %@ \n\n\n",[AVSpeechSynthesisVoice speechVoices]);
    
}

#pragma mark ------ AVSpeechSynthesizerDelegate

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didStartSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"\n\n %s \n\n",__FUNCTION__);
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"\n\n %s \n\n",__FUNCTION__);
}

- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"\n\n %s \n\n",__FUNCTION__);
}


- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"\n\n %s \n\n",__FUNCTION__);
}


- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance *)utterance{
    NSLog(@"\n\n %s \n\n",__FUNCTION__);
    [self.synthesizer continueSpeaking];
}


- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer willSpeakRangeOfSpeechString:(NSRange)characterRange utterance:(AVSpeechUtterance *)utterance{
    NSLog(@"\n\n %s \n %ld - %ld \n\n",__FUNCTION__,characterRange.location,characterRange.length);
}

@end
