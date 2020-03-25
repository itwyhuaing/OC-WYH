//
//  HNBPhotoPickerController.m
//  HNBImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import "HNBPhotoPickerController.h"
#import "HNBImagePickerController.h"
#import "HNBPhotoPreviewController.h"
#import "HNBAssetCell.h"
#import "HNBAssetModel.h"
#import "UIView+HNBLayout.h"
#import "HNBImageManager.h"
#import "HNBVideoPlayerController.h"
#import "AlBumView.h"

@interface HNBPhotoPickerController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,AlbumViewDelegate> {
    NSMutableArray *_models;
    
    UIView *_headView;
    UIButton *_centerBtn;
    UIButton *_cancelBtn;
    UIImageView *_arrowImge;
    
    UIButton *_previewButton;
    UIButton *_okButton;
    UIButton *_originalPhotoButton;
    UILabel *_originalPhotoLable;
    UIImageView *_numberImageView;
    UILabel *_numberLable;
    
    BOOL _shouldScrollToBottom;
    BOOL _showTakePhotoBtn;
}
@property CGRect previousPreheatRect;
@property (nonatomic, assign) BOOL isSelectOriginalPhoto;
@property (nonatomic, strong) HNBCollectionView *collectionView;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
/**相册列表view*/
@property (nonatomic, strong)AlBumView *albumView;
/**专辑背景view*/
@property (nonatomic, strong)UIView *albumBackView;

@end

static CGSize AssetGridThumbnailSize;

@implementation HNBPhotoPickerController

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *hnbBarItem, *BarItem;
        if (iOS9Later) {
            hnbBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[HNBImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            hnbBarItem = [UIBarButtonItem appearanceWhenContainedIn:[HNBImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
#pragma clang diagnostic pop
        }
        NSDictionary *titleTextAttributes = [hnbBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
    _isSelectOriginalPhoto = hnbImagePickerVc.isSelectOriginalPhoto;
    _shouldScrollToBottom = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = _model.name;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSBundle hnb_localizedStringForKey:@"Cancel"] style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    _showTakePhotoBtn = (([[HNBImageManager manager] isCameraRollAlbum:_model.name]) && hnbImagePickerVc.allowTakePicture);
    if (!hnbImagePickerVc.sortAscendingByModificationDate && _isFirstAppear && iOS8Later) {
        [[HNBImageManager manager] getCameraRollAlbum:hnbImagePickerVc.allowPickingVideo allowPickingImage:hnbImagePickerVc.allowPickingImage completion:^(HNBAlbumModel *model) {
            _model = model;
            _models = [NSMutableArray arrayWithArray:_model.models];
            [self initSubviews];
        }];
    } else {
        if (_showTakePhotoBtn || !iOS8Later || _isFirstAppear) {
            [[HNBImageManager manager] getAssetsFromFetchResult:_model.result allowPickingVideo:hnbImagePickerVc.allowPickingVideo allowPickingImage:hnbImagePickerVc.allowPickingImage completion:^(NSArray<HNBAssetModel *> *models) {
                _models = [NSMutableArray arrayWithArray:models];
                [self initSubviews];
            }];
        } else {
            _models = [NSMutableArray arrayWithArray:_model.models];
            [self initSubviews];
        }
    }
    // [self resetCachedAssets];
}

- (void)initSubviews {
    [self checkSelectedModels];
    [self configCollectionView];
    [self configBottomToolBar];
    [self configTopBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
    hnbImagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    if (self.backButtonClickHandle) {
        self.backButtonClickHandle(_model);
    }
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)configCollectionView {
    HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat margin = 5;
    CGFloat itemWH = (self.view.hnb_width - (self.columnNumber + 1) * margin) / self.columnNumber;
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumInteritemSpacing = margin;
    layout.minimumLineSpacing = margin;
    CGFloat top = 44;
    if (iOS7Later) top += 20;
    CGFloat collectionViewHeight = hnbImagePickerVc.maxImagesCount > 1 ? self.view.hnb_height - 50 - top : self.view.hnb_height - top;
    _collectionView = [[HNBCollectionView alloc] initWithFrame:CGRectMake(0, top, self.view.hnb_width, collectionViewHeight) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.alwaysBounceHorizontal = NO;
    _collectionView.contentInset = UIEdgeInsetsMake(margin, margin, margin, margin);
    
    if (_showTakePhotoBtn && hnbImagePickerVc.allowTakePicture ) {
        _collectionView.contentSize = CGSizeMake(self.view.hnb_width, ((_model.count + self.columnNumber) / self.columnNumber) * self.view.hnb_width);
    } else {
        _collectionView.contentSize = CGSizeMake(self.view.hnb_width, ((_model.count + self.columnNumber - 1) / self.columnNumber) * self.view.hnb_width);
    }
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[HNBAssetCell class] forCellWithReuseIdentifier:@"HNBAssetCell"];
    [_collectionView registerClass:[HNBAssetCameraCell class] forCellWithReuseIdentifier:@"HNBAssetCameraCell"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self scrollCollectionViewToBottom];
    // Determine the size of the thumbnails to request from the PHCachingImageManager
    CGFloat scale = 2.0;
    if ([UIScreen mainScreen].bounds.size.width > 600) {
        scale = 1.0;
    }
    CGSize cellSize = ((UICollectionViewFlowLayout *)_collectionView.collectionViewLayout).itemSize;
    AssetGridThumbnailSize = CGSizeMake(cellSize.width * scale, cellSize.height * scale);
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    if (iOS8Later) {
        // [self updateCachedAssets];
    }
}

- (void)configTopBar {
    CGRect rectNav = self.navigationController.navigationBar.frame;
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, rectNav.size.height + 20)];
//    _headView.backgroundColor = [UIColor greenColor];
    _headView.layer.borderColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.3f].CGColor;
    _headView.layer.borderWidth = 1.0f;
    _centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_centerBtn setTitle:_model.name forState:UIControlStateNormal];
    [_centerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_centerBtn setFrame:CGRectMake(SCREEN_WIDTH/2 - 50, 20, 100, rectNav.size.height + 5)];
    [_centerBtn addTarget:self action:@selector(disPlayAlbumView) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *arrowImge = [[UIImageView alloc]init];
    arrowImge.contentMode = UIViewContentModeCenter;
    UIImage *image =[UIImage imageNamed:@"photo_arrow"];
    [arrowImge  setImage:image];
    [_headView addSubview:arrowImge];
    _arrowImge = arrowImge;
    _arrowImge.frame = CGRectMake(CGRectGetMaxX(_centerBtn.frame) - 8, 20, _headView.frame.size.height/2, _headView.frame.size.height - 20);
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:15.f]];
    [_cancelBtn setTitle:[NSBundle hnb_localizedStringForKey:@"Cancel"] forState:UIControlStateNormal];
    [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cancelBtn setFrame:CGRectMake(0, 20, 60, rectNav.size.height + 5)];
    [_cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    [_headView addSubview:_centerBtn];
    [_headView addSubview:_cancelBtn];
    [self.view addSubview:_headView];
    
}
#pragma mark 点击中心按钮对应的逻辑
/**
 *  点击中部相册名称,展示相册列表
 */
