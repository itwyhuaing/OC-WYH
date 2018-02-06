//
//  HNBImagePickerController.m
//  HNBImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//  version 1.7.1 - 2016.10.18

#import "HNBImagePickerController.h"
#import "HNBPhotoPickerController.h"
#import "HNBPhotoPreviewController.h"
#import "HNBAssetModel.h"
#import "HNBAssetCell.h"
#import "UIView+HNBLayout.h"
#import "HNBImageManager.h"

@interface HNBImagePickerController () {
    NSTimer *_timer;
    UILabel *_tipLable;
    UIButton *_settingBtn;
    BOOL _pushPhotoPickerVc;
    BOOL _didPushPhotoPickerVc;
    
    UIButton *_progressHUD;
    UIView *_HUDContainer;
    UIActivityIndicatorView *_HUDIndicatorView;
    UILabel *_HUDLable;
    
    UIStatusBarStyle _originStatusBarStyle;
}
/// Default is 4, Use in photos collectionView in HNBPhotoPickerController
/// 默认4列, HNBPhotoPickerController中的照片collectionView
@property (nonatomic, assign) NSInteger columnNumber;
@end

@implementation HNBImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.translucent = YES;
    [HNBImageManager manager].shouldFixOrientation = NO;

    // Default appearance, you can reset these after this method
    // 默认的外观，你可以在这个方法后重置
    self.oKButtonTitleColorNormal   = [UIColor colorWithRed:(83/255.0) green:(179/255.0) blue:(17/255.0) alpha:1.0];
    self.oKButtonTitleColorDisabled = [UIColor colorWithRed:(83/255.0) green:(179/255.0) blue:(17/255.0) alpha:0.5];
    
    self.navigationController.interactivePopGestureRecognizer.delegate=(id)self;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    if (iOS7Later) {
        self.navigationBar.barTintColor = [UIColor colorWithRed:(34/255.0) green:(34/255.0)  blue:(34/255.0) alpha:1.0];
        self.navigationBar.tintColor = [UIColor whiteColor];
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)setBarItemTextFont:(UIFont *)barItemTextFont {
    _barItemTextFont = barItemTextFont;
    [self configBarButtonItemAppearance];
}

- (void)setBarItemTextColor:(UIColor *)barItemTextColor {
    _barItemTextColor = barItemTextColor;
    [self configBarButtonItemAppearance];
}

- (void)configBarButtonItemAppearance {
    UIBarButtonItem *barItem;
    if (iOS9Later) {
        barItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[HNBImagePickerController class]]];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        barItem = [UIBarButtonItem appearanceWhenContainedIn:[HNBImagePickerController class], nil];
#pragma clang diagnostic pop
    }
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = self.barItemTextColor;
    textAttrs[NSFontAttributeName] = self.barItemTextFont;
    [barItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _originStatusBarStyle = [UIApplication sharedApplication].statusBarStyle;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    [UIApplication sharedApplication].statusBarStyle = iOS7Later ? UIStatusBarStyleLightContent : UIStatusBarStyleBlackOpaque;
#pragma clang diagnostic pop
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = _originStatusBarStyle;
    [self hideProgressHUD];
}

- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount delegate:(id<HNBImagePickerControllerDelegate>)delegate {
    return [self initWithMaxImagesCount:maxImagesCount columnNumber:4 delegate:delegate pushPhotoPickerVc:YES];
}

- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount columnNumber:(NSInteger)columnNumber delegate:(id<HNBImagePickerControllerDelegate>)delegate   isIdeaBack:(BOOL)isIdeaBack{
    _isIdeaBack = isIdeaBack;
    return [self initWithMaxImagesCount:maxImagesCount columnNumber:columnNumber delegate:delegate pushPhotoPickerVc:YES];
}

