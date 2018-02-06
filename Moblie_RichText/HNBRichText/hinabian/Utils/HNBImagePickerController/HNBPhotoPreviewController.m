//
//  HNBPhotoPreviewController.m
//  HNBImagePickerController
//
//  Created by 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import "HNBPhotoPreviewController.h"
#import "HNBPhotoPreviewCell.h"
#import "HNBAssetModel.h"
#import "UIView+HNBLayout.h"
#import "HNBImagePickerController.h"
#import "HNBImageManager.h"
#import "RecentSelectView.h"

@interface HNBPhotoPreviewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate> {
    UICollectionView *_collectionView;
    BOOL _isHideNaviBar;
    NSArray *_photosTemp;
    NSArray *_assetsTemp;
    NSMutableArray *_dataTemp;   //model原始数据
    
    UIView *_naviBar;
    UIButton *_backButton;
    UIButton *_selectButton;
    RecentSelectView *_selectView;
    
    UIView *_toolBar;
    UIButton *_okButton;
    UIImageView *_numberImageView;
    UILabel *_numberLable;
    UIButton *_originalPhotoButton;
    UILabel *_originalPhotoLable;
}
@end

@implementation HNBPhotoPreviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakSelf = self;
    HNBImagePickerController *_hnbImagePickerVc = (HNBImagePickerController *)weakSelf.navigationController;
    if (_isIdeaBack) {
        NSLog(@"IDEABACK");
        if (!self.models.count) {
            self.models = [NSMutableArray arrayWithArray:_hnbImagePickerVc.selectedModels];
            _assetsTemp = [NSMutableArray arrayWithArray:_hnbImagePickerVc.selectedAssets];
            self.isSelectOriginalPhoto = _hnbImagePickerVc.isSelectOriginalPhoto;
        }
    }else {
        if (!self.models.count) {
            self.models = [NSMutableArray arrayWithArray:_hnbImagePickerVc.showModels];
            _assetsTemp = [NSMutableArray arrayWithArray:_hnbImagePickerVc.showAssets];
            _dataTemp = [NSMutableArray array];
            for (HNBAssetModel *model in _hnbImagePickerVc.selectedModels) {
                NSDictionary *selectedDic =  [NSDictionary dictionaryWithObjectsAndKeys:
                                              [NSNumber numberWithBool:model.isSelected], @"isSelected",
                                              [NSNumber numberWithInteger:model.tag], @"tag",
                                              model.image,@"image",
                                              model.assetUrl,@"url",
                                              model, @"model",
                                              nil];
                [_dataTemp addObject:selectedDic];
            }
            self.isSelectOriginalPhoto = _hnbImagePickerVc.isSelectOriginalPhoto;
            
            
        }
    }
    [self configCollectionView];
    [self configCustomNaviBar];
    [self configBottomToolBar];
    self.view.clipsToBounds = YES;
    
}

