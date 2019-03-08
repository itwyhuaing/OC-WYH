//
//  VedioAVPlayerVC.m
//  JXPlayerDemo
//
//  Created by hnbwyh on 2019/1/25.
//  Copyright © 2019年 JiXia. All rights reserved.
//

#import "VedioAVPlayerVC.h"
#import "JXVedioPlayer.h"

@interface VedioAVPlayerVC ()

@property (nonatomic,strong) JXVedioPlayer *jxVedioPlayer;

@end

@implementation VedioAVPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"01.mp4" ofType:nil];
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"voice01.flac" ofType:nil];
    NSString *filePath3 = [[NSBundle mainBundle] pathForResource:@"Voice02.mp3" ofType:nil];
    [self.view.layer addSublayer:[self.jxVedioPlayer playVedioWithURLString:filePath]];
    
}


-(JXVedioPlayer *)jxVedioPlayer{
    if (!_jxVedioPlayer) {
        _jxVedioPlayer = [[JXVedioPlayer alloc] init];
    }
    return _jxVedioPlayer;
}

@end
