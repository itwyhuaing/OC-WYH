//
//  UIFont+JXFont.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/23.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "UIFont+JXFont.h"
#import <objc/runtime.h>

@implementation UIFont (JXFont)

- (UIFont *)customFont{
    UIFont *rltFont = self.bold ? [UIFont boldSystemFontOfSize:self.fontSize] : [UIFont systemFontOfSize:self.fontSize];
    return rltFont;
}

#pragma mark ------ 关联

-(BOOL)bold{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

-(CGFloat)fontSize{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}


-(void)setBold:(BOOL)bold{
    objc_setAssociatedObject(self, @selector(bold), @(bold), OBJC_ASSOCIATION_ASSIGN);
}

-(void)setFontSize:(CGFloat)fontSize{
    objc_setAssociatedObject(self, @selector(fontSize), @(fontSize), OBJC_ASSOCIATION_ASSIGN);
}

@end