- (instancetype)initWithMaxImagesCount:(NSInteger)maxImagesCount columnNumber:(NSInteger)columnNumber delegate:(id<HNBImagePickerControllerDelegate>)delegate pushPhotoPickerVc:(BOOL)pushPhotoPickerVc {
    _pushPhotoPickerVc = pushPhotoPickerVc;
    HNBAlbumPickerController *albumPickerVc = [[HNBAlbumPickerController alloc] init];
    albumPickerVc.isIdeaBack = _isIdeaBack;
    albumPickerVc.columnNumber = columnNumber;
    self = [super initWithRootViewController:albumPickerVc];
    if (self) {
        self.maxImagesCount = maxImagesCount > 0 ? maxImagesCount : 9; // Default is 9 / 默认最大可选9张图片
        self.pickerDelegate = delegate;
        self.selectedModels = [NSMutableArray array];
        
        // Allow user picking original photo and video, you also can set No after this method
        // 默认准许用户选择原图和视频, 你也可以在这个方法后置为NO
        self.allowPickingOriginalPhoto = YES;
        self.allowPickingVideo = YES;
        self.allowPickingImage = YES;
        self.allowTakePicture = YES;
        self.timeout = 15;
        self.photoWidth = 828.0;
        self.photoPreviewMaxWidth = 600;
        self.sortAscendingByModificationDate = YES;
        self.autoDismiss = YES;
        self.barItemTextFont = [UIFont systemFontOfSize:15];
        self.barItemTextColor = [UIColor whiteColor];
        self.columnNumber = columnNumber;
        [self configDefaultImageName];
        
        if (![[HNBImageManager manager] authorizationStatusAuthorized]) {
            _tipLable = [[UILabel alloc] init];
            _tipLable.frame = CGRectMake(8, 120, self.view.hnb_width - 16, 60);
            _tipLable.textAlignment = NSTextAlignmentCenter;
            _tipLable.numberOfLines = 0;
            _tipLable.font = [UIFont systemFontOfSize:16];
            _tipLable.textColor = [UIColor blackColor];
            NSString *appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"];
            if (!appName) appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleName"];
            NSString *tipText = [NSString stringWithFormat:[NSBundle hnb_localizedStringForKey:@"Allow %@ to access your album in \"Settings -> Privacy -> Photos\""],appName];
            _tipLable.text = tipText;
            [self.view addSubview:_tipLable];
            
            _settingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [_settingBtn setTitle:[NSBundle hnb_localizedStringForKey:@"Setting"] forState:UIControlStateNormal];
            _settingBtn.frame = CGRectMake(0, 180, self.view.hnb_width, 44);
            _settingBtn.titleLabel.font = [UIFont systemFontOfSize:18];
            [_settingBtn addTarget:self action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_settingBtn];
            
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(observeAuthrizationStatusChange) userInfo:nil repeats:YES];
        } else {
            [self pushPhotoPickerVc];
        }
    }
    return self;
}

