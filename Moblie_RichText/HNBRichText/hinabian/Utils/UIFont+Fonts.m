//
//  UIFont+Fonts.m
//  dada
//
//  Created by yujian on 15/6/17.
//  Copyright (c) 2015年 yujian. All rights reserved.
//

#import "UIFont+Fonts.h"

@implementation UIFont(Fonts)

+ (UIFont *)ddNoteContentFont{
    return [UIFont systemFontOfSize:15];
}

- (CGSize) estimateTextSize:(NSString *)text textWidth:(float) width
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName : self}
                                     context:nil];
    return rect.size;
}

@end
