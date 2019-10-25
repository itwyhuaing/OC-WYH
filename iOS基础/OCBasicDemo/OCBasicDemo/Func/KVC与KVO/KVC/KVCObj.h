//
//  KVCObj.h
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/10/24.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KVCObj : NSObject

@property (nonatomic,copy) NSString *testString;

@property (nonatomic,copy) NSArray  *testArr;

@property (nonatomic,assign) NSInteger  testInteger;

@property (nonatomic,strong) NSDate *dt;

- (void)printPrivateInfo;

@end

NS_ASSUME_NONNULL_END
