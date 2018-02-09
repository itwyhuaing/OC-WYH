//
//  MessageManager.h
//  LXYHOCFunctionsDemo
//
//  Created by wyh on 15/11/27.
//  Copyright © 2015年 lachesismh. All rights reserved.
//

#define kMargin 10
#define kIconWH 40
#define kContentW 180

#define kTimeMarginW 15 //时间文本与边框间隔宽度方向
#define kTimeMarginH 10 //时间文本与边框间隔高度方向

#define kContentTop 10
#define kContentLeft 25
#define kContentBottom 15
#define kContentRight 15

#define kTimeFont [UIFont systemFontOfSize:12]
#define kContentFont [UIFont systemFontOfSize:16]

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MessageObj.h"

@interface MessageManager : NSObject

@property (nonatomic,assign,readonly) CGRect iconF;

@property (nonatomic,assign,readonly) CGRect timeF;

@property (nonatomic,assign,readonly) CGRect contentF;

@property (nonatomic,assign,readonly) CGFloat cellHeight;

@property (nonatomic,retain) MessageObj *msgObj;

//@property (nonatomic,assign) BOOL showTime;

@end
