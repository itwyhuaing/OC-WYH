//
//  HNBUtils.h
//  hinabian
//
//  Created by hnbwyh on 15/6/30.
//  Copyright (c) 2015年 &#20313;&#22362;. All rights reserved.
//

#ifndef hinabian_HNBUtils_h
#define hinabian_HNBUtils_h

#import <Foundation/Foundation.h>

//v3.1 网易云登录完成后回调
typedef void(^NETEaseLoginComplete)(id error);

@interface HNBUtils : NSObject

+ (NSArray *) getAllParameterForJS:(NSString *)inputParameter;
+ (BOOL) isLogin;
+ (void) gotoAppStore;
+(void) gotoAppStoreWithUrl:(NSString *)url;
+ (UIImage *) getImageFromURL:(NSString *)fileURL;
+ (NSString *) sha1:(NSString *)inputStr;
+ (NSString *) getCruntTime;
+ (NSString *) md5TwoHexDigest:(NSString*)str;
+ (NSString *) md5HexDigest:(NSString*)str;
+ (NSMutableDictionary *) addGeneralKey:(NSMutableDictionary *) inputDictionary;
+ (NSMutableDictionary *) addPlatformKey:(NSMutableDictionary *) inputDictionary;
+ (BOOL) isConnectionAvailable;
+ (void) gotoAppStorePageRaisal;
+ (void)writeToFile:(NSString *)data filename:(NSString *)name;
+ (void)removeFile:(NSString *)filename;
+ (BOOL)clearCachesDirectory;
+ (NSString *)sizeFormattedOfCache;
+ (BOOL) isNationOrINtentionEmpty;
+ (void) resetPersonalityNotice;
+ (BOOL) isBindingPhoneNumAlertShow;

/*距离上一次打开是否超过
 day:日 
 hour:时 
 minute:分
 */
+ (BOOL) isMoreThanLastedTime:(NSString *)lastedTime
                    RangeDays:(NSString *)day RangeMours:(NSString *)hour RangeMinutes:(NSString *)minute;
/* 个数统计转换 */
+ (NSString *) numConvert:(NSString *) num;
/**
 * 沙盒存数据
 */
+(BOOL)sandBoxSaveInfo:(id)info forKey:(NSString *)key;

/**
 * 沙盒取数据
 */
+(id)sandBoxGetInfo:(Class)cls forKey:(NSString *)key;
+(void) sandBoxClearAllInfo:(NSString *)key;
+(void) canclAllRequestInAFNQueue;
/**
 * 自定义数据模型 - 归档
 * 依据文件名拼接文件路径 - document文件夹下
 */
+ (void)encodeCustomDataModel:(id)model toFile:(NSString *)fileName;

/**
 * 自定义数据模型 - 解档
 * 依据文件名拼接文件路径 - document文件夹下
 */
+ (id)decodeCustomDataModelFromFilePath:(NSString *)fileName;

/**
 * 删除文件
 * 依据文件名拼接文件路径 - document文件夹下
 */
+ (BOOL)deleteFileAtTheFileName:(NSString *)fileName;

/**
 * 文本间距处理 
 */
+ (NSMutableAttributedString *)setLabelLineSpacing:(CGFloat)spacing labelText:(NSString *)labelText;
/* 打电话 */
+ (void) telThePhone:(NSString *)tel;

/* 数组插入元素 */
+ (NSArray *)operateNavigationVCS:(NSArray *)vcs index:(NSInteger)index vc:(UIViewController *)vc;

/**
 * 给一个日期，概算该日期与当前日期是否相差 7 天
 */
+ (NSString *)compareDateWithGivedDateString:(NSString *)givedDateString;

/**
 * 依据给定的key值，将对象升序排列
 */
+ (NSArray *)sortedObjects:(NSArray *)data withKey:(NSString *)key;


/**
 * 获取时间差值
 */
+ (NSString *)calculateTimeGapFromGivedDateString:(NSString *)givedDateString;


/**
 * 返回当前日期字符串
 */
+ (NSString *)returnCurrentLocalDateString;


/**
 * 返回时间戳
 */
+ (NSString *)returnTimestamp;


/**
 * 时间戳基数 : 发表帖子选择图片，需要对图片做唯一性标识
 */
+ (NSInteger)returnTimestampBaseCount;

/**
 * 返回指定范围内的随机数
 */
+ (int)returnRandomFrom:(int)from to:(int)to;

/**
 * 获取当前 cookie
 */
+ (NSString *)reqCurrentCookie;

/**
 * 返回随机数
 */
+ (int)returnRandomNum;

/**
 * 返回当前网络状态
 */
+ (NSString *)returnCurrentEquipmentNetStatus;

/**
 * 自定义 UUID 标识 - 目标尽可能保证每次新安装的唯一性
 * 生成规则如下:
 * 时间戳+四个随机数
 */
+ (NSString *)createCustomUUID:(NSDictionary *)infoDictionary;

/**
 * 错误上报
 */
+ (void)upLoadErrortype:(NSString *)type
                    API:(NSString *)errorAPI
                   Code:(NSInteger )errorCode;

/**
 * 上报评估结果
 * APP 除主动登陆外，web 操作也可以默认登陆
 */
+ (void)uploadAssessRlt;


/**
 * 正则判断是否为手机号
 */
+ (BOOL)evaluateIsPhoneNum:(NSString *)mobileNum;

/**
 * 解析用户扩展字段ext（实际为json字符串）
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 * 手动登录网易云IM
 */
//+ (void)loginNetEaseIMWithLoginAcount:(NSString *)loginAccount loginToken:(NSString *)loginToken completion:(NETEaseLoginComplete)completion;

/**
 * 设置限制一天发送条数的本地数据
 */
+ (void)setIMLocalLimited;

/**
 * 时间戳转化成时间NSData
 */
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;

@end


#endif