- (void)disPlayAlbumView{
    
    [_centerBtn setTitle:@"选择相册" forState:UIControlStateNormal];
    if (_albumView == nil) {
        _albumView = [[AlBumView alloc] initWithFrame:CGRectMake(0,-(self.view.bounds.size.height) , self.view.bounds.size.width, self.view.bounds.size.height) superViewController:self preModel:_model];
        _albumView.delegate =self;
        
        
    }else {
        [_albumView configTableView];
    }
    if (_albumBackView == nil) {
        _albumBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 20 + 44, self.view.bounds.size.width, self.view.bounds.size.height - 20 - 44)];
        _albumBackView.backgroundColor = [UIColor blackColor];
        _albumBackView.alpha = 0.0f;
    }
    
    if (_albumView.superview) {
        [self shouldRemoveFrom:nil];
        return;
    }
    
    [self.view insertSubview:_albumBackView belowSubview:_headView];
    [_albumView setFrame:CGRectMake(0,-(self.view.bounds.size.height) , self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view insertSubview:_albumView  belowSubview:_headView];
    [UIView animateWithDuration:0.1 animations:^{
        _albumBackView.alpha = 0.4f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            
            _arrowImge.transform = CGAffineTransformRotate(_arrowImge.transform,M_PI);
            
            _albumView.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
        } completion:^(BOOL finished) {
        }];
    }];
    
    
}
/**
 *  将专辑列表移除
 */
- (void)shouldRemoveFrom:(AlBumView *)view{
    
    [_centerBtn setTitle:_model.name forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 animations:^{
        _arrowImge.transform = CGAffineTransformIdentity;
        _albumView.transform = CGAffineTransformMakeTranslation(0, -self.view.bounds.size.height);
    } completion:^(BOOL finished) {
        
        [_albumView removeFromSuperview];
        [_albumView setFrame:CGRectZero];
        _albumView.transform = CGAffineTransformIdentity;
        [UIView animateWithDuration:0.1 animations:^{
            _albumBackView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            if (_albumBackView.superview) {
                [_albumBackView removeFromSuperview];
            }
        }];
    }];
    
}
/**
 *  选中专辑列表的某个cell时的回调方法
 *
 *  @param indexPath 点击对应的索引
 *  @param View      专辑列表 view
 */
- (void)clickCellForIndex:(NSIndexPath *)indexPath ForView:(AlBumView *)View Model:(HNBAlbumModel *)model{
    HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
    _isSelectOriginalPhoto = hnbImagePickerVc.isSelectOriginalPhoto;
    _shouldScrollToBottom = YES;
    _showTakePhotoBtn = YES;
    [_centerBtn setTitle:model.name forState:UIControlStateNormal];
    if (!hnbImagePickerVc.sortAscendingByModificationDate && _isFirstAppear && iOS8Later) {
        _model = model;
        [[HNBImageManager manager] getCameraRollAlbum:hnbImagePickerVc.allowPickingVideo allowPickingImage:hnbImagePickerVc.allowPickingImage completion:^(HNBAlbumModel *model) {
            _models = [NSMutableArray arrayWithArray:_model.models];
            [self checkSelectedModels];
            [_collectionView reloadData];
        }];
        
    } else {
        if (_showTakePhotoBtn || !iOS8Later || _isFirstAppear) {
            _model = model;
            [[HNBImageManager manager] getCameraRollAlbum:hnbImagePickerVc.allowPickingVideo allowPickingImage:hnbImagePickerVc.allowPickingImage completion:^(HNBAlbumModel *model) {
                _models = [NSMutableArray arrayWithArray:_model.models];
                [self checkSelectedModels];
                [_collectionView reloadData];
            }];
        } else {
            _models = [NSMutableArray arrayWithArray:_model.models];
            [self checkSelectedModels];
            [_collectionView reloadData];
        }
    }
}

