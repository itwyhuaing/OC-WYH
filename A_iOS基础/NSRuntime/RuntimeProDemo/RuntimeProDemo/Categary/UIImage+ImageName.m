//
//  UIImage+ImageName.m
//  RuntimeProDemo
//
//  Created by hnbwyh on 2018/1/31.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "UIImage+ImageName.h"


@implementation UIImage (ImageName)

+(void)load{
    
    SEL systemSEL = @selector(imageNamed:);
    
    // 获取 SEL 常用方法
    //SEL sel1 = @selector(imageNamed:);
    
    // 获取 IMP 常用方法
    //IMP ip1 = class_getMethodImplementation(<#Class  _Nullable __unsafe_unretained cls#>, <#SEL  _Nonnull name#>);
    //IMP ip3 = method_getImplementation(<#Method  _Nonnull m#>)
    
    // 获取 Method 常用方法
    //Method m1 = class_getClassMethod(<#Class  _Nullable __unsafe_unretained cls#>, <#SEL  _Nonnull name#>)
    //Method m2 = class_getInstanceMethod(<#Class  _Nullable __unsafe_unretained cls#>, <#SEL  _Nonnull name#>)
    
    
    //class_addMethod(<#Class  _Nullable __unsafe_unretained cls#>, <#SEL  _Nonnull name#>, <#IMP  _Nonnull imp#>, <#const char * _Nullable types#>)
    
    //class_replaceMethod(<#Class  _Nullable __unsafe_unretained cls#>, <#SEL  _Nonnull name#>, <#IMP  _Nonnull imp#>, <#const char * _Nullable types#>)
    
    //method_exchangeImplementations(<#Method  _Nonnull m1#>, <#Method  _Nonnull m2#>)
    
    
    Method systemMethod = class_getClassMethod(self, systemSEL);
    
    SEL customSEL = @selector(yh_imageNamed:);
    Method customMethod = class_getClassMethod(self, customSEL);
    
    method_exchangeImplementations(systemMethod, customMethod);
    
}

+ (UIImage *)yh_imageNamed:(NSString *)name{
    CGFloat dVersion = [[UIDevice currentDevice].systemVersion doubleValue];
    if (dVersion >= 7.0) {
        name = [name stringByAppendingString:@"_ios7"];
        NSLog(@" \n 方法已交换 \n ");
    }
    return [UIImage yh_imageNamed:name];
}



@end
