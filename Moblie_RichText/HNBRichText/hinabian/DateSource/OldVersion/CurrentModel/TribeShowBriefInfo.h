//
//  TribeShowBriefInfo.h
//  hinabian
//
//  Created by hnbwyh on 16/6/13.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TribeShowBriefInfo : NSObject

@property (nonatomic,copy) NSString *tribe_id;//4566
@property (nonatomic,copy) NSString *tribe_name;//dfasgda
@property (nonatomic,copy) NSString *desc;//dsffafdasfadsfadsfasdfasdfasdfasfafaf
@property (nonatomic,copy) NSString *follow_num;//9999
@property (nonatomic,copy) NSString *img_url; 
@property (nonatomic,copy) NSString *theme_num;//9999
@property (nonatomic,copy) NSString *is_followed;//1

@property (nonatomic,copy) NSArray *tribeHosts; // 版主信息 数组{name: id:}
@property (nonatomic,copy) NSArray *tribeHostNames; // 版主名字数组 string
@property (nonatomic,copy) NSString *tribeHostString; // 版主
@property (nonatomic,assign) CGFloat tribeHostTextHeight; // 版主文本 计算后的高度

@end
