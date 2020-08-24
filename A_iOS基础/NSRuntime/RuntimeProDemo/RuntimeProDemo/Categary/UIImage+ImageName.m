//
//  UIImage+ImageName.m
//  RuntimeProDemo
//
//  Created by hnbwyh on 2018/1/31.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "UIImage+ImageName.h"


@implementation UIImage (ImageName)

//+(void)load{
//    
//    SEL systemSEL = @selector(imageNamed:);
//    Method systemMethod = class_getClassMethod(self, systemSEL);
//    
//    SEL customSEL = @selector(yh_imageNamed:);
//    Method customMethod = class_getClassMethod(self, customSEL);
//    
//    method_exchangeImplementations(systemMethod, customMethod);
//    
//}

+ (UIImage *)yh_imageNamed:(NSString *)name{
    CGFloat dVersion = [[UIDevice currentDevice].systemVersion doubleValue];
    if (dVersion >= 7.0) {
        name = [name stringByAppendingString:@"_ios7"];
        NSLog(@" \n 方法已交换 \n ");
    }
    return [UIImage yh_imageNamed:name];
}

@end
