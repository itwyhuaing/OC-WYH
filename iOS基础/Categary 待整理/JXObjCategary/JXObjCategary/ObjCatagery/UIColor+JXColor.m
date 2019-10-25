//
//  UIColor+JXColor.m
//  JXObjCategary
//
//  Created by hnbwyh on 2018/7/19.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "UIColor+JXColor.h"

@implementation UIColor (JXColor)

#pragma mark ------ RGB 样式 或 16 进制方式设置颜色

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha{
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}


+ (UIColor *)colorWithHexSring:(NSString *)hexString A:(CGFloat)alpha{
    if (hexString == nil) {
        return [UIColor clearColor];
    }
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:alpha];
}

#pragma mark ------ 依据图片获取颜色

+ (UIColor *)colorWithImage:(UIImage *)img{
    //方法来自http://blog.csdn.net/ki19880210/article/details/38750789
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize=CGSizeMake(40, 40);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, img.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    if (data == NULL) {
        CGContextRelease(context);
        return nil;
    }
    NSArray *MaxColor = nil;
    float maxScore = 0;
    for (int x = 0; x < thumbSize.width*thumbSize.height; x++) {
        int offset = 4*x;
        int red = data[offset];
        int green = data[offset+1];
        int blue = data[offset+2];
        int alpha =  data[offset+3];
        if (alpha < 25) {
            continue;
        }
        
        float h,s,v;
        RGBtoHSV(red, green, blue, &h, &s, &v);
        
        float y = MIN(abs(red*2104 + green*4130 + blue*802 + 4096 + 131072) >> 13, 235);
        y= (y-16)/(235-16);
        if (y > 0.9) {
            continue;
        }
        
        float score = (s + 0.1)*x;
        if (score>maxScore) {
            maxScore = score;
        }
        MaxColor=@[@(red),@(green),@(blue),@(alpha)];
    }
    CGContextRelease(context);
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

static void RGBtoHSV( float r, float g, float b, float *h, float *s, float *v ) {
    float min, max, delta;
    min = MIN( r, MIN( g, b ));
    max = MAX( r, MAX( g, b ));
    *v = max;               // v
    delta = max - min;
    if( max != 0 ) {
        *s = delta / max;       // s
    } else {
        // r = g = b = 0        // s = 0, v is undefined
        *s = 0;
        *h = -1;
        return;
    }
    if( r == max ) {
        *h = ( g - b ) / delta;     // between yellow & magenta
    } else if( g == max ) {
        *h = 2 + ( b - r ) / delta; // between cyan & yellow
    } else {
        *h = 4 + ( r - g ) / delta; // between magenta & cyan
    }
    *h *= 60;               // degrees
    if( *h < 0 ) {
        *h += 360;
    }
}

#pragma mark ------ 依据图片上的位置获取颜色

+(UIColor *)colorFromImage:(UIImage *)image location:(CGPoint)point{
    UIColor *ptClr = nil;
    if (CGRectContainsPoint(CGRectMake(0, 0, image.size.width, image.size.height), point)) {
        NSInteger ptX           = truncl(point.x); /**<直接舍去小数>*/
        NSInteger ptY           = truncl(point.y);
        CGImageRef cgimg        = image.CGImage;
        NSUInteger w            = image.size.width;
        NSUInteger h            = image.size.height;
        CGColorSpaceRef clrSpace= CGColorSpaceCreateDeviceRGB();/**<bitmap上下文使用的颜色空间>*/
        int bytesPerPixel        = 4;/**<bitmap在内存中所占的比特数>*/
        int bytesPerRow = bytesPerPixel * 1;   /**<bitmap的每一行在内存所占的比特数>*/
        NSUInteger bitsPerComponent = 8;   /**<内存中像素的每个组件的位数.例如，对于32位像素格式和RGB 颜色空间，你应该将这个值设为8>*/
        unsigned char pixelData[4] = {0, 0, 0, 0};  /**<初始化像素信息>*/
        /**<创建位图文件环境。位图文件可自行百度 bitmap 。指定bitmap是否包含alpha通道，像素中alpha通道的相对位置，像素组件是整形还是浮点型等信息的字符串。>*/
        CGContextRef context = CGBitmapContextCreate(pixelData,
                                                     1,
                                                     1,
                                                     bitsPerComponent,
                                                     bytesPerRow,
                                                     clrSpace,
                                                     kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
        CGColorSpaceRelease(clrSpace);
        CGContextSetBlendMode(context, kCGBlendModeCopy);/**<当一个颜色覆盖上另外一个颜色，两个颜色的混合方式>*/
        
        CGContextTranslateCTM(context, -ptX, ptY - (CGFloat)h);  /**<改变画布位置>*/
        CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)w, (CGFloat)h ), cgimg);   /**<绘制图片>*/
        CGContextRelease(context);
        
        CGFloat red = (CGFloat)pixelData[0] / 255.0f;
        CGFloat green = (CGFloat)pixelData[1] / 255.0f;
        CGFloat blue = (CGFloat)pixelData[2] / 255.0f;
        CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
        
        ptClr = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        
    }
    return ptClr;
}

@end
