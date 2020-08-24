//
//  ImgTextAttachment.m
//  Share
//
//  Created by hnbwyh on 16/9/27.
//  Copyright © 2016年 hnbwyh. All rights reserved.
//

#import "ImgTextAttachment.h"

@implementation ImgTextAttachment

-(CGRect)attachmentBoundsForTextContainer:(NSTextContainer *)textContainer proposedLineFragment:(CGRect)lineFrag glyphPosition:(CGPoint)position characterIndex:(NSUInteger)charIndex{
    
    CGRect rect = CGRectZero;
    
    rect = CGRectMake(0, 0, lineFrag.size.height, lineFrag.size.height);
    
    return rect;
    
}

@end