- (void)setPhotos:(NSMutableArray *)photos {
    _photos = photos;
    _photosTemp = [NSArray arrayWithArray:photos];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    if (iOS7Later) [UIApplication sharedApplication].statusBarHidden = YES;
    if (_currentIndex) [_collectionView setContentOffset:CGPointMake((self.view.hnb_width + 20) * _currentIndex, 0) animated:NO];
    [self refreshNaviBarAndBottomBarState];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
    if (iOS7Later) [UIApplication sharedApplication].statusBarHidden = NO;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)configCustomNaviBar {
    HNBImagePickerController *hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;

    _naviBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.hnb_width, 64)];
    _naviBar.backgroundColor = [UIColor colorWithRed:(34/255.0) green:(34/255.0)  blue:(34/255.0) alpha:1.0];
    _naviBar.alpha = 0.7;
    
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 44, 44)];
    [_backButton setImage:[UIImage imageNamedFromMyBundle:@"navi_back.png"] forState:UIControlStateNormal];
    [_backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    if (_isIdeaBack) {
        _selectButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.hnb_width - 54, 10, 42, 42)];
        [_selectButton setImage:[UIImage imageNamedFromMyBundle:hnbImagePickerVc.photoDefImageName] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamedFromMyBundle:hnbImagePickerVc.photoSelImageName] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        _selectButton.hidden = hnbImagePickerVc.maxImagesCount == 1;
        
        [_naviBar addSubview:_selectButton];
        [_naviBar addSubview:_backButton];
        [self.view addSubview:_naviBar];
    }else {
        _selectButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.hnb_width - 54, 10, 42, 42)];
        [_selectButton addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        //    _selectButton.hidden = hnbImagePickerVc.maxImagesCount == 1;
        _selectButton.hidden = hnbImagePickerVc.maxImagesCount == 0;
        
        //    HNBAssetModel *model = _models[_currentIndex];
        //    _naviTagLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.hnb_width - 54, 10, 42, 42)];
        //    [_naviTagLabel setFont:[UIFont systemFontOfSize:12.f]];
        //    [_naviTagLabel setTextColor:[UIColor whiteColor]];
        //    if ([hnbImagePickerVc.selectedModels indexOfObject:model]) {
        //       _naviTagLabel.text = [NSString stringWithFormat:@"%ld",(long)([hnbImagePickerVc.selectedModels indexOfObject:model] + 1)];
        //    }
        
        [self.selectView cancelChoose];
        [_naviBar addSubview:_selectButton];
        [_naviBar addSubview:_backButton];
        [self.view addSubview:_naviBar];
    }
    
    
}

- (void)configBottomToolBar {
    _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.hnb_height - 44, self.view.hnb_width, 44)];
    CGFloat rgb = 34 / 255.0;
    _toolBar.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    _toolBar.alpha = 0.7;
    
    HNBImagePickerController *_hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
    if (_hnbImagePickerVc.allowPickingOriginalPhoto) {
        NSString *fullImageText = [NSBundle hnb_localizedStringForKey:@"Full image"];
        CGFloat fullImageWidth = [fullImageText boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.width;
        _originalPhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _originalPhotoButton.frame = CGRectMake(0, 0, fullImageWidth + 56, 44);
        _originalPhotoButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        _originalPhotoButton.backgroundColor = [UIColor clearColor];
        [_originalPhotoButton addTarget:self action:@selector(originalPhotoButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _originalPhotoButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_originalPhotoButton setTitle:fullImageText forState:UIControlStateNormal];
        [_originalPhotoButton setTitle:fullImageText forState:UIControlStateSelected];
        [_originalPhotoButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_originalPhotoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [_originalPhotoButton setImage:[UIImage imageNamedFromMyBundle:_hnbImagePickerVc.photoPreviewOriginDefImageName] forState:UIControlStateNormal];
        [_originalPhotoButton setImage:[UIImage imageNamedFromMyBundle:_hnbImagePickerVc.photoOriginSelImageName] forState:UIControlStateSelected];
        
        _originalPhotoLable = [[UILabel alloc] init];
        _originalPhotoLable.frame = CGRectMake(fullImageWidth + 42, 0, 80, 44);
        _originalPhotoLable.textAlignment = NSTextAlignmentLeft;
        _originalPhotoLable.font = [UIFont systemFontOfSize:13];
        _originalPhotoLable.textColor = [UIColor whiteColor];
        _originalPhotoLable.backgroundColor = [UIColor clearColor];
        if (_isSelectOriginalPhoto) [self showPhotoBytes];
    }
    
    if (_isIdeaBack) {
        _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _okButton.frame = CGRectMake(self.view.hnb_width - 44 - 12, 0, 44, 44);
        _okButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_okButton setTitle:[NSBundle hnb_localizedStringForKey:@"Done"] forState:UIControlStateNormal];
        [_okButton setTitleColor:_hnbImagePickerVc.oKButtonTitleColorNormal forState:UIControlStateNormal];
        
        _numberImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamedFromMyBundle:_hnbImagePickerVc.photoNumberIconImageName]];
        _numberImageView.backgroundColor = [UIColor clearColor];
        _numberImageView.frame = CGRectMake(self.view.hnb_width - 56 - 28, 7, 30, 30);
        _numberImageView.hidden = _hnbImagePickerVc.selectedModels.count <= 0;
        
        _numberLable = [[UILabel alloc] init];
        _numberLable.frame = _numberImageView.frame;
        _numberLable.font = [UIFont systemFontOfSize:15];
        _numberLable.textColor = [UIColor whiteColor];
        _numberLable.textAlignment = NSTextAlignmentCenter;
        _numberLable.text = [NSString stringWithFormat:@"%zd",_hnbImagePickerVc.selectedModels.count];
        _numberLable.hidden = _hnbImagePickerVc.selectedModels.count <= 0;
        _numberLable.backgroundColor = [UIColor clearColor];
        
        [_originalPhotoButton addSubview:_originalPhotoLable];
        [_toolBar addSubview:_okButton];
        [_toolBar addSubview:_originalPhotoButton];
        [_toolBar addSubview:_numberImageView];
        [_toolBar addSubview:_numberLable];
        [self.view addSubview:_toolBar];
    }else {
        _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _okButton.frame = CGRectMake(self.view.hnb_width - 44 - 34, (44-22)/2, 66, 26);
        _okButton.layer.cornerRadius = 6.f;
        _okButton.layer.masksToBounds = YES;
        _okButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
        NSString *btnTitle = [NSString stringWithFormat:[NSBundle hnb_localizedStringForKey:@"OK(%zd)"],_hnbImagePickerVc.selectedModels.count];
        if (_hnbImagePickerVc.selectedModels.count <= 0) {
            btnTitle = [NSBundle hnb_localizedStringForKey:@"OK"];
        }
        [_okButton setTitle:btnTitle forState:UIControlStateNormal];
        [_okButton setTintColor:[UIColor whiteColor]];
        [_okButton setBackgroundColor:[UIColor colorWithRed:24.f/255.f green:143.f/255.f blue:255.f/255.f alpha:1.f]];
        
        
        [_originalPhotoButton addSubview:_originalPhotoLable];
        [_toolBar addSubview:_okButton];
        [_toolBar addSubview:_originalPhotoButton];
        [self.view addSubview:_toolBar];
    }
    
}