- (void)configBottomToolBar {
    HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
    if (hnbImagePickerVc.maxImagesCount <= 0) return;
    //    if (hnbImagePickerVc.maxImagesCount <= 1) return;
    
    UIView *bottomToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.hnb_height - 50, self.view.hnb_width, 50)];
    CGFloat rgb = 253 / 255.0;
    bottomToolBar.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    
    NSString *previewText = [NSBundle hnb_localizedStringForKey:@"Preview"];
    CGFloat previewWidth = [previewText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.width;
    _previewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _previewButton.frame = CGRectMake(10, 3, previewWidth + 2, 44);
//    _previewButton.hnb_width = hnbImagePickerVc.maxImagesCount <= 1 ? 0 : previewWidth + 2;
    _previewButton.hnb_width = hnbImagePickerVc.maxImagesCount <= 0 ? 0 : previewWidth + 2;
    [_previewButton addTarget:self action:@selector(previewButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _previewButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_previewButton setTitle:previewText forState:UIControlStateNormal];
    [_previewButton setTitle:previewText forState:UIControlStateDisabled];
    [_previewButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_previewButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    _previewButton.enabled = hnbImagePickerVc.selectedModels.count;
    /*意见反馈进来的不显示预览*/
    _previewButton.hidden = _isIdeaBack;
    
    if (hnbImagePickerVc.allowPickingOriginalPhoto) {
        NSString *fullImageText = [NSBundle hnb_localizedStringForKey:@"Full image"];
        CGFloat fullImageWidth = [fullImageText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.width;
        _originalPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _originalPhotoButton.frame = CGRectMake(CGRectGetMaxX(_previewButton.frame), self.view.hnb_height - 50, fullImageWidth + 56, 50);
        _originalPhotoButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [_originalPhotoButton addTarget:self action:@selector(originalPhotoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _originalPhotoButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_originalPhotoButton setTitle:fullImageText forState:UIControlStateNormal];
        [_originalPhotoButton setTitle:fullImageText forState:UIControlStateSelected];
        [_originalPhotoButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_originalPhotoButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_originalPhotoButton setImage:[UIImage imageNamedFromMyBundle:hnbImagePickerVc.photoOriginDefImageName] forState:UIControlStateNormal];
        [_originalPhotoButton setImage:[UIImage imageNamedFromMyBundle:hnbImagePickerVc.photoOriginSelImageName] forState:UIControlStateSelected];
        _originalPhotoButton.selected = _isSelectOriginalPhoto;
        _originalPhotoButton.enabled = hnbImagePickerVc.selectedModels.count > 0;
        
        _originalPhotoLable = [[UILabel alloc] init];
        _originalPhotoLable.frame = CGRectMake(fullImageWidth + 46, 0, 80, 50);
        _originalPhotoLable.textAlignment = NSTextAlignmentLeft;
        _originalPhotoLable.font = [UIFont systemFontOfSize:16];
        _originalPhotoLable.textColor = [UIColor blackColor];
        if (_isSelectOriginalPhoto) [self getSelectedPhotoBytes];
    }
    if (_isIdeaBack) {
        _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _okButton.frame = CGRectMake(self.view.hnb_width - 44 - 12, 3, 44, 44);
        _okButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_okButton setTitle:[NSBundle hnb_localizedStringForKey:@"Done"] forState:UIControlStateNormal];
        [_okButton setTitle:[NSBundle hnb_localizedStringForKey:@"Done"] forState:UIControlStateDisabled];
        [_okButton setTitleColor:hnbImagePickerVc.oKButtonTitleColorNormal forState:UIControlStateNormal];
        [_okButton setTitleColor:hnbImagePickerVc.oKButtonTitleColorDisabled forState:UIControlStateDisabled];
        _okButton.enabled = hnbImagePickerVc.selectedModels.count || hnbImagePickerVc.alwaysEnableDoneBtn;
        
        _numberImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamedFromMyBundle:hnbImagePickerVc.photoNumberIconImageName]];
        _numberImageView.frame = CGRectMake(self.view.hnb_width - 56 - 28, 10, 30, 30);
        _numberImageView.hidden = hnbImagePickerVc.selectedModels.count <= 0;
        _numberImageView.backgroundColor = [UIColor clearColor];
        
        _numberLable = [[UILabel alloc] init];
        _numberLable.frame = _numberImageView.frame;
        _numberLable.font = [UIFont systemFontOfSize:15];
        _numberLable.textColor = [UIColor whiteColor];
        _numberLable.textAlignment = NSTextAlignmentCenter;
        _numberLable.text = [NSString stringWithFormat:@"%zd",hnbImagePickerVc.selectedModels.count];
        _numberLable.hidden = hnbImagePickerVc.selectedModels.count <= 0;
        _numberLable.backgroundColor = [UIColor clearColor];
        
        UIView *divide = [[UIView alloc] init];
        CGFloat rgb2 = 222 / 255.0;
        divide.backgroundColor = [UIColor colorWithRed:rgb2 green:rgb2 blue:rgb2 alpha:1.0];
        divide.frame = CGRectMake(0, 0, self.view.hnb_width, 1);
        
        [bottomToolBar addSubview:divide];
        [bottomToolBar addSubview:_previewButton];
        [bottomToolBar addSubview:_okButton];
        [bottomToolBar addSubview:_numberImageView];
        [bottomToolBar addSubview:_numberLable];
        [self.view addSubview:bottomToolBar];
        [self.view addSubview:_originalPhotoButton];
        [_originalPhotoButton addSubview:_originalPhotoLable];
    }else {
        _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _okButton.layer.cornerRadius = 6.f;
        _okButton.layer.masksToBounds = YES;
        _okButton.layer.borderWidth = 0.5f;
        _okButton.frame = CGRectMake(self.view.hnb_width - 44 - 34, (50-22)/2, 66, 26);
        _okButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
        if (hnbImagePickerVc.selectedModels.count > 0 || hnbImagePickerVc.alwaysEnableDoneBtn) {
            _okButton.enabled = YES;
            _okButton.layer.borderColor = [UIColor whiteColor].CGColor;
            [_okButton setBackgroundColor:[UIColor colorWithRed:24.f/255.f green:143.f/255.f blue:255.f/255.f alpha:1.f]];
            [_okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_okButton setTitle:[NSString stringWithFormat:[NSBundle hnb_localizedStringForKey:@"OK(%zd)"],hnbImagePickerVc.selectedModels.count] forState:UIControlStateNormal];
        }else {
            _okButton.enabled = NO;
            _okButton.layer.borderColor = [UIColor DDR102_G102_B102ColorWithalph:1.f].CGColor;
            [_okButton setBackgroundColor:[UIColor clearColor]];
            [_okButton setTitleColor:[UIColor DDR102_G102_B102ColorWithalph:1.f] forState:UIControlStateNormal];
            [_okButton setTitle:[NSBundle hnb_localizedStringForKey:@"OK"] forState:UIControlStateNormal];
        }
        
        UIView *divide = [[UIView alloc] init];
        CGFloat rgb2 = 222 / 255.0;
        divide.backgroundColor = [UIColor colorWithRed:rgb2 green:rgb2 blue:rgb2 alpha:1.0];
        divide.frame = CGRectMake(0, 0, self.view.hnb_width, 1);
        
        [bottomToolBar addSubview:divide];
        [bottomToolBar addSubview:_previewButton];
        [bottomToolBar addSubview:_okButton];
        [self.view addSubview:bottomToolBar];
        [self.view addSubview:_originalPhotoButton];
        [_originalPhotoButton addSubview:_originalPhotoLable];
    }
    
}

#pragma mark - Click Event
#pragma mark - 取消
- (void)cancel {
    HNBImagePickerController *imagePickerVc = (HNBImagePickerController *)self.navigationController;
    if (imagePickerVc.autoDismiss) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    if ([imagePickerVc.pickerDelegate respondsToSelector:@selector(hnb_imagePickerControllerDidCancel:)]) {
        [imagePickerVc.pickerDelegate hnb_imagePickerControllerDidCancel:imagePickerVc];
    }
    if ([imagePickerVc.pickerDelegate respondsToSelector:@selector(imagePickerControllerDidCancel:)]) {
        [imagePickerVc.pickerDelegate imagePickerControllerDidCancel:imagePickerVc];
    }
    if (imagePickerVc.imagePickerControllerDidCancelHandle) {
        imagePickerVc.imagePickerControllerDidCancelHandle();
    }
}
#pragma mark - 预览
- (void)previewButtonClick {
    if (!_isIdeaBack) {
        HNBImagePickerController *imagePickerVc = (HNBImagePickerController *)self.navigationController;
        imagePickerVc.showModels = imagePickerVc.selectedModels;
        imagePickerVc.showAssets = imagePickerVc.selectedAssets;
    }
    HNBPhotoPreviewController *photoPreviewVc = [[HNBPhotoPreviewController alloc] init];
    [self pushPhotoPrevireViewController:photoPreviewVc isPreview:YES];
}
#pragma mark - 原图
- (void)originalPhotoButtonClick {
    _originalPhotoButton.selected = !_originalPhotoButton.isSelected;
    _isSelectOriginalPhoto = _originalPhotoButton.isSelected;
    _originalPhotoLable.hidden = !_originalPhotoButton.isSelected;
    if (_isSelectOriginalPhoto) [self getSelectedPhotoBytes];
}
#pragma mark - 确认
- (void)okButtonClick {
    HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
    // 1.6.8 判断是否满足最小必选张数的限制
    if (hnbImagePickerVc.minImagesCount && hnbImagePickerVc.selectedModels.count < hnbImagePickerVc.minImagesCount) {
        NSString *title = [NSString stringWithFormat:[NSBundle hnb_localizedStringForKey:@"Select a minimum of %zd photos"], hnbImagePickerVc.minImagesCount];
        [hnbImagePickerVc showAlertWithTitle:title];
        return;
    }
    
    [hnbImagePickerVc showProgressHUD];
    NSMutableArray *photos = [NSMutableArray array];
    NSMutableArray *assets = [NSMutableArray array];
    NSMutableArray *infoArr = [NSMutableArray array];
    for (NSInteger i = 0; i < hnbImagePickerVc.selectedModels.count; i++) { [photos addObject:@1];[assets addObject:@1];[infoArr addObject:@1]; }
    
    [HNBImageManager manager].shouldFixOrientation = YES;
    for (NSInteger i = 0; i < hnbImagePickerVc.selectedModels.count; i++) {
        HNBAssetModel *model = hnbImagePickerVc.selectedModels[i];
        [[HNBImageManager manager] getPhotoWithAsset:model.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
            if (isDegraded) return;
            if (photo) {
                photo = [self scaleImage:photo toSize:CGSizeMake(hnbImagePickerVc.photoWidth, (int)(hnbImagePickerVc.photoWidth * photo.size.height / photo.size.width))];
                [photos replaceObjectAtIndex:i withObject:photo];
            }
            if (info)  [infoArr replaceObjectAtIndex:i withObject:info];
            [assets replaceObjectAtIndex:i withObject:model.asset];

            for (id item in photos) { if ([item isKindOfClass:[NSNumber class]]) return; }
            
            [self didGetAllPhotos:photos models:hnbImagePickerVc.selectedModels assets:assets infoArr:infoArr];
        }];
    }
    if (hnbImagePickerVc.selectedModels.count <= 0) {
        [self didGetAllPhotos:photos models:hnbImagePickerVc.selectedModels assets:assets infoArr:infoArr];
    }
}

