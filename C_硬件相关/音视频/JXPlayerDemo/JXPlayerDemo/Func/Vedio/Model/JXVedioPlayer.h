//
//  JXVedioPlayer.h
//  JXPlayerDemo
//
//  Created by hnbwyh on 2019/3/8.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JXVedioPlayer : NSObject


// 播放视频
-(AVPlayerLayer *)playVedioWithURLString:(NSString *)URLString;

@end

NS_ASSUME_NONNULL_END
