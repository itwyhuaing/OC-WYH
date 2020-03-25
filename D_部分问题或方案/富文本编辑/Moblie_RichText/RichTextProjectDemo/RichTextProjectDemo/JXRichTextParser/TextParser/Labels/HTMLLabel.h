//
//  HTMLLabel.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/12.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTMLLabel : NSObject

+ (instancetype)currentLabel;

// 首行缩进
@property (nonatomic,assign) CGFloat adjustedFirstLineHeadIndentScale;

// 行间距
@property (nonatomic,assign) CGFloat adjustedLineSpacingScale;

// 字间距
@property (nonatomic,assign) CGFloat adjustedKernScale;

// 字体大小
@property (nonatomic,assign) CGFloat adjustedFontSizeScale;

// <p></p>
+ (NSString *)htmlLabelForPLabelWithTextAttributes:(NSDictionary *)attributes;

// <font><b><i><s><u></u></s></i></b></font>
+ (NSString *)htmlLabelForFontLabelWithTextAttributes:(NSDictionary *)attributes content:(NSString *)text;

// <img />
+ (NSString *)htmlLabelForImgLabelWithTextAttributes:(NSDictionary *)attributes;

@end

NS_ASSUME_NONNULL_END
