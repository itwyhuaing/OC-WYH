//
//  FontLabel.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/12.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "HTMLLabel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FontLabel : HTMLLabel

// <font><b><i></i></b></font>
- (NSString *)fontLabelWithTextAttributes:(NSDictionary *)attributes content:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
