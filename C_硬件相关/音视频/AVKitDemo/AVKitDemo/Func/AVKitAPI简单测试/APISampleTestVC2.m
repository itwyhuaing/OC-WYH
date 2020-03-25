//
//  APISampleTestVC2.m
//  AVKitDemo
//
//  Created by hnbwyh on 2019/10/12.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "APISampleTestVC2.h"
#import <AVKit/AVKit.h>

@interface APISampleTestVC2 ()

@property (nonatomic,strong) NSString *vedioURL;

@property (nonatomic,strong) AVPlayerViewController *playerVC;

@end

@implementation APISampleTestVC2

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.vedioURL = [[NSBundle mainBundle] pathForResource:@"01" ofType:@"mp4"];
    self.playerVC = [[AVPlayerViewController alloc] init];
    self.playerVC.player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:self.vedioURL relativeToURL:[NSURL  URLWithString:@"https://www.baidu.com"]]];
    self.playerVC.showsPlaybackControls   =   TRUE;
    self.playerVC.allowsPictureInPicturePlayback = TRUE;
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    self.playerVC.view.frame = CGRectMake(10.0,120.0,CGRectGetWidth(screenBounds)-20.0,200.0);
    [self.view addSubview:self.playerVC.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.playerVC.readyForDisplay) {
            [self.playerVC.player play];
        }
    });
}

@end
