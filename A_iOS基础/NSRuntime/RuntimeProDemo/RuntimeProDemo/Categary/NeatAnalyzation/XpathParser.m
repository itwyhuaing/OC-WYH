//
//  XpathParser.m
//  RuntimeProDemo
//
//  Created by hnbwyh on 2020/8/17.
//  Copyright © 2020 ZhiXingJY. All rights reserved.
//

#import "XpathParser.h"
#import <CommonCrypto/CommonDigest.h>
//#import <CommonCrypto/CommonCrypto.h>
//#import <CommonCrypto/CommonHMAC.h>

@implementation XpathParser

+ (NSString *)xpathForView:(UIView *)view {
    //================= xpath 统计分析
    UIResponder *responder = view;
    NSMutableString *log_pre = [NSMutableString stringWithString:@"--"];
    NSMutableString *pstring = [NSMutableString new];
    while (responder) {
        // --------------------------- 类名称
        [pstring appendString:NSStringFromClass(responder.class)];
        // --------------------------- 计算当前响应者在父类的位置/次序
        NSString *location = @"0";
        // responder 为普通 view
        if ([responder isKindOfClass:[UIView class]]) {
            UIView *t = (UIView *)responder;
            UIView *s = t.superview;
            if (s && s.subviews) {
                location = [NSString stringWithFormat:@"%ld",[s.subviews indexOfObject:t]];
            }
        }
        
        // responder 为 tableViewcell
        if ([responder isKindOfClass:[UITableViewCell class]]) {
            UITableViewCell *tc = (UITableViewCell *)responder;
            UIView *s = tc.superview;
            if (s && [s isKindOfClass:[UITableView class]]) {
                UITableView *st = (UITableView *)s;
                NSIndexPath *idxPath  = [st indexPathForCell:tc];
                location = [NSString stringWithFormat:@"%ldsection%ldrow",idxPath.section,idxPath.row];
            }
        }
        
        // responder 为 collectioncell
        if ([responder isKindOfClass:[UICollectionViewCell class]]) {
            UICollectionViewCell *tc = (UICollectionViewCell *)responder;
            UIView *s = tc.superview;
            if (s && [s isKindOfClass:[UITableView class]]) {
                UICollectionView *st = (UICollectionView *)s;
                NSIndexPath *idxPath  = [st indexPathForCell:tc];
                location = [NSString stringWithFormat:@"%ldsection%ldrow",idxPath.section,idxPath.row];
            }
        }
        [pstring appendFormat:@"%@",location];
        // ---------------------------
        NSLog(@"%@%@%@", log_pre, NSStringFromClass([responder class]),location);
        
        [log_pre appendString:@"--"];
        responder = responder.nextResponder;
    }
     NSLog(@"\n xpath 计算结果:\n %@ \n %@ \n ",pstring,[self md5HexDigest:pstring]);
    //=================
    return pstring;
}



#pragma mark - private method
+ (NSString *) md5HexDigest:(NSString*)str {
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
