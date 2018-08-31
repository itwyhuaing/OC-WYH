//
//  UIImageView+JXImageView.m
//  AnimationDemo
//
//  Created by hnbwyh on 2018/8/30.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "UIImageView+JXImageView.h"
#import <objc/runtime.h>

static char JXCustomImageNameKey;

@implementation UIImageView (JXImageView)

-(void)setImgName:(NSString *)imgName{
    objc_setAssociatedObject(self, &JXCustomImageNameKey, imgName, OBJC_ASSOCIATION_COPY);
}

-(NSString *)imgName{
    return objc_getAssociatedObject(self, &JXCustomImageNameKey);
}

@end
