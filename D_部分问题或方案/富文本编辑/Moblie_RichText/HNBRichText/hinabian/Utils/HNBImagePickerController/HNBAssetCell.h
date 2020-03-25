//
//  HNBAssetCell.h
//  HNBImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "RecentSelectView.h"

typedef enum : NSUInteger {
    HNBAssetCellTypePhoto = 0,
    HNBAssetCellTypeLivePhoto,
    HNBAssetCellTypeVideo,
    HNBAssetCellTypeAudio,
} HNBAssetCellType;

@class HNBAssetModel;
//@class RecentSelectView;
@interface HNBAssetCell : UICollectionViewCell

@property (nonatomic, assign) BOOL isIdeaBack;

@property (weak, nonatomic) UIButton *selectPhotoButton;
@property (nonatomic, strong) HNBAssetModel *model;
@property (nonatomic, copy) void (^didSelectPhotoBlock)(BOOL);
@property (nonatomic, assign) HNBAssetCellType type;
@property (nonatomic, copy) NSString *representedAssetIdentifier;
@property (nonatomic, assign) PHImageRequestID imageRequestID;

@property (nonatomic, copy) NSString *photoSelImageName;
@property (nonatomic, copy) NSString *photoDefImageName;

@property (nonatomic, assign) NSInteger maxImagesCount;

@property (weak, nonatomic) RecentSelectView *selectView;

- (void)setNumForLabel:(NSInteger)num;

@end


@class HNBAlbumModel;

@interface HNBAlbumCell : UITableViewCell

@property (nonatomic, strong) HNBAlbumModel *model;
@property (weak, nonatomic) UIButton *selectedCountButton;

@end


@interface HNBAssetCameraCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@end
