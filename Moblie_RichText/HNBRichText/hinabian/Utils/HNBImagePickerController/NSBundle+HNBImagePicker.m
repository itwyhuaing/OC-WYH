//
//  NSBundle+HNBImagePicker.m
//  HNBImagePickerController
//
//  Created by 谭真 on 16/08/18.
//  Copyright © 2016年 谭真. All rights reserved.
//

#import "NSBundle+HNBImagePicker.h"
#import "HNBImagePickerController.h"

@implementation NSBundle (HNBImagePicker)

+ (instancetype)hnb_imagePickerBundle {
    static NSBundle *hnbBundle = nil;
    if (hnbBundle == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"HNBImagePickerController" ofType:@"bundle"];
        if (!path) {
            path = [[NSBundle mainBundle] pathForResource:@"HNBImagePickerController" ofType:@"bundle" inDirectory:@"Frameworks/HNBImagePickerController.framework/"];
        }
        hnbBundle = [NSBundle bundleWithPath:path];
    }
    return hnbBundle;
}

+ (NSString *)hnb_localizedStringForKey:(NSString *)key {
    return [self hnb_localizedStringForKey:key value:@""];
}

+ (NSString *)hnb_localizedStringForKey:(NSString *)key value:(NSString *)value {
    static NSBundle *bundle = nil;
    if (bundle == nil) {
        NSString *language = [NSLocale preferredLanguages].firstObject;
        if ([language rangeOfString:@"zh-Hans"].location != NSNotFound) {
            language = @"zh-Hans";
        } else {
            language = @"en";
        }
        bundle = [NSBundle bundleWithPath:[[NSBundle hnb_imagePickerBundle] pathForResource:language ofType:@"lproj"]];
    }
    NSString *value1 = [bundle localizedStringForKey:key value:value table:nil];
    return value1;
}
@end
