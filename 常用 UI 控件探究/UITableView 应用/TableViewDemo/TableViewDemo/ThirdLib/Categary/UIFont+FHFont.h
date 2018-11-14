//
//  UIFont+FHFont.h
//  FineHouse
//
//  Created by hnbwyh on 2018/10/26.
//  Copyright © 2018年 Hinabian. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^FontStyleBlock)(UIFont *font);
@interface UIFont (FHFont)

+ (void)asynchronouslySetFontName:(NSString *)fontName fontSize:(CGFloat)fontSize fontBlock:(FontStyleBlock)fontBlock;

@end

NS_ASSUME_NONNULL_END