/// This init method just for previewing photos / 用这个初始化方法以预览图片
- (instancetype)initWithSelectedAssets:(NSMutableArray *)selectedAssets selectedPhotos:(NSMutableArray *)selectedPhotos index:(NSInteger)index{
    HNBPhotoPreviewController *previewVc = [[HNBPhotoPreviewController alloc] init];
    previewVc.isIdeaBack = YES;
    self = [super initWithRootViewController:previewVc];
    if (self) {
        if (_isIdeaBack) {
            self.selectedAssets = [NSMutableArray arrayWithArray:selectedAssets];
            self.allowPickingOriginalPhoto = self.allowPickingOriginalPhoto;
            self.timeout = 15;
            self.photoWidth = 828.0;
            self.photoPreviewMaxWidth = 600;
            self.barItemTextFont = [UIFont systemFontOfSize:15];
            self.barItemTextColor = [UIColor whiteColor];
            [self configDefaultImageName];
            
            previewVc.photos = [NSMutableArray arrayWithArray:selectedPhotos];
            previewVc.currentIndex = index;
            __weak typeof(self) weakSelf = self;
            [previewVc setOkButtonClickBlockWithPreviewType:^(NSArray<UIImage *> *photos, NSArray<HNBAssetModel *>*models, NSArray *assets, BOOL isSelectOriginalPhoto) {
                if (weakSelf.didFinishPickingPhotosHandle) {
                    weakSelf.didFinishPickingPhotosHandle(photos,assets,isSelectOriginalPhoto);
                }
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }];
        }else {
            _selectedAssets = [NSMutableArray arrayWithArray:selectedAssets];
            _selectedModels = [NSMutableArray array];
            
            for (id asset in selectedAssets) {
                HNBAssetModel *model = [HNBAssetModel modelWithAsset:asset type:HNBAssetModelMediaTypePhoto];
                model.isSelected = YES;
                [_selectedModels addObject:model];
            }
            _showAssets = [NSMutableArray arrayWithArray:_selectedAssets];
            _showModels = [NSMutableArray arrayWithArray:_selectedModels];
            
            self.allowPickingOriginalPhoto = self.allowPickingOriginalPhoto;
            self.timeout = 15;
            self.photoWidth = 828.0;
            self.photoPreviewMaxWidth = 600;
            self.barItemTextFont = [UIFont systemFontOfSize:15];
            self.barItemTextColor = [UIColor whiteColor];
            [self configDefaultImageName];
            
            previewVc.photos = [NSMutableArray arrayWithArray:selectedPhotos];
            previewVc.currentIndex = index;
            __weak typeof(self) weakSelf = self;
            [previewVc setOkButtonClickBlockWithPreviewType:^(NSArray<UIImage *> *photos, NSArray<HNBAssetModel *>*models, NSArray *assets, BOOL isSelectOriginalPhoto) {
                if (weakSelf.didFinishPickingPhotosHandle) {
                    weakSelf.didFinishPickingPhotosHandle(photos,assets,isSelectOriginalPhoto);
                }
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }];
            [previewVc setBackButtonClickBlockWithPreviewType:^(NSArray<HNBAssetModel *>*models, NSArray *assets) {
                if (weakSelf.didBackPickingPhotosHandle) {
                    weakSelf.didBackPickingPhotosHandle(models,assets);
                }
            }];
        }
        
    }
    return self;
}

- (instancetype)initWithSelectedModels:(NSMutableArray *)selectedModels selectedAssets:(NSMutableArray *)selectedAssets selectedPhotos:(NSMutableArray *)selectedPhotos index:(NSInteger)index{
    
    HNBPhotoPreviewController *previewVc = [[HNBPhotoPreviewController alloc] init];
    self = [super initWithRootViewController:previewVc];
    if (self) {
        _selectedAssets = [NSMutableArray arrayWithArray:selectedAssets];
        _selectedModels = [NSMutableArray arrayWithArray:selectedModels];
        
        _showAssets = [NSMutableArray arrayWithArray:_selectedAssets];
        _showModels = [NSMutableArray arrayWithArray:_selectedModels];
        
        self.allowPickingOriginalPhoto = self.allowPickingOriginalPhoto;
        self.timeout = 15;
        self.photoWidth = 828.0;
        self.photoPreviewMaxWidth = 600;
        self.barItemTextFont = [UIFont systemFontOfSize:15];
        self.barItemTextColor = [UIColor whiteColor];
        [self configDefaultImageName];
        
//        previewVc.photos = [NSMutableArray arrayWithArray:images];
        previewVc.currentIndex = index;
        __weak typeof(self) weakSelf = self;
        [previewVc setOkButtonClickBlockWithPreviewType:^(NSArray<UIImage *> *photos, NSArray<HNBAssetModel *> *models, NSArray *assets, BOOL isSelectOriginalPhoto) {
            if (weakSelf.didFinishPickingPhotosWithModelHanled) {
                weakSelf.didFinishPickingPhotosWithModelHanled(nil,models,assets,isSelectOriginalPhoto);
            }
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }];
        [previewVc setBackButtonClickBlockWithPreviewType:^(NSArray<HNBAssetModel *>*models, NSArray *assets) {
            if (weakSelf.didBackPickingPhotosHandle) {
                weakSelf.didBackPickingPhotosHandle(models,assets);
            }
        }];
    }
    return self;
}

