//
//  HNBPhotoPickerController.h
//  HNBImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNBAlbumModel;
@interface HNBPhotoPickerController : UIViewController

@property (nonatomic, assign) BOOL isFirstAppear;
@property (nonatomic, assign) BOOL isIdeaBack;
@property (nonatomic, assign) NSInteger columnNumber;
@property (nonatomic, strong) HNBAlbumModel *model;

@property (nonatomic, copy) void (^backButtonClickHandle)(HNBAlbumModel *model);

@end


@interface HNBCollectionView : UICollectionView

@end
