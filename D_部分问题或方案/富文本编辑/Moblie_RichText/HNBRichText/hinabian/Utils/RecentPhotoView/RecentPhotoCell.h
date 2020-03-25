//
//  RecentPhotoCell.h
//  hinabian
//
//  Created by 何松泽 on 2017/8/2.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@class HNBAssetModel;
@class RecentSelectView;

static NSString *cellNib_RecentPhotoCell = @"RecentPhotoCell";

@interface RecentPhotoCell : UICollectionViewCell

@property (weak, nonatomic) UIButton *selectPhotoButton;
@property (weak, nonatomic) UIImageView *selectImageView;
@property (weak, nonatomic) UIImageView *recentPH;
@property (weak, nonatomic) RecentSelectView *selectView;

@property (nonatomic, strong) HNBAssetModel *model;
@property (nonatomic, copy) void (^didSelectPhotoBlock)(BOOL);
@property (nonatomic, copy) NSString *representedAssetIdentifier;
@property (nonatomic, assign) PHImageRequestID imageRequestID;

- (void)setCellByModel:(HNBAssetModel *)model;
- (void)setNumForLabel:(HNBAssetModel *)model;

@end