- (void)configCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(self.view.hnb_width + 20, self.view.hnb_height);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(-10, 0, self.view.hnb_width + 20, self.view.hnb_height) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor blackColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.scrollsToTop = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.contentOffset = CGPointMake(0, 0);
    _collectionView.contentSize = CGSizeMake(self.models.count * (self.view.hnb_width + 20), 0);
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[HNBPhotoPreviewCell class] forCellWithReuseIdentifier:@"HNBPhotoPreviewCell"];
}

#pragma mark - Click Event

- (void)select:(UIButton *)selectButton {
    
    if (_isIdeaBack) {
        HNBImagePickerController *_hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
        HNBAssetModel *model = _models[_currentIndex];
        if (!selectButton.isSelected) {
            // 1. select:check if over the maxImagesCount / 选择照片,检查是否超过了最大个数的限制
            if (_hnbImagePickerVc.selectedModels.count >= _hnbImagePickerVc.maxImagesCount) {
                NSString *title = [NSString stringWithFormat:[NSBundle hnb_localizedStringForKey:@"Select a maximum of %zd photos"], _hnbImagePickerVc.maxImagesCount];
                [_hnbImagePickerVc showAlertWithTitle:title];
                return;
                // 2. if not over the maxImagesCount / 如果没有超过最大个数限制
            } else {
                [_hnbImagePickerVc.selectedModels addObject:model];
                if (self.photos) {
                    [_hnbImagePickerVc.selectedAssets addObject:_assetsTemp[_currentIndex]];
                    [self.photos addObject:_photosTemp[_currentIndex]];
                }
                if (model.type == HNBAssetModelMediaTypeVideo) {
                    [_hnbImagePickerVc showAlertWithTitle:[NSBundle hnb_localizedStringForKey:@"Select the video when in multi state, we will handle the video as a photo"]];
                }
            }
        } else {
            NSArray *selectedModels = [NSArray arrayWithArray:_hnbImagePickerVc.selectedModels];
            for (HNBAssetModel *model_item in selectedModels) {
                if ([[[HNBImageManager manager] getAssetIdentifier:model.asset] isEqualToString:[[HNBImageManager manager] getAssetIdentifier:model_item.asset]]) {
                    // 1.6.7版本更新:防止有多个一样的model,一次性被移除了
                    NSArray *selectedModelsTmp = [NSArray arrayWithArray:_hnbImagePickerVc.selectedModels];
                    for (NSInteger i = 0; i < selectedModelsTmp.count; i++) {
                        HNBAssetModel *model = selectedModelsTmp[i];
                        if ([model isEqual:model_item]) {
                            [_hnbImagePickerVc.selectedModels removeObjectAtIndex:i];
                            break;
                        }
                    }
                    // [_hnbImagePickerVc.selectedModels removeObject:model_item];
                    if (self.photos) {
                        // 1.6.7版本更新:防止有多个一样的asset,一次性被移除了
                        NSArray *selectedAssetsTmp = [NSArray arrayWithArray:_hnbImagePickerVc.selectedAssets];
                        for (NSInteger i = 0; i < selectedAssetsTmp.count; i++) {
                            id asset = selectedAssetsTmp[i];
                            if ([asset isEqual:_assetsTemp[_currentIndex]]) {
                                [_hnbImagePickerVc.selectedAssets removeObjectAtIndex:i];
                                break;
                            }
                        }
                        // [_hnbImagePickerVc.selectedAssets removeObject:_assetsTemp[_currentIndex]];
                        [self.photos removeObject:_photosTemp[_currentIndex]];
                    }
                    break;
                }
            }
        }
        model.isSelected = !selectButton.isSelected;
        [self refreshNaviBarAndBottomBarState];
        if (model.isSelected) {
            [UIView showOscillatoryAnimationWithLayer:selectButton.imageView.layer type:HNBOscillatoryAnimationToBigger];
        }
        [UIView showOscillatoryAnimationWithLayer:_numberImageView.layer type:HNBOscillatoryAnimationToSmaller];
        
        return;
    }
    
    HNBImagePickerController *_hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
    HNBAssetModel *model = _models[_currentIndex];
    if (!selectButton.isSelected) {
        // 1. select:check if over the maxImagesCount / 选择照片,检查是否超过了最大个数的限制
        if (_hnbImagePickerVc.selectedModels.count >= _hnbImagePickerVc.maxImagesCount) {
            NSString *title = [NSString stringWithFormat:[NSBundle hnb_localizedStringForKey:@"Select a maximum of %zd photos"], _hnbImagePickerVc.maxImagesCount];
            [_hnbImagePickerVc showAlertWithTitle:title];
            return;
        // 2. if not over the maxImagesCount / 如果没有超过最大个数限制
        } else {
            [_hnbImagePickerVc.selectedModels addObject:model];
            [_hnbImagePickerVc.selectedAssets addObject:model.asset];
            NSInteger tag = [_hnbImagePickerVc.selectedModels indexOfObject:model] + 1;
            if (tag > 0) {
                model.tag = tag;
            }

            if (model.type == HNBAssetModelMediaTypeVideo) {
                [_hnbImagePickerVc showAlertWithTitle:[NSBundle hnb_localizedStringForKey:@"Select the video when in multi state, we will handle the video as a photo"]];
            }
        }
    } else {
        NSArray *selectedModels = [NSArray arrayWithArray:_hnbImagePickerVc.selectedModels];
        for (HNBAssetModel *model_item in selectedModels) {
            if ([[[HNBImageManager manager] getAssetIdentifier:model.asset] isEqualToString:[[HNBImageManager manager] getAssetIdentifier:model_item.asset]]) {
                // 1.6.7版本更新:防止有多个一样的model,一次性被移除了
                NSArray *selectedModelsTmp = [NSArray arrayWithArray:_hnbImagePickerVc.selectedModels];
                for (NSInteger i = 0; i < selectedModelsTmp.count; i++) {
                    HNBAssetModel *model = selectedModelsTmp[i];
                    if ([model isEqual:model_item]) {
                        model.tag = 0;
                        [_hnbImagePickerVc.selectedModels removeObjectAtIndex:i];
                        [_hnbImagePickerVc.selectedAssets removeObjectAtIndex:i];
                        break;
                    }
                }
                break;
            }
        }
    }
    model.isSelected = !selectButton.isSelected;
    [self refreshNaviBarAndBottomBarState];
    if (model.isSelected) {
        [UIView showOscillatoryAnimationWithLayer:selectButton.imageView.layer type:HNBOscillatoryAnimationToBigger];
        [UIView showOscillatoryAnimationWithLayer:_selectView.numLabel.layer type:HNBOscillatoryAnimationToBigger];
    }
//    [UIView showOscillatoryAnimationWithLayer:_numberImageView.layer type:HNBOscillatoryAnimationToSmaller];
}

