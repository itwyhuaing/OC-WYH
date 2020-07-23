//
//  UIFont+JXFont.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/23.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (JXFont)

@property (nonatomic,assign) BOOL bold;
@property (nonatomic,assign) CGFloat fontSize;

- (UIFont *)customFont;

@end
