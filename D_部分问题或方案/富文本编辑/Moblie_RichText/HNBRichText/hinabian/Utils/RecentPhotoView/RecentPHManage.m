//
//  RecentPHManage.m
//  hinabian
//
//  Created by 何松泽 on 2017/8/7.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import "RecentPHManage.h"
#import "HNBAssetModel.h"

#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)

@implementation RecentPHManage

static RecentPHManage *manager;

+(instancetype)defaultPHManager{
    if (!manager) {
        manager = [[RecentPHManage alloc] init];
        manager.allPHCount = 0.f;
    }
    return manager;
}

-(NSMutableArray *)getModelAssetWithCount:(NSInteger)count{
    
    NSMutableArray *modelArr = [NSMutableArray array];
    
    PHFetchOptions *nearestPhotosOptions = [[PHFetchOptions alloc] init];
    nearestPhotosOptions.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    if (iOS9Later) {
        //这个属性只在ios9后才有，限制一口气取相册数据的数量
        nearestPhotosOptions.fetchLimit = count;
    }
    
    PHFetchResult *result = [PHAsset fetchAssetsWithOptions:nearestPhotosOptions];
    _allPHCount = result.count;
    for (PHAsset *asset in result) {
        
        HNBAssetModelMediaType type = HNBAssetModelMediaTypePhoto;
        if (asset.mediaType == PHAssetMediaTypeImage) {
            //            if (asset.mediaSubtypes == PHAssetMediaSubtypePhotoLive) type = IPAssetModelMediaTypeLivePhoto;
        }
        
        HNBAssetModel *imgModel = [HNBAssetModel modelWithAsset:asset type:type];
        imgModel.localIdentiy = asset.localIdentifier;
        imgModel.assetUrl = [NSURL URLWithString:asset.localIdentifier];
        imgModel.priexScale = asset.pixelWidth/asset.pixelHeight;
        imgModel.creatDate = asset.creationDate;
        imgModel.modityDate = asset.modificationDate;
        
        [modelArr addObject:imgModel];
        
        PHImageRequestOptions * options = [[PHImageRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
        options.synchronous = YES;
        [[PHImageManager defaultManager] requestImageDataForAsset: asset options: options resultHandler: ^(NSData * imageData, NSString * dataUTI, UIImageOrientation orientation, NSDictionary * info) {
            imgModel.image = [UIImage imageWithData:imageData];
        }];
        
//        PHImageRequestOptions *option = [[PHImageRequestOptions alloc]init];
//        option.networkAccessAllowed = YES;
//        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//            [self.assetArr addObject:result];
//        }];
        
//        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(pixelWidth, pixelHeight) contentMode:PHImageContentModeAspectFill options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//            
//        }];
    }
    return modelArr;
}

- (NSMutableArray *)getAssetWirhModelArr:(NSMutableArray *)modelArr{
    NSMutableArray *assetArr = [NSMutableArray array];
    
    for (id model in modelArr) {
        if ([model isKindOfClass:[HNBAssetModel class]]) {
            HNBAssetModel *tempModel = model;
            [assetArr addObject:tempModel.asset];
        }
    }
    return assetArr;
}

/**
 *  获取图片
 */
- (NSMutableArray *)getPhotoWithModelArr:(NSMutableArray *)modelArr{
    
    NSMutableArray *photoArr = [NSMutableArray array];
    
    for (id model in modelArr) {
        if ([model isKindOfClass:[HNBAssetModel class]]) {
            HNBAssetModel *tempModel = model;
            PHAsset *asset = tempModel.asset;
            
            PHImageRequestOptions * options = [[PHImageRequestOptions alloc] init];
            options.version = PHImageRequestOptionsVersionCurrent;
            options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
            options.synchronous = YES;
            [[PHImageManager defaultManager] requestImageDataForAsset: asset options: options resultHandler: ^(NSData * imageData, NSString * dataUTI, UIImageOrientation orientation, NSDictionary * info) {
                
                if(imageData != nil){
                    [photoArr addObject:[UIImage imageWithData:imageData]];
                }else{
                    return;
                }
                
            }];
            //大屏手机内存会过高直接爆掉，上线前改成这个会引起巨大Crash（手动滑稽）
//            PHImageRequestOptions *option = [[PHImageRequestOptions alloc]init];
//            option.networkAccessAllowed = YES;
//            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//                [photoArr addObject:result];
//            }];
        }
    }
    
    return photoArr;
}

/**
 *  高清预览图
 */
- (void)ios8_AsyncLoadAspectThumbilImageWithSize:(CGSize)imageSize asset:(HNBAssetModel *)imagModel completion:(void (^)(UIImage *photo,NSDictionary *info))completion{
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc]init];
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    PHAsset *phAsset = (PHAsset *)imagModel.asset;
    // 在 PHImageManager 中，targetSize 等 size 都是使用 px 作为单位，因此需要对targetSize 中对传入的 Size 进行处理，宽高各自乘以 ScreenScale，从而得到正确的图片
    CGFloat aspectRatio = phAsset.pixelWidth / (CGFloat)phAsset.pixelHeight;
    CGFloat multiple = [UIScreen mainScreen].scale;
    CGFloat pixelWidth = imageSize.width * multiple;
    CGFloat pixelHeight = pixelWidth / aspectRatio;
    [[PHImageManager defaultManager] requestImageForAsset:phAsset targetSize:CGSizeMake(pixelWidth, pixelHeight) contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        //        IPLog(@"高清缩略图--%@",info);
        // 排除取消，错误，得到低清图三种情况，即已经获取到了低清图
        BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey] && [[info objectForKey:PHImageResultIsDegradedKey] boolValue]);
        if (downloadFinined) {
            completion(result,nil);
            
        }else {
            completion(nil,nil);
        }
    }];
}