//从最近添加的照片进入
- (instancetype)initWithModels:(NSMutableArray *)models photos:(NSMutableArray *)photos selectedModels:(NSMutableArray *)selectedModels selectedAssets:(NSMutableArray *)selectedAssets index:(NSInteger)index{
    HNBPhotoPreviewController *previewVc = [[HNBPhotoPreviewController alloc] init];
    self = [super initWithRootViewController:previewVc];
    if (self) {
        NSMutableArray *assests = [NSMutableArray array];
//        NSMutableArray *images = [NSMutableArray array];
        for (HNBAssetModel *model in models) {
            [assests addObject:model.asset];
//            [images addObject:model.image];
        }
        _selectedAssets = [NSMutableArray arrayWithArray:selectedAssets];
        _selectedModels = [NSMutableArray arrayWithArray:selectedModels];
        _showAssets = [NSMutableArray arrayWithArray:assests];
        _showModels = [NSMutableArray arrayWithArray:models];
        self.allowPickingOriginalPhoto = self.allowPickingOriginalPhoto;
        self.timeout = 15;
        self.photoWidth = 828.0;
        self.photoPreviewMaxWidth = 600;
        self.barItemTextFont = [UIFont systemFontOfSize:15];
        self.barItemTextColor = [UIColor whiteColor];
        [self configDefaultImageName];
        
//        previewVc.photos = [NSMutableArray arrayWithArray:images];
        previewVc.currentIndex = index;
        __weak typeof(self) weakSelf = self;
        [previewVc setOkButtonClickBlockWithPreviewType:^(NSArray<UIImage *> *photos, NSArray<HNBAssetModel *> *models, NSArray *assets, BOOL isSelectOriginalPhoto) {
            if (weakSelf.didFinishPickingPhotosWithModelHanled) {
                weakSelf.didFinishPickingPhotosWithModelHanled(nil,models,assets,isSelectOriginalPhoto);
            }
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }];
        [previewVc setBackButtonClickBlockWithPreviewType:^(NSArray<HNBAssetModel *>*models, NSArray *assets) {
            if (weakSelf.didBackPickingPhotosHandle) {
                weakSelf.didBackPickingPhotosHandle(models,assets);
            }
        }];
    }
    return self;
}

- (void)configDefaultImageName {
    self.takePictureImageName = @"HNBtakePicture.png";
    self.photoSelImageName = @"HNBphoto_sel_photoPickerVc.png";
    self.photoDefImageName = @"HNBphoto_def_photoPickerVc.png";
    self.photoNumberIconImageName = @"HNBphoto_number_icon.png";
    self.photoPreviewOriginDefImageName = @"HNBpreview_original_def.png";
    self.photoOriginDefImageName = @"HNBphoto_original_def.png";
    self.photoOriginSelImageName = @"HNBphoto_original_sel.png";
}

- (void)observeAuthrizationStatusChange {
    if ([[HNBImageManager manager] authorizationStatusAuthorized]) {
        [_tipLable removeFromSuperview];
        [_settingBtn removeFromSuperview];
        [_timer invalidate];
        _timer = nil;
        [self pushPhotoPickerVc];
    }
}