- (void)back {
    if (!_isIdeaBack) {
        /*不是意见反馈*/
        HNBImagePickerController *_hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
        if (self.backButtonClickBlockWithPreviewType) {
            _hnbImagePickerVc.selectedModels = [NSMutableArray array];
            _hnbImagePickerVc.selectedAssets = [NSMutableArray array];
            //由于使用了同一块地址的model，必须重新为此前选择的赋值
            for (HNBAssetModel *model in self.models) {
                model.isSelected = NO;
                model.tag = 0;
            }
            for (int i = 0; i < _dataTemp.count; i++) {
                HNBAssetModel *model = [_dataTemp[i] valueForKey:@"model"];
                if (model) {
                    model.isSelected = [[_dataTemp[i] valueForKey:@"isSelected"] boolValue];
                    model.assetUrl = [_dataTemp[i] valueForKey:@"url"];
                    model.tag = [[_dataTemp[i] valueForKey:@"tag"] integerValue];
                    model.image = [_dataTemp[i] valueForKey:@"image"];
                    [_hnbImagePickerVc.selectedModels addObject:model];
                    [_hnbImagePickerVc.selectedAssets addObject:model.asset];
                }
            }
            self.backButtonClickBlockWithPreviewType(_hnbImagePickerVc.selectedModels,_hnbImagePickerVc.selectedAssets);
        }
    }
    
    if (self.navigationController.childViewControllers.count < 2) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
    if (self.backButtonClickBlock) {
        self.backButtonClickBlock(_isSelectOriginalPhoto);
    }
}

