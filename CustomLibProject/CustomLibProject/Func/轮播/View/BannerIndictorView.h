//
//  BannerIndictorView.h
//  YHScrollBannerView
//
//  Created by wangyinghua on 2017/5/12.
//  Copyright © 2017年 wangyinghua. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**<Bar 尺寸>*/
#define kTopBottomGap           3.0//(3.0 * SCREEN_WIDTHRATE_6)
#define kInternalGap            6.0//(6.0 * SCREEN_WIDTHRATE_6)
#define kCommonHeight           3.0//(3.0 * SCREEN_WIDTHRATE_6)
#define kMaxWidth               15.0//(15.0 * SCREEN_WIDTHRATE_6)
#define kMinWidth               8.0//(8.0 * SCREEN_WIDTHRATE_6)

/**<Bar 样式>*/
typedef enum : NSUInteger {
    BannerIndictorViewStylePageControl = 88888,
    BannerIndictorViewStyleIndexCount,
    BannerIndictorViewStyleAnimationImage,
    BannerIndictorViewStyleNone,
} BannerIndictorViewStyle;

@interface BannerIndictorView : UIView


/**
 配置指示器

 @param barStyle 指示器样式
 @param frame 指示器位置
 @param totalCount 指示器所需展示最大值
 */
- (void)configBannerIndictorViewWithStyle:(BannerIndictorViewStyle)barStyle
                              frame:(CGRect)frame
                     totalPageCount:(NSInteger)totalCount;


/**
 跳转位置

 @param location 目标位置
 */
- (void)goToPageAtLocation:(NSInteger)location;

@end

NS_ASSUME_NONNULL_END
