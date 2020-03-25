//
//  HNBPhotoPreviewCell.h
//  HNBImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNBAssetModel;
@interface HNBPhotoPreviewCell : UICollectionViewCell

@property (nonatomic, strong) HNBAssetModel *model;
@property (nonatomic, copy) void (^singleTapGestureBlock)();

- (void)recoverSubviews;

@end