- (void)okButtonClick {
    HNBImagePickerController *_hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
    
    if (_isIdeaBack) {
        // 如果没有选中过照片 点击确定时选中当前预览的照片
        if (_hnbImagePickerVc.selectedModels.count == 0 && _hnbImagePickerVc.minImagesCount <= 0) {
            HNBAssetModel *model = _models[_currentIndex];
            [_hnbImagePickerVc.selectedModels addObject:model];
        }
    }
    if (self.okButtonClickBlock) {
        self.okButtonClickBlock(_isSelectOriginalPhoto);
    }
    if (self.okButtonClickBlockWithPreviewType) {
        self.okButtonClickBlockWithPreviewType(nil,_hnbImagePickerVc.selectedModels,_hnbImagePickerVc.selectedAssets,self.isSelectOriginalPhoto);
    }
}

- (void)originalPhotoButtonClick {
    _originalPhotoButton.selected = !_originalPhotoButton.isSelected;
    _isSelectOriginalPhoto = _originalPhotoButton.isSelected;
    _originalPhotoLable.hidden = !_originalPhotoButton.isSelected;
    if (_isSelectOriginalPhoto) {
        [self showPhotoBytes];
        if (!_selectButton.isSelected) {
            // 如果当前已选择照片张数 < 最大可选张数 && 最大可选张数大于1，就选中该张图
            HNBImagePickerController *_hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
//            if (_hnbImagePickerVc.selectedModels.count < _hnbImagePickerVc.maxImagesCount && _hnbImagePickerVc.maxImagesCount > 1) {
            if (_hnbImagePickerVc.selectedModels.count < _hnbImagePickerVc.maxImagesCount && _hnbImagePickerVc.maxImagesCount > 0) {
                [self select:_selectButton];
            }
        }
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offSetWidth = scrollView.contentOffset.x;
    offSetWidth = offSetWidth +  ((self.view.hnb_width + 20) * 0.5);
    
    NSInteger currentIndex = offSetWidth / (self.view.hnb_width + 20);
    
    if (_currentIndex != currentIndex) {
        _currentIndex = currentIndex;
        [self refreshNaviBarAndBottomBarState];
    }
}

#pragma mark - UICollectionViewDataSource && Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HNBPhotoPreviewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HNBPhotoPreviewCell" forIndexPath:indexPath];
    cell.model = _models[indexPath.row];
    
    if (!cell.singleTapGestureBlock) {
        __block BOOL _weakIsHideNaviBar = _isHideNaviBar;
        __weak typeof(_naviBar) weakNaviBar = _naviBar;
        __weak typeof(_toolBar) weakToolBar = _toolBar;
        cell.singleTapGestureBlock = ^(){
            // show or hide naviBar / 显示或隐藏导航栏
            _weakIsHideNaviBar = !_weakIsHideNaviBar;
            weakNaviBar.hidden = _weakIsHideNaviBar;
            weakToolBar.hidden = _weakIsHideNaviBar;
        };
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[HNBPhotoPreviewCell class]]) {
        [(HNBPhotoPreviewCell *)cell recoverSubviews];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[HNBPhotoPreviewCell class]]) {
        [(HNBPhotoPreviewCell *)cell recoverSubviews];
    }
}

