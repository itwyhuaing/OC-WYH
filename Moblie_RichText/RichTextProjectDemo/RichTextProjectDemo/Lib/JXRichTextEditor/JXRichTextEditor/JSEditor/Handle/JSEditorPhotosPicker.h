//
//  JSEditorPhotosPicker.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/12/13.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JSEditorDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PhotosPickerManager : NSObject

- (NSString *)generateTheBasicCount;

- (CGFloat)generateSideGap;

- (NSString *)pathForCacheImageWithKey:(NSString *)key;

- (BOOL)writeImage:(UIImage *)img cachePath:(NSString *)cPath;

// 上传图片加载 loading 所需图片路径
- (NSString *)generateLoadingPath;

// 上传图片失败后删除图片所需图片路径
- (NSString *)generateDeletePath;

// 上传图片失败后重新上传所需图片路径
- (NSString *)generateReloadingPath;

// 不失真方式处理图片尺寸
- (CGSize)compatibleSizeForImage:(UIImage *)img;

@end


typedef void(^PhotosPickerBlock)(NSArray<PhotoModel *> *data);
@interface JSEditorPhotosPicker : NSObject

- (instancetype)initWithPreVC:(UIViewController *)vc;

- (void)pickPhotos;

@property (nonatomic,copy) PhotosPickerBlock pickerBlock;

@end

NS_ASSUME_NONNULL_END
