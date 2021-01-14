//
//  Util.m
//  WKLocalImagesDemo
//
//  Created by hnbwyh on 2021/1/13.
//

#import "Util.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Util

+(NSString *)md5HexDigest:(NSString*)str {
    if (str == Nil) {
        return @"";
    }
    const char *original_str = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (CC_LONG)strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

@end
