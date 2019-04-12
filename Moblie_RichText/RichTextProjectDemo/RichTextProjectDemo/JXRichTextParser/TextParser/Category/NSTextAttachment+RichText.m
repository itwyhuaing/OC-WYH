//
//  NSTextAttachment+RichText.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/12.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "NSTextAttachment+RichText.h"
#import <objc/runtime.h>

static char kRichTextAttachmentInfo;

@implementation NSTextAttachment (RichText)

-(NSDictionary *)extendedInfo{
    return objc_getAssociatedObject(self, &kRichTextAttachmentInfo);
}

-(void)setExtendedInfo:(NSDictionary *)extendedInfo{
    objc_setAssociatedObject(self, &kRichTextAttachmentInfo, extendedInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
