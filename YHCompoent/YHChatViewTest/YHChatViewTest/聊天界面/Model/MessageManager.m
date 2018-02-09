//
//  MessageManager.m
//  LXYHOCFunctionsDemo
//
//  Created by wyh on 15/11/27.
//  Copyright © 2015年 lachesismh. All rights reserved.
//

#import "MessageManager.h"

@implementation MessageManager

- (void)setMsgObj:(MessageObj *)msgObj{

    _msgObj = msgObj;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
//    if (_showTime) {
    if (_msgObj.showTime) {
        CGSize size = [_msgObj.time sizeWithAttributes:@{NSFontAttributeName:kTimeFont}];
        CGFloat timeX = (screenW - size.width)/2.0;
        CGFloat timeY = kMargin;
        _timeF = CGRectMake(timeX, timeY, size.width + kTimeMarginW, size.height + kTimeMarginH);
    }
    CGFloat iconX = kMargin;
    if (_msgObj.msgType == MsgTypeMe) {
        iconX = screenW - kMargin - kIconWH;
    }
    CGFloat iconY = CGRectGetMaxY(_timeF) + kMargin;
    _iconF = CGRectMake(iconX, iconY, kIconWH, kIconWH);
    CGFloat contentX = CGRectGetMaxX(_iconF) + kMargin;
    CGFloat contentY = iconY;
    CGRect rect = [_msgObj.msgContent boundingRectWithSize:CGSizeMake(kContentW, 1000)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:[NSDictionary dictionaryWithObject:kContentFont forKey:NSFontAttributeName]
                                                   context:nil];
    
    if (_msgObj.msgType == MsgTypeMe) {
        contentX = iconX - rect.size.width - kMargin - kContentLeft - kContentRight;
    }
    _contentF = CGRectMake(contentX, contentY, rect.size.width + kContentLeft + kContentRight, rect.size.height + kContentTop + kContentBottom);
    
    _cellHeight = MAX(CGRectGetMaxY(_iconF),CGRectGetMaxY(_contentF)) + kMargin;
}

@end