- (NSString *)getAssetIdentifier:(id)asset {
    PHAsset *phAsset = (PHAsset *)asset;
    return phAsset.localIdentifier;
}

/// Return YES if Authorized 返回YES如果得到了授权
- (BOOL)authorizationStatusAuthorized {
    return [self authorizationStatus] == 3;
}

- (NSInteger)authorizationStatus {
    return [PHPhotoLibrary authorizationStatus];
}

- (PHImageRequestID)getPhotoWithAsset:(id)asset photoWidth:(CGFloat)photoWidth completion:(void (^)(UIImage *, NSDictionary *, BOOL isDegraded))completion {
    CGSize imageSize;
    PHAsset *phAsset = (PHAsset *)asset;
    CGFloat aspectRatio = phAsset.pixelWidth / (CGFloat)phAsset.pixelHeight;
    CGFloat pixelWidth = photoWidth * 1.5f;
    CGFloat pixelHeight = pixelWidth / aspectRatio;
    imageSize = CGSizeMake(pixelWidth, pixelHeight);
    // 修复获取图片时出现的瞬间内存过高问题
    // 下面两行代码，来自hsjcom，他的github是：https://github.com/hsjcom 表示感谢
    PHImageRequestOptions *option = [[PHImageRequestOptions alloc] init];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    PHImageRequestID imageRequestID = [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:imageSize contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        BOOL downloadFinined = (![[info objectForKey:PHImageCancelledKey] boolValue] && ![info objectForKey:PHImageErrorKey]);
        if (downloadFinined && result) {
            //                result = [self fixOrientation:result];
            if (completion) completion(result,info,[[info objectForKey:PHImageResultIsDegradedKey] boolValue]);
        }
        // Download image from iCloud / 从iCloud下载图片
        if ([info objectForKey:PHImageResultIsInCloudKey] && !result) {
            PHImageRequestOptions *option = [[PHImageRequestOptions alloc]init];
            option.networkAccessAllowed = YES;
            option.resizeMode = PHImageRequestOptionsResizeModeFast;
            [[PHImageManager defaultManager] requestImageDataForAsset:asset options:option resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                UIImage *resultImage = [UIImage imageWithData:imageData scale:0.1];
                resultImage = [self scaleImage:resultImage toSize:imageSize];
                if (resultImage) {
                    //                        resultImage = [self fixOrientation:resultImage];
                    if (completion) completion(resultImage,info,[[info objectForKey:PHImageResultIsDegradedKey] boolValue]);
                }
            }];
        }
    }];
    return imageRequestID;
}

- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size {
    if (image.size.width > size.width) {
        UIGraphicsBeginImageContext(size);
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    } else {
        return image;
    }
}

@end