- (void)didGetAllPhotos:(NSArray *)photos models:(NSArray *)models assets:(NSArray *)assets infoArr:(NSArray *)infoArr{
    HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
    if ([hnbImagePickerVc.pickerDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:)]) {
        [hnbImagePickerVc.pickerDelegate imagePickerController:hnbImagePickerVc didFinishPickingPhotos:photos sourceAssets:assets isSelectOriginalPhoto:_isSelectOriginalPhoto];
    }
    if ([hnbImagePickerVc.pickerDelegate respondsToSelector:@selector(imagePickerController:didFinishPickingPhotos:sourceAssets:isSelectOriginalPhoto:infos:)]) {
        [hnbImagePickerVc.pickerDelegate imagePickerController:hnbImagePickerVc didFinishPickingPhotos:photos sourceAssets:assets isSelectOriginalPhoto:_isSelectOriginalPhoto infos:infoArr];
    }
    if (hnbImagePickerVc.didFinishPickingPhotosWithModelHanled) {
        hnbImagePickerVc.didFinishPickingPhotosWithModelHanled(photos,models,assets,_isSelectOriginalPhoto);
    }
    if (hnbImagePickerVc.didFinishPickingPhotosHandle) {
        hnbImagePickerVc.didFinishPickingPhotosHandle(photos,assets,_isSelectOriginalPhoto);
    }
    if (hnbImagePickerVc.didFinishPickingPhotosWithInfosHandle) {
        hnbImagePickerVc.didFinishPickingPhotosWithInfosHandle(photos,assets,_isSelectOriginalPhoto,infoArr);
    }
    [hnbImagePickerVc hideProgressHUD];
    
    if (hnbImagePickerVc.autoDismiss) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - UICollectionViewDataSource && Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_showTakePhotoBtn) {
        HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
        if (hnbImagePickerVc.allowPickingImage && hnbImagePickerVc.allowTakePicture) {
            return _models.count + 1;
        }
    }
    return _models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // the cell lead to take a picture / 去拍照的cell
    HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
    if (((hnbImagePickerVc.sortAscendingByModificationDate && indexPath.row >= _models.count) || (!hnbImagePickerVc.sortAscendingByModificationDate && indexPath.row == 0)) && _showTakePhotoBtn) {
        HNBAssetCameraCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HNBAssetCameraCell" forIndexPath:indexPath];
        cell.imageView.image = [UIImage imageNamedFromMyBundle:hnbImagePickerVc.takePictureImageName];
        return cell;
    }
    // the cell dipaly photo or video / 展示照片或视频的cell
    HNBAssetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HNBAssetCell" forIndexPath:indexPath];
    cell.isIdeaBack = _isIdeaBack;
    if (_isIdeaBack) {
        cell.photoDefImageName = hnbImagePickerVc.photoDefImageName;
        cell.photoSelImageName = hnbImagePickerVc.photoSelImageName;
        HNBAssetModel *model;
        if (hnbImagePickerVc.sortAscendingByModificationDate || !_showTakePhotoBtn) {
            model = _models[indexPath.row];
        } else {
            model = _models[indexPath.row - 1];
        }
        cell.model = model;
        cell.maxImagesCount = hnbImagePickerVc.maxImagesCount;
        
        __weak typeof(cell) weakCell = cell;
        __weak typeof(self) weakSelf = self;
        __weak typeof(_numberImageView.layer) weakLayer = _numberImageView.layer;
        cell.didSelectPhotoBlock = ^(BOOL isSelected) {
            HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)weakSelf.navigationController;
            // 1. cancel select / 取消选择
            if (isSelected) {
                weakCell.selectPhotoButton.selected = NO;
                model.isSelected = NO;
                NSArray *selectedModels = [NSArray arrayWithArray:hnbImagePickerVc.selectedModels];
                for (HNBAssetModel *model_item in selectedModels) {
                    if ([[[HNBImageManager manager] getAssetIdentifier:model.asset] isEqualToString:[[HNBImageManager manager] getAssetIdentifier:model_item.asset]]) {
                        [hnbImagePickerVc.selectedModels removeObject:model_item];
                        break;
                    }
                }
                [weakSelf refreshBottomToolBarStatus];
            } else {
                // 2. select:check if over the maxImagesCount / 选择照片,检查是否超过了最大个数的限制
                if (hnbImagePickerVc.selectedModels.count < hnbImagePickerVc.maxImagesCount) {
                    weakCell.selectPhotoButton.selected = YES;
                    model.isSelected = YES;
                    [hnbImagePickerVc.selectedModels addObject:model];
                    [weakSelf refreshBottomToolBarStatus];
                } else {
                    NSString *title = [NSString stringWithFormat:[NSBundle hnb_localizedStringForKey:@"Select a maximum of %zd photos"], hnbImagePickerVc.maxImagesCount];
                    [hnbImagePickerVc showAlertWithTitle:title];
                }
            }
            [UIView showOscillatoryAnimationWithLayer:weakLayer type:HNBOscillatoryAnimationToSmaller];
        };
        
    }else {
        cell.photoDefImageName = hnbImagePickerVc.photoDefImageName;
        cell.photoSelImageName = hnbImagePickerVc.photoSelImageName;
        HNBAssetModel *model;
        if (hnbImagePickerVc.sortAscendingByModificationDate || !_showTakePhotoBtn) {
            model = _models[indexPath.row];
        } else {
            model = _models[indexPath.row - 1];
        }
        cell.model = model;
        cell.maxImagesCount = hnbImagePickerVc.maxImagesCount;
        
        __weak typeof(cell) weakCell = cell;
        __weak typeof(self) weakSelf = self;
        //    __weak typeof(_numberImageView.layer) weakLayer = _numberImageView.layer;
        cell.didSelectPhotoBlock = ^(BOOL isSelected) {
            HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)weakSelf.navigationController;
            // 1. cancel select / 取消选择
            if (isSelected) {
                weakCell.selectPhotoButton.selected = NO;
                model.isSelected = NO;
                NSArray *selectedModels = [NSArray arrayWithArray:hnbImagePickerVc.selectedModels];
                for (HNBAssetModel *model_item in selectedModels) {
                    if ([[[HNBImageManager manager] getAssetIdentifier:model.asset] isEqualToString:[[HNBImageManager manager] getAssetIdentifier:model_item.asset]]) {
                        [hnbImagePickerVc.selectedModels removeObject:model_item];
                        [hnbImagePickerVc.selectedAssets removeObject:model_item.asset];
                        weakCell.selectView.numLabel.text = @"";
                        model.tag = 0;
                        break;
                    }
                }
                [weakSelf refreshBottomToolBarStatus];
            } else {
                // 2. select:check if over the maxImagesCount / 选择照片,检查是否超过了最大个数的限制
                if (hnbImagePickerVc.selectedModels.count < hnbImagePickerVc.maxImagesCount) {
                    weakCell.selectPhotoButton.selected = YES;
                    model.isSelected = YES;
                    [hnbImagePickerVc.selectedModels addObject:model];
                    [hnbImagePickerVc.selectedAssets addObject:model.asset];
                    [weakSelf refreshBottomToolBarStatus];
                    model.tag = [hnbImagePickerVc.selectedModels indexOfObject:model] + 1;
                } else {
                    NSString *title = [NSString stringWithFormat:[NSBundle hnb_localizedStringForKey:@"Select a maximum of %zd photos"], hnbImagePickerVc.maxImagesCount];
                    [hnbImagePickerVc showAlertWithTitle:title];
                }
            }
            [self refreshCellNumForLabel];
            //        [UIView showOscillatoryAnimationWithLayer:weakLayer type:HNBOscillatoryAnimationToSmaller];
        };
        if ([hnbImagePickerVc.selectedModels indexOfObject:model] || [hnbImagePickerVc.selectedModels indexOfObject:model] == 0) {
            NSInteger tempNum = [hnbImagePickerVc.selectedModels indexOfObject:model] + 1;
            [cell setNumForLabel:tempNum];
        }
        [self refreshCellNumForLabel];
    }
    
    
    
    return cell;
}

