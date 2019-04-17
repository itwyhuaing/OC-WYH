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

// <font><u><s><i><b></b></i></s></u></font>
- (NSString *)fontLabelWithTextAttributes:(NSDictionary *)attributes content:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
