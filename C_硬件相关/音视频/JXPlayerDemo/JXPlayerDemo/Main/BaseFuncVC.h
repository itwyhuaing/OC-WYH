//
//  BaseFuncVC.h
//  JXPlayerDemo
//
//  Created by hnbwyh on 2019/1/24.
//  Copyright © 2019年 JiXia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
    FuncTypeVoiceAVAudioSystem = 800008,
    FuncTypeVoiceAVAudioCustom,
    FuncTypeAVPlayerVoice,
    FuncTypeAVPlayerVedio,
    FuncTypeVedio,
} FuncType;

@interface BaseFuncVC : UIViewController

@property (nonatomic,assign) FuncType   type;

@end

NS_ASSUME_NONNULL_END