- (void)refreshCellNumForLabel
{
    NSArray *cellArr = _collectionView.visibleCells;
//    NSMutableArray *selectedAssets = [NSMutableArray array];
    for (id cell in cellArr) {
        if ([cell isKindOfClass:[HNBAssetCell class]]) {
            HNBAssetCell *tempCell = cell;
            
            HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
//            for (HNBAssetModel *model in hnbImagePickerVc.selectedModels) {
//                [selectedAssets addObject:model.asset];
//            }
            for (HNBAssetModel *model in hnbImagePickerVc.selectedModels) {
                if ([[[HNBImageManager manager] getAssetIdentifier:tempCell.model.asset] isEqualToString:[[HNBImageManager manager] getAssetIdentifier:model.asset]]) {
                    NSInteger tempNum = [hnbImagePickerVc.selectedModels indexOfObject:model] + 1;
                    tempCell.model.isSelected = YES;
                    tempCell.model.tag = tempNum;
                    [cell setNumForLabel:tempNum];
                }
            }
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // take a photo / 去拍照
    HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
    if (((hnbImagePickerVc.sortAscendingByModificationDate && indexPath.row >= _models.count) || (!hnbImagePickerVc.sortAscendingByModificationDate && indexPath.row == 0)) && _showTakePhotoBtn)  {
        [self takePhoto]; return;
    }
    // preview phote or video / 预览照片或视频
    NSInteger index = indexPath.row;
    if (!hnbImagePickerVc.sortAscendingByModificationDate && _showTakePhotoBtn) {
        index = indexPath.row - 1;
    }
    HNBAssetModel *model = _models[index];
    if (model.type == HNBAssetModelMediaTypeVideo) {
        if (hnbImagePickerVc.selectedModels.count > 0) {
            HNBImagePickerController *imagePickerVc = (HNBImagePickerController *)self.navigationController;
            [imagePickerVc showAlertWithTitle:[NSBundle hnb_localizedStringForKey:@"Can not choose both video and photo"]];
        } else {
            HNBVideoPlayerController *videoPlayerVc = [[HNBVideoPlayerController alloc] init];
            videoPlayerVc.model = model;
            [self.navigationController pushViewController:videoPlayerVc animated:YES];
        }
    } else {
        HNBPhotoPreviewController *photoPreviewVc = [[HNBPhotoPreviewController alloc] init];
        photoPreviewVc.isIdeaBack = _isIdeaBack;
        photoPreviewVc.models = _models;
        photoPreviewVc.currentIndex = index;
        [self pushPhotoPrevireViewController:photoPreviewVc isPreview:NO];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (iOS8Later) {
        // [self updateCachedAssets];
    }
}

#pragma mark - Private Method

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) && iOS7Later) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        // 无权限 做一个友好的提示
        NSString *appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"];
        if (!appName) appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleName"];
        NSString *message = [NSString stringWithFormat:[NSBundle hnb_localizedStringForKey:@"Please allow %@ to access your camera in \"Settings -> Privacy -> Camera\""],appName];
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[NSBundle hnb_localizedStringForKey:@"Can not use camera"] message:message delegate:self cancelButtonTitle:[NSBundle hnb_localizedStringForKey:@"Cancel"] otherButtonTitles:[NSBundle hnb_localizedStringForKey:@"Setting"], nil];
        [alert show];
