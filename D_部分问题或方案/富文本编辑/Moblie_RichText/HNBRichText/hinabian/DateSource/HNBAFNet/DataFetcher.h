//
//  DataFetcher.h
//  hinabian
//
//  Created by hnbwyh on 15/6/15.
//  Copyright (c) 2015年 &#20313;&#22362;. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
@class HNBAssetModel;

typedef void(^DataFetchSucceedHandler)(id JSON);
typedef void(^DataFetchFailHandler)(id error);


@interface DataFetcher : NSObject

+ (void)doGetAllTribes:(DataFetchSucceedHandler)suceedHandler withFailHandler:(DataFetchFailHandler)failHandler;
#pragma mark - 发帖上传图片 - 新版富文本
+(void) hnbRichTextUpdatePostImage:(HNBAssetModel *)info WithSucceedHandler:(DataFetchSucceedHandler)suceedHandler withFailHandler:(DataFetchFailHandler)failHandler;
#pragma mark ------ 新版发帖接口
/** 新版发帖接口
 * tribeID              - 圈子ID
 * themID               - 帖子ID , 编辑已有帖子之后需要所需参数
 * titleString          - 标题
 * contentString        - 内容
 * topicID              - 话题ID , V3.0 首页增加热门话题列表中有参与讨论板块所需参数 ,该参数有则传无则空
 */
+ (void)hnbRichTextPostTribeID:(NSString *)tribeID themID:(NSString *)themID title:(NSString *)titleString content:(NSString *)contentString topicID:(NSString *)topicID withSucceedHandler:(DataFetchSucceedHandler)suceedHandler withFailHandler:(DataFetchFailHandler)failHandler;

@end

