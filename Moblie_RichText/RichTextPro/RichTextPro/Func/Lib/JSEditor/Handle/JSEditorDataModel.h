//
//  JSEditorDataModel.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/12/12.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JSEditorConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToolBarItem : NSObject

//  数据内容
@property (nonatomic,copy) NSString *them;
@property (nonatomic,copy) NSString *onIconName;
@property (nonatomic,copy) NSString *offIconName;

// 交互
@property (nonatomic,assign) BOOL                           isOn;
@property (nonatomic,assign) JSEditorToolBarFuncType        funcType;

@end

@interface PhotoModel : NSObject

@property (nonatomic,strong) UIImage                       *editedImage;
@property (nonatomic,strong) UIImage                       *originalImage;
@property (nonatomic,copy)   NSString                      *originalPath;

// 已选中图片的尺寸适配
@property (nonatomic,assign)   CGSize                      compatibleSize;
// 插入图片左右边距
@property (nonatomic,assign)   CGFloat                     lrGap;
// 已选中图片在本地的唯一标记
@property (nonatomic,copy)   NSString                      *uniqueSign;
// 已选中图片在本地再次写入的地址
@property (nonatomic,copy)   NSString                      *writedPath;
// 原图片资源转NSData之后经 base64 计算的字符串
@property (nonatomic,copy)   NSString                      *orgImgBase64Str;
// 已被编辑的图片资源转NSData之后经 base64 计算的字符串
@property (nonatomic,copy)   NSString                      *editedImgBase64Str;
// 上传图片加载 loading 所需图片路径
@property (nonatomic,copy)   NSString                      *loadingPath;
// 上传图片失败后删除图片所需图片路径
@property (nonatomic,copy)   NSString                      *deletePath;
// 上传图片失败后重新上传所需图片路径
@property (nonatomic,copy)   NSString                      *reloadingPath;


@end

@interface JSEditorDataModel : NSObject

@end

NS_ASSUME_NONNULL_END