#pragma clang diagnostic pop
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}

- (void)refreshBottomToolBarStatus {
    HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
    
    _previewButton.enabled = hnbImagePickerVc.selectedModels.count > 0;
    
    if (_isIdeaBack) {
        _previewButton.enabled = hnbImagePickerVc.selectedModels.count > 0;
        _okButton.enabled = hnbImagePickerVc.selectedModels.count > 0 || hnbImagePickerVc.alwaysEnableDoneBtn;
        
        _numberImageView.hidden = hnbImagePickerVc.selectedModels.count <= 0;
        _numberLable.hidden = hnbImagePickerVc.selectedModels.count <= 0;
        _numberLable.text = [NSString stringWithFormat:@"%zd",hnbImagePickerVc.selectedModels.count];
    }else {
        if (hnbImagePickerVc.selectedModels.count > 0 || hnbImagePickerVc.alwaysEnableDoneBtn) {
            _okButton.enabled = YES;
            _okButton.layer.borderColor = [UIColor whiteColor].CGColor;
            [_okButton setBackgroundColor:[UIColor colorWithRed:24.f/255.f green:143.f/255.f blue:255.f/255.f alpha:1.f]];
            [_okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_okButton setTitle:[NSString stringWithFormat:[NSBundle hnb_localizedStringForKey:@"OK(%zd)"],hnbImagePickerVc.selectedModels.count] forState:UIControlStateNormal];
        }else {
            _okButton.enabled = NO;
            _okButton.layer.borderColor = [UIColor DDR102_G102_B102ColorWithalph:1.f].CGColor;
            [_okButton setBackgroundColor:[UIColor clearColor]];
            [_okButton setTitleColor:[UIColor DDR102_G102_B102ColorWithalph:1.f] forState:UIControlStateNormal];
            [_okButton setTitle:[NSBundle hnb_localizedStringForKey:@"OK"] forState:UIControlStateNormal];
        }
    }
    
    _originalPhotoButton.enabled = hnbImagePickerVc.selectedModels.count > 0;
    _originalPhotoButton.selected = (_isSelectOriginalPhoto && _originalPhotoButton.enabled);
    _originalPhotoLable.hidden = (!_originalPhotoButton.isSelected);
    if (_isSelectOriginalPhoto) [self getSelectedPhotoBytes];
}

