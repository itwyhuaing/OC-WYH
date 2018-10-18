//
//  UIFont+JXFont.h
//  JXObjCategary
//
//  Created by hnbwyh on 2018/10/18.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FontStyleBlock)(UIFont *font);
@interface UIFont (JXFont)

+ (void)asynchronouslySetFontName:(NSString *)fontName fontSize:(CGFloat)fontSize fontBlock:(FontStyleBlock)fontBlock;

@end
