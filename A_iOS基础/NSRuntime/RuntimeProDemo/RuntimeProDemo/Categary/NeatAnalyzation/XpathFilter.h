//
//  XpathFilter.h
//  hinabian
//
//  Created by hnbwyh on 2020/8/18.
//  Copyright © 2020 深圳市海那边科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XpathFilter : NSObject

+ (instancetype)currentXpathFilter;

- (void)filterForObj:(id)obj analyzationType:(AnalyzationType)type completion:(void (^)(UIView *tv,BOOL permit))completion;

- (void)filterForObj:(id)obj analyzationType:(AnalyzationType)type gesture:(nullable UIGestureRecognizer *)gesture completion:(void (^)(UIView *tv,BOOL permit))completion;

@end

NS_ASSUME_NONNULL_END
