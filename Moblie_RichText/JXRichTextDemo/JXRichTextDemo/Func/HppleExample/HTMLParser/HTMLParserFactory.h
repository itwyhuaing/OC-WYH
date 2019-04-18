//
//  HTMLParserFactory.h
//  JXRichTextDemo
//
//  Created by hnbwyh on 2019/4/17.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHpple.h"

NS_ASSUME_NONNULL_BEGIN

@interface HTMLParserFactory : NSObject

+ (instancetype)currentHTMLParserFactory;

- (NSAttributedString *)htmlParserFactoryWithHtmlContent:(NSString *)htmlContent;

//- (NSAttributedString *)htmlContentWithPElement:(TFHppleElement *)pelement;

@end

NS_ASSUME_NONNULL_END