- (void)pushPhotoPickerVc {
    _didPushPhotoPickerVc = NO;
    // 1.6.8 判断是否需要push到照片选择页，如果_pushPhotoPickerVc为NO,则不push
    if (!_didPushPhotoPickerVc && _pushPhotoPickerVc) {
        HNBPhotoPickerController *photoPickerVc = [[HNBPhotoPickerController alloc] init];
        photoPickerVc.isIdeaBack = _isIdeaBack;
        photoPickerVc.isFirstAppear = YES;
        photoPickerVc.columnNumber = self.columnNumber;
        [[HNBImageManager manager] getCameraRollAlbum:self.allowPickingVideo allowPickingImage:self.allowPickingImage completion:^(HNBAlbumModel *model) {
            photoPickerVc.model = model;
            [self pushViewController:photoPickerVc animated:YES];
            _didPushPhotoPickerVc = YES;
        }];
        
    }
}

- (void)showAlertWithTitle:(NSString *)title {
    if (iOS8Later) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:[NSBundle hnb_localizedStringForKey:@"OK"] style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        [[[UIAlertView alloc] initWithTitle:title message:nil delegate:nil cancelButtonTitle:[NSBundle hnb_localizedStringForKey:@"OK"] otherButtonTitles:nil, nil] show];
#pragma clang diagnostic pop
    }
}

- (void)showProgressHUD {
    if (!_progressHUD) {
        _progressHUD = [UIButton buttonWithType:UIButtonTypeCustom];
        [_progressHUD setBackgroundColor:[UIColor clearColor]];

        _HUDContainer = [[UIView alloc] init];
        _HUDContainer.frame = CGRectMake((self.view.hnb_width - 120) / 2, (self.view.hnb_height - 90) / 2, 120, 90);
        _HUDContainer.layer.cornerRadius = 8;
        _HUDContainer.clipsToBounds = YES;
        _HUDContainer.backgroundColor = [UIColor darkGrayColor];
        _HUDContainer.alpha = 0.7;
        
        _HUDIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _HUDIndicatorView.frame = CGRectMake(45, 15, 30, 30);
        
        _HUDLable = [[UILabel alloc] init];
        _HUDLable.frame = CGRectMake(0,40, 120, 50);
        _HUDLable.textAlignment = NSTextAlignmentCenter;
        _HUDLable.text = @"正在处理...";
        _HUDLable.font = [UIFont systemFontOfSize:15];
        _HUDLable.textColor = [UIColor whiteColor];
        
        [_HUDContainer addSubview:_HUDLable];
        [_HUDContainer addSubview:_HUDIndicatorView];
        [_progressHUD addSubview:_HUDContainer];
    }
    [_HUDIndicatorView startAnimating];
    [[UIApplication sharedApplication].keyWindow addSubview:_progressHUD];
    
    // if over time, dismiss HUD automatic
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.timeout * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideProgressHUD];
    });
}

- (void)hideProgressHUD {
    if (_progressHUD) {
        [_HUDIndicatorView stopAnimating];
        [_progressHUD removeFromSuperview];
    }
}

- (void)setTimeout:(NSInteger)timeout {
    _timeout = timeout;
    if (timeout < 5) {
        _timeout = 5;
    } else if (_timeout > 60) {
        _timeout = 60;
    }
}

/*
 
 IdeaBack
 
 */
- (void)setSelectedAssets:(NSMutableArray *)selectedAssets {
    _selectedAssets = selectedAssets;
    _selectedModels = [NSMutableArray array];
    for (id asset in selectedAssets) {
        HNBAssetModel *model = [HNBAssetModel modelWithAsset:asset type:HNBAssetModelMediaTypePhoto];
        model.isSelected = YES;
        [_selectedModels addObject:model];
    }
}

- (void)setColumnNumber:(NSInteger)columnNumber {
    _columnNumber = columnNumber;
    if (columnNumber <= 2) {
        _columnNumber = 2;
    } else if (columnNumber >= 6) {
        _columnNumber = 6;
    }
    
    HNBAlbumPickerController *albumPickerVc = [self.childViewControllers firstObject];
    albumPickerVc.isIdeaBack = _isIdeaBack;
    albumPickerVc.columnNumber = _columnNumber;
    [HNBImageManager manager].columnNumber = _columnNumber;
}

