//
//  HTMLParser.h
//  JXRichTextDemo
//
//  Created by hnbwyh on 2019/4/17.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHpple.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTMLParser : NSObject

+ (instancetype)currentHTMLParser;

- (NSDictionary *)composeAttributedDicWithAts:(NSDictionary *)ats;

@property (nonatomic,strong)    NSDictionary *attributes;

@end

NS_ASSUME_NONNULL_END
