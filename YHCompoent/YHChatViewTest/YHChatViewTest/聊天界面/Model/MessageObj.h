//
//  MessageObj.h
//  LXYHOCFunctionsDemo
//
//  Created by wyh on 15/11/27.
//  Copyright © 2015年 lachesismh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    MsgTypeMe = 0,
    MsgTypeFrom
} MsgType;

@interface MessageObj : NSObject

@property (nonatomic,copy) NSString *msgContent;

@property (nonatomic,copy) NSString *iconName;

@property (nonatomic,copy) NSString *time;

@property (nonatomic,assign) MsgType msgType;

@property (nonatomic,assign) BOOL showTime;

@end
