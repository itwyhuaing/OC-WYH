//
//  HNBAssetModel.h
//  HNBImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HNBAssetModelMediaTypePhoto = 0,
    HNBAssetModelMediaTypeLivePhoto,
    HNBAssetModelMediaTypeVideo,
    HNBAssetModelMediaTypeAudio
} HNBAssetModelMediaType;

@class PHAsset;
@interface HNBAssetModel : NSObject

@property (nonatomic, strong) id asset;             ///< PHAsset or ALAsset
@property (nonatomic, assign) NSInteger tag;        //选择顺序tag
@property (nonatomic, assign) NSInteger basicTag;   //每次确定选图的唯一Tag
@property (nonatomic, strong) NSString *localURL;   //存在沙盒下的缓存
@property (nonatomic, assign) HNBAssetModelMediaType type;
@property (nonatomic, copy) NSString *timeLength;
@property (nonatomic, copy) NSString *localIdentiy;
/**当前是否被选中*/
@property (nonatomic, assign) BOOL isSelected;      ///< The select status of a photo, default is No

/**图像的url...ios8之后,是唯一标示,已经被包装为URL*/
@property (nonatomic, strong)NSURL *assetUrl;

/**image*/
@property (nonatomic, strong)id image;

/**创建日期*/
@property (nonatomic, strong)NSDate *creatDate;

/**改动日期  ios8以下系统.此属性为空*/
@property (nonatomic, strong)NSDate *modityDate;

/**地理位置*/
@property (nonatomic, strong)CLLocation *location;

/**是否存在一样的图像*/
@property (nonatomic, assign)BOOL isSame;

/**比例缩略图高宽比例 内部不要使用,赋值*/
@property (nonatomic, assign)CGFloat priexScale;

/// Init a photo dataModel With a asset
/// 用一个PHAsset/ALAsset实例，初始化一个照片模型
+ (instancetype)modelWithAsset:(id)asset type:(HNBAssetModelMediaType)type;
+ (instancetype)modelWithAsset:(id)asset type:(HNBAssetModelMediaType)type timeLength:(NSString *)timeLength;

@end


@class PHFetchResult;
@interface HNBAlbumModel : NSObject

@property (nonatomic, strong) NSString *name;        ///< The album name
@property (nonatomic, assign) NSInteger count;       ///< Count of photos the album contain
@property (nonatomic, strong) id result;             ///< PHFetchResult<PHAsset> or ALAssetsGroup<ALAsset>

@property (nonatomic, strong) NSArray *models;
@property (nonatomic, strong) NSArray *selectedModels;
@property (nonatomic, assign) NSUInteger selectedCount;
@property (nonatomic, assign) BOOL isSelected;
@end
