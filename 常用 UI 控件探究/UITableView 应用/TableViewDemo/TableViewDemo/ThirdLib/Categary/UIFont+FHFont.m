//
//  UIFont+FHFont.m
//  FineHouse
//
//  Created by hnbwyh on 2018/10/26.
//  Copyright © 2018年 Hinabian. All rights reserved.
//

#import "UIFont+FHFont.h"
#import <CoreText/CoreText.h>

@implementation UIFont (FHFont)


+ (void)asynchronouslySetFontName:(NSString *)fontName fontSize:(CGFloat)fontSize fontBlock:(FontStyleBlock)fontBlock{
    
    __block NSString *errorMessage;
    UIFont* aFont = [UIFont fontWithName:fontName size:fontSize];
    // If the font is already downloaded
    if (aFont && ([aFont.fontName compare:fontName] == NSOrderedSame || [aFont.familyName compare:fontName] == NSOrderedSame)) {
        // Go ahead and display the sample text.
        //NSLog(@"\n %@ 字体已存在 \n",fontName);
        fontBlock ? fontBlock(aFont) : nil;
        
        return;
    }
    
    // Create a dictionary with the font's PostScript name.
    NSMutableDictionary *attrs = [NSMutableDictionary dictionaryWithObjectsAndKeys:fontName, kCTFontNameAttribute, nil];
    
    // Create a new font descriptor reference from the attributes dictionary.
    CTFontDescriptorRef desc = CTFontDescriptorCreateWithAttributes((__bridge CFDictionaryRef)attrs);
    
    NSMutableArray *descs = [NSMutableArray arrayWithCapacity:0];
    [descs addObject:(__bridge id)desc];
    CFRelease(desc);
    
    __block BOOL errorDuringDownload = NO;
    
    // Start processing the font descriptor..
    // This function returns immediately, but can potentially take long time to process.
    // The progress is notified via the callback block of CTFontDescriptorProgressHandler type.
    // See CTFontDescriptor.h for the list of progress states and keys for progressParameter dictionary.
    CTFontDescriptorMatchFontDescriptorsWithProgressHandler( (__bridge CFArrayRef)descs, NULL,  ^(CTFontDescriptorMatchingState state, CFDictionaryRef progressParameter) {
        
        if (state == kCTFontDescriptorMatchingDidBegin) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                
                NSLog(@"\n %@ 字体已经匹配 \n",fontName);
                
            });
        } else if (state == kCTFontDescriptorMatchingDidFinish) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                NSLog(@"\n %@ 字体下载完成1 \n",fontName);
                fontBlock ? fontBlock([UIFont fontWithName:fontName size:fontSize]) : nil;
                // Log the font URL in the console
                CTFontRef fontRef = CTFontCreateWithName((__bridge CFStringRef)fontName, 0., NULL);
                CFStringRef fontURL = CTFontCopyAttribute(fontRef, kCTFontURLAttribute);
                NSLog(@"字体下载地址 ：%@", (__bridge NSURL*)(fontURL));
                CFRelease(fontURL);
                CFRelease(fontRef);
            });
        } else if (state == kCTFontDescriptorMatchingWillBeginDownloading) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Show a progress bar
                NSLog(@"\n %@ 字体开始下载 \n",fontName);
            });
        } else if (state == kCTFontDescriptorMatchingDidFinishDownloading) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Remove the progress bar
                NSLog(@"\n %@ 字体下载完成2 \n",fontName);
                fontBlock ? fontBlock([UIFont fontWithName:fontName size:fontSize]) : nil;
            });
        } else if (state == kCTFontDescriptorMatchingDownloading) {
            dispatch_async( dispatch_get_main_queue(), ^ {
                // Use the progress bar to indicate the progress of the downloading
                NSLog(@"\n %@ 字体下载中 ... \n",fontName);
            });
        } else if (state == kCTFontDescriptorMatchingDidFailWithError) {
            // An error has occurred.
            // Get the error message
            NSError *error = [(__bridge NSDictionary *)progressParameter objectForKey:(id)kCTFontDescriptorMatchingError];
            if (error != nil) {
                errorMessage = [error description];
            } else {
                errorMessage = @"ERROR MESSAGE IS NOT AVAILABLE!";
            }
            // Set our flag
            errorDuringDownload = YES;
            
            dispatch_async( dispatch_get_main_queue(), ^ {
                NSLog(@"\n %@ 字体下载失败: %@ \n",fontName ,errorMessage);
            });
        }
        
        return (bool)YES;
    });
    
}


@end
