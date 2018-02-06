//
//  HNBAssetModel.m
//  HNBImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import "HNBAssetModel.h"
#import "HNBImageManager.h"

@implementation HNBAssetModel

+ (instancetype)modelWithAsset:(id)asset type:(HNBAssetModelMediaType)type{
    HNBAssetModel *model = [[HNBAssetModel alloc] init];
    model.asset = asset;
    model.isSelected = NO;
    model.type = type;
//    [[HNBImageManager manager] getPhotoWithAsset:asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
//        model.image = photo;
//    }];
//    [[HNBImageManager manager] getFastShowPhotoWithAsset:asset completion:^(UIImage *photo) {
//        model.image = photo;
//    }];
    
    return model;
}

+ (instancetype)modelWithAsset:(id)asset type:(HNBAssetModelMediaType)type timeLength:(NSString *)timeLength {
    HNBAssetModel *model = [self modelWithAsset:asset type:type];
    model.timeLength = timeLength;
    return model;
}

@end



@implementation HNBAlbumModel

- (void)setResult:(id)result {
    _result = result;
    BOOL allowPickingImage = [[[NSUserDefaults standardUserDefaults] objectForKey:@"hnb_allowPickingImage"] isEqualToString:@"1"];
    BOOL allowPickingVideo = [[[NSUserDefaults standardUserDefaults] objectForKey:@"hnb_allowPickingVideo"] isEqualToString:@"1"];
    [[HNBImageManager manager] getAssetsFromFetchResult:result allowPickingVideo:allowPickingVideo allowPickingImage:allowPickingImage completion:^(NSArray<HNBAssetModel *> *models) {
        _models = models;
        if (_selectedModels) {
            [self checkSelectedModels];
        }
    }];
}

- (void)setSelectedModels:(NSArray *)selectedModels {
    _selectedModels = selectedModels;
    if (_models) {
        [self checkSelectedModels];
    }
}

- (void)checkSelectedModels {
    self.selectedCount = 0;
    NSMutableArray *selectedAssets = [NSMutableArray array];
    for (HNBAssetModel *model in _selectedModels) {
        [selectedAssets addObject:model.asset];
    }
    for (HNBAssetModel *model in _models) {
        if ([[HNBImageManager manager] isAssetsArray:selectedAssets containAsset:model.asset]) {
            self.selectedCount ++;
        }
    }
}

@end
