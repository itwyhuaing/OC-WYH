//
//  UIFont+Fonts.h
//  dada
//
//  Created by yujian on 15/6/17.
//  Copyright (c) 2015年 yujian. All rights reserved.
//

@interface UIFont(Fonts)

+ (UIFont *)ddNoteContentFont;
- (CGSize) estimateTextSize:(NSString *)text textWidth:(float) width;

@end