- (void)setMinPhotoWidthSelectable:(NSInteger)minPhotoWidthSelectable {
    _minPhotoWidthSelectable = minPhotoWidthSelectable;
    [HNBImageManager manager].minPhotoWidthSelectable = minPhotoWidthSelectable;
}

- (void)setMinPhotoHeightSelectable:(NSInteger)minPhotoHeightSelectable {
    _minPhotoHeightSelectable = minPhotoHeightSelectable;
    [HNBImageManager manager].minPhotoHeightSelectable = minPhotoHeightSelectable;
}

- (void)setHideWhenCanNotSelect:(BOOL)hideWhenCanNotSelect {
    _hideWhenCanNotSelect = hideWhenCanNotSelect;
    [HNBImageManager manager].hideWhenCanNotSelect = hideWhenCanNotSelect;
}

- (void)setPhotoPreviewMaxWidth:(CGFloat)photoPreviewMaxWidth {
    _photoPreviewMaxWidth = photoPreviewMaxWidth;
    if (photoPreviewMaxWidth > 800) {
        _photoPreviewMaxWidth = 800;
    } else if (photoPreviewMaxWidth < 500) {
        _photoPreviewMaxWidth = 500;
    }
    [HNBImageManager manager].photoPreviewMaxWidth = _photoPreviewMaxWidth;
}