- (void)pushPhotoPrevireViewController:(HNBPhotoPreviewController *)photoPreviewVc isPreview:(BOOL)isPreview {
    __weak typeof(self) weakSelf = self;
    
    HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
    if (!_isIdeaBack) {
        if (isPreview) {
            photoPreviewVc.models = [NSMutableArray arrayWithArray:hnbImagePickerVc.selectedModels];
        }else {
            photoPreviewVc.models = _models;
        }
    }
    
    photoPreviewVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    photoPreviewVc.backButtonClickBlock = ^(BOOL isSelectOriginalPhoto) {
        weakSelf.isSelectOriginalPhoto = isSelectOriginalPhoto;
        [weakSelf.collectionView reloadData];
        [weakSelf refreshBottomToolBarStatus];
    };
    photoPreviewVc.okButtonClickBlock = ^(BOOL isSelectOriginalPhoto){
        weakSelf.isSelectOriginalPhoto = isSelectOriginalPhoto;
        [weakSelf okButtonClick];
    };
    [self.navigationController pushViewController:photoPreviewVc animated:YES];
}

- (void)getSelectedPhotoBytes {
    HNBImagePickerController *imagePickerVc = (HNBImagePickerController *)self.navigationController;
    [[HNBImageManager manager] getPhotosBytesWithArray:imagePickerVc.selectedModels completion:^(NSString *totalBytes) {
        _originalPhotoLable.text = [NSString stringWithFormat:@"(%@)",totalBytes];
    }];
}

/// Scale image / 缩放图片
- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size {
    if (image.size.width < size.width) {
        return image;
    }
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)scrollCollectionViewToBottom {
    HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
    if (_shouldScrollToBottom && _models.count > 0 && hnbImagePickerVc.sortAscendingByModificationDate) {
        NSInteger item = _models.count - 1;
        if (_showTakePhotoBtn) {
            HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
            if (hnbImagePickerVc.allowPickingImage && hnbImagePickerVc.allowTakePicture) {
                item += 1;
            }
        }
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:0] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
        _shouldScrollToBottom = NO;
    }
}

- (void)checkSelectedModels {
    if (_isIdeaBack) {
        for (HNBAssetModel *model in _models) {
            model.isSelected = NO;
            NSMutableArray *selectedAssets = [NSMutableArray array];
            HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
            for (HNBAssetModel *model in hnbImagePickerVc.selectedModels) {
                [selectedAssets addObject:model.asset];
            }
            if ([[HNBImageManager manager] isAssetsArray:selectedAssets containAsset:model.asset]) {
                model.isSelected = YES;
            }
        }
    }else {
        for (HNBAssetModel *model in _models) {
            model.isSelected = NO;
            HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
            
            //**重新赋值**
            for (HNBAssetModel *model_select in hnbImagePickerVc.selectedModels) {
                if ([model.asset isEqual:model_select.asset]) {
                    model.isSelected = YES;
                    model.tag = model_select.tag;
                }
            }
        }
    }
    
}

#pragma mark - UIAlertViewDelegate

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
#pragma clang diagnostic pop
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            NSURL *privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"];
            if ([[UIApplication sharedApplication] canOpenURL:privacyUrl]) {
                [[UIApplication sharedApplication] openURL:privacyUrl];
            } else {
                NSString *message = [NSBundle hnb_localizedStringForKey:@"Can not jump to the privacy settings page, please go to the settings page by self, thank you"];
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[NSBundle hnb_localizedStringForKey:@"Sorry"] message:message delegate:nil cancelButtonTitle:[NSBundle hnb_localizedStringForKey:@"OK"] otherButtonTitles: nil];
                [alert show];
            }
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        HNBImagePickerController *imagePickerVc = (HNBImagePickerController *)self.navigationController;
        [imagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [[HNBImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
            if (!error) {
                [self reloadPhotoArray];
            }
        }];
    }
}

