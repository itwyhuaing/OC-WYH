//
//  AppUntils.h
//  GainRelativeInfoDemo
//
//  Created by hnbwyh on 17/7/5.
//  Copyright © 2017年 hainbwyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUntils : NSObject

+(void)saveUUIDToKeyChain;

+(NSString *)readUUIDFromKeyChain;

+ (NSString *)getUUIDString;

@end
