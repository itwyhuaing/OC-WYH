//
//  PLabel.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/12.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "HTMLLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PLabel : HTMLLabel

// <p></p>
- (NSString *)pLabelWithTextAttributes:(NSDictionary *)attributes;

@end

NS_ASSUME_NONNULL_END