#pragma mark - Private Method

- (void)dealloc {
    // NSLog(@"dealloc");
}

- (void)refreshNaviBarAndBottomBarState {
    
    if (_isIdeaBack) {
        HNBImagePickerController *_hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
        HNBAssetModel *model = _models[_currentIndex];
        _selectButton.selected = model.isSelected;
        _numberLable.text = [NSString stringWithFormat:@"%zd",_hnbImagePickerVc.selectedModels.count];
        _numberImageView.hidden = (_hnbImagePickerVc.selectedModels.count <= 0 || _isHideNaviBar);
        _numberLable.hidden = (_hnbImagePickerVc.selectedModels.count <= 0 || _isHideNaviBar);
        
        _originalPhotoButton.selected = _isSelectOriginalPhoto;
        _originalPhotoLable.hidden = !_originalPhotoButton.isSelected;
        if (_isSelectOriginalPhoto) [self showPhotoBytes];
        
        // If is previewing video, hide original photo button
        // 如果正在预览的是视频，隐藏原图按钮
        if (!_isHideNaviBar) {
            if (model.type == HNBAssetModelMediaTypeVideo) {
                _originalPhotoButton.hidden = YES;
                _originalPhotoLable.hidden = YES;
            } else {
                _originalPhotoButton.hidden = NO;
                if (_isSelectOriginalPhoto)  _originalPhotoLable.hidden = NO;
            }
        }
        
        // 让宽度/高度小于 最小可选照片尺寸 的图片不能选中
        _okButton.hidden = NO;
        _selectButton.hidden = _hnbImagePickerVc.maxImagesCount == 1;
        if (![[HNBImageManager manager] isPhotoSelectableWithAsset:model.asset]) {
            _numberLable.hidden = YES;
            _numberImageView.hidden = YES;
            _selectButton.hidden = YES;
            _originalPhotoButton.hidden = YES;
            _originalPhotoLable.hidden = YES;
            _okButton.hidden = YES;
        }
    }else {
        /*
         
         新版相册
         
         */
        HNBImagePickerController *_hnbImagePickerVc = (HNBImagePickerController *)self.navigationController;
        HNBAssetModel *model = _models[_currentIndex];
        _selectButton.selected = model.isSelected;
        
        NSString *btnTitle = [NSString stringWithFormat:[NSBundle hnb_localizedStringForKey:@"OK(%zd)"],_hnbImagePickerVc.selectedModels.count];
        if (_hnbImagePickerVc.selectedModels.count <= 0) {
            btnTitle = [NSBundle hnb_localizedStringForKey:@"OK"];
            _okButton.enabled = NO;
            [_okButton setTitleColor:[UIColor DDR102_G102_B102ColorWithalph:1.f] forState:UIControlStateNormal];
            _okButton.backgroundColor = [UIColor whiteColor];
            _okButton.layer.borderColor = [UIColor DDR102_G102_B102ColorWithalph:0.5f].CGColor;
        }else {
            _okButton.enabled = YES;
            [_okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _okButton.backgroundColor = [UIColor colorWithRed:24.f/255.f green:143.f/255.f blue:255.f/255.f alpha:1.f];
        }
        [_okButton setTitle:btnTitle forState:UIControlStateNormal];
        
        /*对model的tag重新判断赋值*/
        if (!model.isSelected) {
            //没被选择的直接赋值为0
            model.tag = 0;
            
            [self.selectView cancelChoose];
        }else {
            //有选择的通过asset判断数组中的顺序
            for (HNBAssetModel *sortModel in _models) {
                if ([sortModel.asset isEqual:model.asset]) {
                    model.tag = ([_hnbImagePickerVc.selectedAssets indexOfObject:sortModel.asset] + 1);
                    break;
                }
            }
            self.selectView.numLabel.hidden = NO;
            self.selectView.backgroundColor = [UIColor colorWithRed:24.f/255.f green:143.f/255.f blue:255.f/255.f alpha:1.f];
            self.selectView.numLabel.text = [NSString stringWithFormat:@"%ld",(long)model.tag];
        }
        
        _numberLable.text = [NSString stringWithFormat:@"%zd",_hnbImagePickerVc.selectedModels.count];
        _originalPhotoButton.selected = _isSelectOriginalPhoto;
        _originalPhotoLable.hidden = !_originalPhotoButton.isSelected;
        if (_isSelectOriginalPhoto) [self showPhotoBytes];
        
        // If is previewing video, hide original photo button
        // 如果正在预览的是视频，隐藏原图按钮
        if (!_isHideNaviBar) {
            if (model.type == HNBAssetModelMediaTypeVideo) {
                _originalPhotoButton.hidden = YES;
                _originalPhotoLable.hidden = YES;
            } else {
                _originalPhotoButton.hidden = NO;
                if (_isSelectOriginalPhoto)  _originalPhotoLable.hidden = NO;
            }
        }
        
        // 让宽度/高度小于 最小可选照片尺寸 的图片不能选中
        _okButton.hidden = NO;
        //    _selectButton.hidden = _hnbImagePickerVc.maxImagesCount == 1;
        _selectButton.hidden = _hnbImagePickerVc.maxImagesCount == 0;
        if (![[HNBImageManager manager] isPhotoSelectableWithAsset:model.asset]) {
            _numberLable.hidden = YES;
            _numberImageView.hidden = YES;
            _selectButton.hidden = YES;
            _originalPhotoButton.hidden = YES;
            _originalPhotoLable.hidden = YES;
            _okButton.hidden = YES;
        }
    }
    
}

- (void)showPhotoBytes {
    [[HNBImageManager manager] getPhotosBytesWithArray:@[_models[_currentIndex]] completion:^(NSString *totalBytes) {
        _originalPhotoLable.text = [NSString stringWithFormat:@"(%@)",totalBytes];
    }];
}

- (RecentSelectView *)selectView {
    if (_selectView == nil) {
        float dis = 20.f;
        RecentSelectView *tempView = [[RecentSelectView alloc] initWithFrame:CGRectMake(_naviBar.bounds.size.width - 27 - dis, dis, 27, 27)];
        tempView.numLabel.hidden = YES;
        [tempView setBackgroundColor:[UIColor clearColor]];
        [_naviBar addSubview:tempView];
        _selectView = tempView;
    }
    return _selectView;
}

@end
