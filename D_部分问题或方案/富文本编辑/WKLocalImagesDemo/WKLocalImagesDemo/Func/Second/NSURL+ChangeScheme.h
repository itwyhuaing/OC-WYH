//
//  NSURL+ChangeScheme.h
//  WKLocalImagesDemo
//
//  Created by hnbwyh on 2021/1/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (ChangeScheme)

- (NSURL *)changeURLSchemeWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
