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

+ (NSString *)htmlFactoryWithttributedString:(NSAttributedString *)attributedText;

@end

NS_ASSUME_NONNULL_END
