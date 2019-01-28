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

@property (nonatomic,strong) UIProgressView         *progess;
@property (nonatomic,strong) UIView                 *circle;

@end


@implementation VoiceAVPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    
    // 缓冲
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    app.jxVoicePlayer.loadedScale = ^(NSTimeInterval ti) {
        NSLog(@"\n\n 缓冲百分比 ：%f \n\n",ti);
        self.progess.progress = ti;
    };
    
    // 播放
    app.jxVoicePlayer.playedScale = ^(NSTimeInterval ti) {
        NSLog(@" \n\n 播放进度 ：%f \n\n ",ti);
        CGFloat offsetX = ti * CGRectGetWidth(self.progess.frame);
        CGRect rect = self.circle.frame;
        rect.origin.x = CGRectGetMinX(self.progess.frame) - CGRectGetWidth(self.circle.frame)/2.0 + offsetX;
        [self.circle setFrame:rect];
    };
    
}

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
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    switch (sl.selectedSegmentIndex) {
        case 0:
            {
                [app.jxVoicePlayer playVoiceWithURLString:@""];
            }
            break;
        case 1:
            {
                NSString *URLString = @"https://hinabian-oss.oss-cn-shenzhen.aliyuncs.com/20190115/87c8e454242f63847661005f7810d953.mp3";
                [app.jxVoicePlayer playVoiceWithURLString:URLString];
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


-(UIProgressView *)progess{
    if (!_progess) {
        _progess = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progess.trackTintColor    = [UIColor orangeColor];
        _progess.progressTintColor = [UIColor blueColor];
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

// 销毁 - 释放
-(void)dealloc{
    NSLog(@"\n\n dealloc \n\n");
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [app.jxVoicePlayer jx_removeObservers];
}
@end