- (void)reloadPhotoArray {
    HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
    [[HNBImageManager manager] getCameraRollAlbum:hnbImagePickerVc.allowPickingVideo allowPickingImage:hnbImagePickerVc.allowPickingImage completion:^(HNBAlbumModel *model) {
        _model = model;
        [[HNBImageManager manager] getAssetsFromFetchResult:_model.result allowPickingVideo:hnbImagePickerVc.allowPickingVideo allowPickingImage:hnbImagePickerVc.allowPickingImage completion:^(NSArray<HNBAssetModel *> *models) {
            [hnbImagePickerVc hideProgressHUD];
            
            HNBAssetModel *assetModel;
            if (hnbImagePickerVc.sortAscendingByModificationDate) {
                assetModel = [models lastObject];
                [_models addObject:assetModel];
            } else {
                assetModel = [models firstObject];
                [_models insertObject:assetModel atIndex:0];
            }
//            if (hnbImagePickerVc.maxImagesCount <= 1) {
//                [hnbImagePickerVc.selectedModels addObject:assetModel];
//                [self okButtonClick]; return;
//            }
            if (hnbImagePickerVc.maxImagesCount <= 0) {
                [hnbImagePickerVc.selectedModels addObject:assetModel];
                [self okButtonClick]; return;
            }
            
            if (hnbImagePickerVc.selectedModels.count < hnbImagePickerVc.maxImagesCount) {
                assetModel.isSelected = YES;
                [hnbImagePickerVc.selectedModels addObject:assetModel];
                [self refreshBottomToolBarStatus];
            }
            [_collectionView reloadData];
            
            _shouldScrollToBottom = YES;
            [self scrollCollectionViewToBottom];
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Asset Caching

- (void)resetCachedAssets {
    [[HNBImageManager manager].cachingImageManager stopCachingImagesForAllAssets];
    self.previousPreheatRect = CGRectZero;
}

- (void)updateCachedAssets {
    BOOL isViewVisible = [self isViewLoaded] && [[self view] window] != nil;
    if (!isViewVisible) { return; }
    
    // The preheat window is twice the height of the visible rect.
    CGRect preheatRect = _collectionView.bounds;
    preheatRect = CGRectInset(preheatRect, 0.0f, -0.5f * CGRectGetHeight(preheatRect));
    
    /*
     Check if the collection view is showing an area that is significantly
     different to the last preheated area.
     */
    CGFloat delta = ABS(CGRectGetMidY(preheatRect) - CGRectGetMidY(self.previousPreheatRect));
    if (delta > CGRectGetHeight(_collectionView.bounds) / 3.0f) {
        
        // Compute the assets to start caching and to stop caching.
        NSMutableArray *addedIndexPaths = [NSMutableArray array];
        NSMutableArray *removedIndexPaths = [NSMutableArray array];
        
        [self computeDifferenceBetweenRect:self.previousPreheatRect andRect:preheatRect removedHandler:^(CGRect removedRect) {
            NSArray *indexPaths = [self aapl_indexPathsForElementsInRect:removedRect];
            [removedIndexPaths addObjectsFromArray:indexPaths];
        } addedHandler:^(CGRect addedRect) {
            NSArray *indexPaths = [self aapl_indexPathsForElementsInRect:addedRect];
            [addedIndexPaths addObjectsFromArray:indexPaths];
        }];
        
        NSArray *assetsToStartCaching = [self assetsAtIndexPaths:addedIndexPaths];
        NSArray *assetsToStopCaching = [self assetsAtIndexPaths:removedIndexPaths];
        
        // Update the assets the PHCachingImageManager is caching.
        [[HNBImageManager manager].cachingImageManager startCachingImagesForAssets:assetsToStartCaching
                                            targetSize:AssetGridThumbnailSize
                                           contentMode:PHImageContentModeAspectFill
                                               options:nil];
        [[HNBImageManager manager].cachingImageManager stopCachingImagesForAssets:assetsToStopCaching
                                           targetSize:AssetGridThumbnailSize
                                          contentMode:PHImageContentModeAspectFill
                                              options:nil];
        
        // Store the preheat rect to compare against in the future.
        self.previousPreheatRect = preheatRect;
    }
}

- (void)computeDifferenceBetweenRect:(CGRect)oldRect andRect:(CGRect)newRect removedHandler:(void (^)(CGRect removedRect))removedHandler addedHandler:(void (^)(CGRect addedRect))addedHandler {
    if (CGRectIntersectsRect(newRect, oldRect)) {
        CGFloat oldMaxY = CGRectGetMaxY(oldRect);
        CGFloat oldMinY = CGRectGetMinY(oldRect);
        CGFloat newMaxY = CGRectGetMaxY(newRect);
        CGFloat newMinY = CGRectGetMinY(newRect);
        
        if (newMaxY > oldMaxY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, oldMaxY, newRect.size.width, (newMaxY - oldMaxY));
            addedHandler(rectToAdd);
        }
        
        if (oldMinY > newMinY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, newMinY, newRect.size.width, (oldMinY - newMinY));
            addedHandler(rectToAdd);
        }
        
        if (newMaxY < oldMaxY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, newMaxY, newRect.size.width, (oldMaxY - newMaxY));
            removedHandler(rectToRemove);
        }
        
        if (oldMinY < newMinY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, oldMinY, newRect.size.width, (newMinY - oldMinY));
            removedHandler(rectToRemove);
        }
    } else {
        addedHandler(newRect);
        removedHandler(oldRect);
    }
}

- (NSArray *)assetsAtIndexPaths:(NSArray *)indexPaths {
    if (indexPaths.count == 0) { return nil; }
    
    NSMutableArray *assets = [NSMutableArray arrayWithCapacity:indexPaths.count];
    for (NSIndexPath *indexPath in indexPaths) {
        if (indexPath.item < _models.count) {
            HNBAssetModel *model = _models[indexPath.item];
            [assets addObject:model.asset];
        }
    }
    
    return assets;
}

- (NSArray *)aapl_indexPathsForElementsInRect:(CGRect)rect {
    NSArray *allLayoutAttributes = [_collectionView.collectionViewLayout layoutAttributesForElementsInRect:rect];
    if (allLayoutAttributes.count == 0) { return nil; }
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:allLayoutAttributes.count];
    for (UICollectionViewLayoutAttributes *layoutAttributes in allLayoutAttributes) {
        NSIndexPath *indexPath = layoutAttributes.indexPath;
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}

@end



@implementation HNBCollectionView

- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    if ( [view isKindOfClass:[UIControl class]]) {
        return YES;
    }
    return [super touchesShouldCancelInContentView:view];
}

@end
