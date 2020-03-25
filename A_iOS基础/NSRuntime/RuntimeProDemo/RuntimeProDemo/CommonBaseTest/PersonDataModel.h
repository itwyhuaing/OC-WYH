//
//  PersonDataModel.h
//  RuntimeProDemo
//
//  Created by hnbwyh on 2018/1/30.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonDataModel : NSObject

@property (nonatomic,copy)   NSString     *name;
@property (nonatomic,assign) NSInteger    age;
@property (nonatomic,assign) BOOL         isMan;
@property (nonatomic,strong) NSArray      *children;
@property (nonatomic,strong) NSDictionary *homeLocation;

+ (void)testClsMethod11;
+ (NSString *)testClsMethod12;

- (void)testInstanceMethod21;
- (NSString *)testInstanceMethod22;

@end
