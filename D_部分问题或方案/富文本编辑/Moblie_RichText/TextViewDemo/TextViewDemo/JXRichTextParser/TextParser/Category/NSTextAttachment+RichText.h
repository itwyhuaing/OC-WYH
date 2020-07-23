//
//  NSTextAttachment+RichText.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/12.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *kImageAttachmentLoadedURL = @"kImageAttachmentLoadedURL";


@interface NSTextAttachment (RichText)

@property (nonatomic,strong) NSDictionary *extendedInfo;

@end

NS_ASSUME_NONNULL_END
