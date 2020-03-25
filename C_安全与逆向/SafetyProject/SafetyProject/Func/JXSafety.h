//
//  JXSafety.h
//  SafetyProject
//
//  Created by hnbwyh on 2019/5/9.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JXSafety : NSObject

+ (instancetype)defaultInstance;

- (BOOL)detectionSystem;

- (BOOL)detectionSystemSafaty3;

@end

NS_ASSUME_NONNULL_END