- (void)setAllowPickingImage:(BOOL)allowPickingImage {
    _allowPickingImage = allowPickingImage;
    NSString *allowPickingImageStr = _allowPickingImage ? @"1" : @"0";
    [[NSUserDefaults standardUserDefaults] setObject:allowPickingImageStr forKey:@"hnb_allowPickingImage"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setAllowPickingVideo:(BOOL)allowPickingVideo {
    _allowPickingVideo = allowPickingVideo;
    NSString *allowPickingVideoStr = _allowPickingVideo ? @"1" : @"0";
    [[NSUserDefaults standardUserDefaults] setObject:allowPickingVideoStr forKey:@"hnb_allowPickingVideo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setSortAscendingByModificationDate:(BOOL)sortAscendingByModificationDate {
    _sortAscendingByModificationDate = sortAscendingByModificationDate;
    [HNBImageManager manager].sortAscendingByModificationDate = sortAscendingByModificationDate;
}

- (void)settingBtnClick {
    if (iOS8Later) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    } else {
        NSURL *privacyUrl = [NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"];
        if ([[UIApplication sharedApplication] canOpenURL:privacyUrl]) {
            [[UIApplication sharedApplication] openURL:privacyUrl];
        } else {
            NSString *message = [NSBundle hnb_localizedStringForKey:@"Can not jump to the privacy settings page, please go to the settings page by self, thank you"];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:[NSBundle hnb_localizedStringForKey:@"Sorry"] message:message delegate:nil cancelButtonTitle:[NSBundle hnb_localizedStringForKey:@"OK"] otherButtonTitles: nil];
            [alert show];
        }
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (iOS7Later) viewController.automaticallyAdjustsScrollViewInsets = NO;
    if (_timer) { [_timer invalidate]; _timer = nil;}
    [super pushViewController:viewController animated:animated];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end


@interface HNBAlbumPickerController ()<UITableViewDataSource,UITableViewDelegate> {
    UITableView *_tableView;
}
@property (nonatomic, strong) NSMutableArray *albumArr;
@end

@implementation HNBAlbumPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = [NSBundle hnb_localizedStringForKey:@"Photos"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSBundle hnb_localizedStringForKey:@"Cancel"] style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    [self configTableView];
    // 1.6.10 采用微信的方式，只在相册列表页定义backBarButtonItem为返回，其余的顺系统的做法
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:[NSBundle hnb_localizedStringForKey:@"Back"] style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    HNBImagePickerController *imagePickerVc = (HNBImagePickerController *)self.navigationController;
    [imagePickerVc hideProgressHUD];
    if (_albumArr) {
        for (HNBAlbumModel *albumModel in _albumArr) {
            albumModel.selectedModels = imagePickerVc.selectedModels;
        }
        [_tableView reloadData];
    } else {
        [self configTableView];
    }
}

- (void)configTableView {
    HNBImagePickerController *imagePickerVc = (HNBImagePickerController *)self.navigationController;
    [[HNBImageManager manager] getAllAlbums:imagePickerVc.allowPickingVideo allowPickingImage:imagePickerVc.allowPickingImage completion:^(NSArray<HNBAlbumModel *> *models) {
        _albumArr = [NSMutableArray arrayWithArray:models];
        for (HNBAlbumModel *albumModel in _albumArr) {
            albumModel.selectedModels = imagePickerVc.selectedModels;
        }
        if (!_tableView) {
            CGFloat top = 44;
            if (iOS7Later) top += 20;
            _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, top, self.view.hnb_width, self.view.hnb_height - top) style:UITableViewStylePlain];
            _tableView.rowHeight = 70;
            _tableView.tableFooterView = [[UIView alloc] init];
            _tableView.dataSource = self;
            _tableView.delegate = self;
            [_tableView registerClass:[HNBAlbumCell class] forCellReuseIdentifier:@"HNBAlbumCell"];
            [self.view addSubview:_tableView];
        } else {
            [_tableView reloadData];
        }
    }];
}

#pragma mark - Click Event

- (void)cancel {
    HNBImagePickerController *imagePickerVc = (HNBImagePickerController *)self.navigationController;
    if (imagePickerVc.autoDismiss) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    if ([imagePickerVc.pickerDelegate respondsToSelector:@selector(imagePickerControllerDidCancel:)]) {
        [imagePickerVc.pickerDelegate imagePickerControllerDidCancel:imagePickerVc];
    }
    if ([imagePickerVc.pickerDelegate respondsToSelector:@selector(hnb_imagePickerControllerDidCancel:)]) {
        [imagePickerVc.pickerDelegate hnb_imagePickerControllerDidCancel:imagePickerVc];
    }
    if (imagePickerVc.imagePickerControllerDidCancelHandle) {
        imagePickerVc.imagePickerControllerDidCancelHandle();
    }
}

#pragma mark - UITableViewDataSource && Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _albumArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HNBAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HNBAlbumCell"];
    HNBImagePickerController *imagePickerVc = (HNBImagePickerController *)self.navigationController;
    cell.selectedCountButton.backgroundColor = imagePickerVc.oKButtonTitleColorNormal;
    cell.model = _albumArr[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HNBPhotoPickerController *photoPickerVc = [[HNBPhotoPickerController alloc] init];
    photoPickerVc.isIdeaBack = _isIdeaBack;
    photoPickerVc.columnNumber = self.columnNumber;
    HNBAlbumModel *model = _albumArr[indexPath.row];
    photoPickerVc.model = model;
    __weak typeof(self) weakSelf = self;
    [photoPickerVc setBackButtonClickHandle:^(HNBAlbumModel *model) {
        [weakSelf.albumArr replaceObjectAtIndex:indexPath.row withObject:model];
    }];
    [self.navigationController pushViewController:photoPickerVc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end


@implementation UIImage (MyBundle)

+ (UIImage *)imageNamedFromMyBundle:(NSString *)name {
    UIImage *image = [UIImage imageNamed:[@"HNBImagePickerController.bundle" stringByAppendingPathComponent:name]];
    if (image) {
        return image;
    } else {
        image = [UIImage imageNamed:[@"Frameworks/HNBImagePickerController.framework/HNBImagePickerController.bundle" stringByAppendingPathComponent:name]];
        if (!image) {
            image = [UIImage imageNamed:name];
        }
        return image;
    }
}

@end
