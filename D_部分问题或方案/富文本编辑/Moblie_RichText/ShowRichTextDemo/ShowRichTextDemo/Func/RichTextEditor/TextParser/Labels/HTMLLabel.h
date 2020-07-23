//
//  HTMLLabel.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/12.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTMLLabel : NSObject

+ (instancetype)currentLabel;

// <p></p>
+ (NSString *)htmlLabelFor_P_LabelWithTextAttributes:(NSDictionary *)attributes;

// <font>(<b><i><s><u></u></s></i></b>)</font>
+ (NSString *)htmlLabelFor_Font_LabelWithTextAttributes:(NSDictionary *)attributes content:(NSString *)text;

// <img />
+ (NSString *)htmlLabelFor_Img_LabelWithTextAttributes:(NSDictionary *)attributes;

@end

NS_ASSUME_NONNULL_END
