//
//  HTMLFactory.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTMLFactory : NSObject


/**
 将富文本解析为 HTML

 @param attributedText 富文本
 @return 解析出的 HTML
 */
+ (NSString *)htmlFactoryWithAttributedString:(NSAttributedString *)attributedText;

@end

NS_ASSUME_NONNULL_END
