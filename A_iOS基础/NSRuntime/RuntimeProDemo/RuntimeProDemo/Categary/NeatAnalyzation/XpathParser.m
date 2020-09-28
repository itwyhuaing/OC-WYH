//
//  XpathParser.m
//  RuntimeProDemo
//
//  Created by hnbwyh on 2020/8/17.
//  Copyright © 2020 ZhiXingJY. All rights reserved.
//

#import "XpathParser.h"
#import <CommonCrypto/CommonDigest.h>
#import "XpathFilter.h"

@implementation XpathParser

+ (instancetype)currentXpathParser {
    static XpathParser *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [XpathParser new];
    });
    return instance;
}

+ (NSString *)xpathForObj:(id)obj analyzationType:(AnalyzationType)type{
    return [self xpathForObj:obj analyzationType:type gesture:nil];
}

+ (NSString *)xpathForObj:(id)obj analyzationType:(AnalyzationType)type gesture:(UIGestureRecognizer *)gesture {
    NSMutableString *pstring = [NSMutableString new];
    //================= xpath 统计分析
    [[XpathFilter currentXpathFilter] filterForObj:obj analyzationType:type gesture:gesture completion:^(UIView * _Nonnull tv, BOOL permit) {
        //hooktest
        UIResponder *responder = tv;
        NSMutableString *log_pre = [NSMutableString stringWithString:@"--"];
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
        
        //=================
        if ([pstring hasPrefix:@"UIView0UIView0WKContentView0"]) {
            DLog(@"\n 不处理 \n");
        }else {
            NSLog(@"\n hooktest-栈顶对象所属类:%@,计算结果:\n %@ \n %@ \n ",NSStringFromClass(tv.class),pstring,[self md5HexDigest:pstring]);
            // 数据库写入
            AnalyzationModel *f = [AnalyzationModel new];
            f.aid   = pstring;
            f.time  = [NSDate getCurrentDate];
            f.tc    = pstring;//NSStringFromClass(tv.class);
            [[JXFMDBMOperator sharedInstance] insertDataModel:f];
        }
        
        
    }];
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
