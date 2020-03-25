//
//  PersonInfoModel.h
//  hinabian
//
//  Created by hnbwyh on 16/7/26.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonInfoModel : NSObject

@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *leftText;
@property (nonatomic,copy) NSString *rightText;
@property (nonatomic,copy) NSString *isFollow;
@property (nonatomic,copy) NSString *head_url;
@property (nonatomic,copy) NSString *bg_url;
@property (nonatomic,copy) NSString *introduce;
@property (nonatomic,copy) NSString *personID; // 个人id
@property (nonatomic,copy) NSString *tribenum;
@property (nonatomic,copy) NSString *qanum;
@property (nonatomic,copy) NSString *errrormsg; // 记录错误信息，否则为 nil
@property (nonatomic,copy) NSString *certified;
@property (nonatomic,copy) NSString *certified_type;
@property (nonatomic,copy) NSString *level;
@property (nonatomic,copy) NSArray  *moderator;
@property (nonatomic,copy) NSString *introduceForTribe; //（2.8.4）自我介绍，帖子中lz信息
@property (nonatomic,copy) NSString *is_Need_Follow;    // (3.1.0) 是否需要关注才能进行私信（专家号除外）1 需要关注才能聊天; 0 不需要关注就能聊天
/*
 * 网易云IM的用户ID以及token
 */
@property (nonatomic,copy) NSString *netEase_ID;
@property (nonatomic,copy) NSString *netEase_token;

@end
