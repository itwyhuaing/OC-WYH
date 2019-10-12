//
//  VoiceAVPlayerVC.m
//  JXPlayerDemo
//
//  Created by hnbwyh on 2019/1/25.
//  Copyright © 2019年 JiXia. All rights reserved.
//

#import "VoiceAVPlayerVC.h"
#import "AppDelegate.h"
#import "JXVoiceAVPlayer.h"

@interface VoiceAVPlayerVC ()

@property (strong, nonatomic) JXVoiceAVPlayer        *jxVoicePlayer;
@property (nonatomic,strong)  UIProgressView         *progess;
@property (nonatomic,strong)  UIView                 *circle;

@end


@implementation VoiceAVPlayerVC

+(instancetype)currentAVPlayerVC {
    static VoiceAVPlayerVC *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[VoiceAVPlayerVC alloc] init];
    });
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    
    __weak typeof(self)weakSelf = self;
    // 缓冲
    self.jxVoicePlayer.loadedScale = ^(NSTimeInterval ti) {
         NSLog(@"\n\n 缓冲百分比 ：%f \n\n",ti);
    };
    
    // 播放
    self.jxVoicePlayer.playedScale = ^(NSTimeInterval ti) {
        NSLog(@" \n\n 播放进度 ：%f \n\n ",ti);
        weakSelf.progess.progress = ti;
        CGFloat offsetX = ti * CGRectGetWidth(weakSelf.progess.frame);
        CGRect rect = weakSelf.circle.frame;
        rect.origin.x = CGRectGetMinX(weakSelf.progess.frame) - CGRectGetWidth(weakSelf.circle.frame)/2.0 + offsetX;
        [weakSelf.circle setFrame:rect];
    };
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.jxVoicePlayer remoteControlEventWithVC:self isResign:FALSE];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

// 销毁 - 释放
-(void)dealloc{
    NSLog(@"\n\n dealloc \n\n");
    [self.jxVoicePlayer remoteControlEventWithVC:self isResign:TRUE];
    [self.jxVoicePlayer jx_removeObservers];
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event{
    [self.jxVoicePlayer remoteControlReceivedEvent:event];
}

#pragma mark --- UI - ClickEvent

- (void)addSubviews{
    
    CGRect rct    = CGRectZero;
    CGSize sgSize = CGSizeMake(200, 30);
    rct           = CGRectMake(CGRectGetMidX(self.progess.frame) - sgSize.width/2.0,
                               CGRectGetMinY(self.progess.frame) - sgSize.height - 20,
                               sgSize.width, sgSize.height);
    UISegmentedControl *segControl = [[UISegmentedControl alloc] initWithItems:@[@"本地资源",@"远程资源"]];
    UISegmentedControl *segCtl = [[UISegmentedControl alloc] initWithItems:@[@"后退",@"快进"]];
    [segControl setFrame:rct];
    rct.origin.y = CGRectGetMaxY(self.progess.frame) + 20;
    [segCtl setFrame:rct];
    
    [segControl addTarget:self action:@selector(clickEventSegControl:) forControlEvents:UIControlEventValueChanged];
    [segCtl addTarget:self action:@selector(clickEventSegControl2:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segCtl];
    [self.view addSubview:segControl];
    [self.view addSubview:self.circle];
    
}

- (void)clickEventSegControl:(UISegmentedControl *)sl{
    switch (sl.selectedSegmentIndex) {
        case 0:
            {
                [self.jxVoicePlayer playVoiceWithURLString:@""];
            }
            break;
        case 1:
            {
                NSString *URLString = @"https://hinabian-oss.oss-cn-shenzhen.aliyuncs.com/20190115/87c8e454242f63847661005f7810d953.mp3";
                [self.jxVoicePlayer playVoiceWithURLString:URLString];
            }
            break;
        default:
            break;
    }
}

- (void)clickEventSegControl2:(UISegmentedControl *)sl{
    
    switch (sl.selectedSegmentIndex) {
        case 0:
        {
            NSLog(@"\n\n 快退 \n\n");
        }
            break;
        case 1:
        {
            NSLog(@"\n\n 快进 \n\n");
        }
            break;
        default:
            break;
    }
}

#pragma mark --- outer method

- (void)playBackEnable:(BOOL)able{
    [self.jxVoicePlayer playBackEnable:able];
}

#pragma mark --- lazy load

-(JXVoiceAVPlayer *)jxVoicePlayer{
    if (!_jxVoicePlayer) {
        _jxVoicePlayer = [[JXVoiceAVPlayer alloc] init];
    }
    return _jxVoicePlayer;
}


-(UIProgressView *)progess{
    if (!_progess) {
        _progess = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progess.trackTintColor    = [UIColor orangeColor];
        _progess.progressTintColor = [UIColor cyanColor];
        [_progess setFrame:CGRectMake(20, 150, [UIScreen mainScreen].bounds.size.width - 40.0, 10)];
        [self.view addSubview:_progess];
    }
    return _progess;
}

- (UIView *)circle{
    if (!_circle) {
        _circle = [[UIView alloc] init];
        [_circle setFrame:CGRectMake(0, 0, 6.0, 6.0)];
        [_circle setCenter:CGPointMake(CGRectGetMinX(self.progess.frame),CGRectGetMidY(self.progess.frame))];
        _circle.clipsToBounds = TRUE;
        _circle.backgroundColor = [UIColor redColor];
        _circle.layer.cornerRadius = 3.0;
        [self.view addSubview:_circle];
    }
    return _circle;
}

@end
