//
//  RecentPhotoView.m
//  hinabian
//
//  Created by 何松泽 on 2017/8/2.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import "RecentPhotoView.h"
#import "RecentPhotoCell.h"
#import "HNBImageManager.h"
#import "HNBImagePickerController.h"
#import "HNBPhotoPreviewController.h"
#import "RecentPHManage.h"
#import "HNBAssetModel.h"
#import <Photos/Photos.h>
#import "RecentSelectView.h"
#import "HNBFileManager.h"

static const int rPhotoShowCount = 30;
static const int rSingleChose    = 9;

@interface RecentPhotoView()<UICollectionViewDelegate,UICollectionViewDataSource,HNBImagePickerControllerDelegate>
{
    CGFloat _margin;
    CGFloat _itemWH;
    
    NSTimer     *_timer;
    UILabel     *_tipLable;
    UIButton    *_settingBtn;
    //=======ToolBar
    UIView      *_toolBar;
    UIButton    *_goAlbertBtn;
    UIButton    *_okBtn;
    //=======用于区分选择的图片
    NSInteger   _RtagBasic;
    NSInteger   _RlimitedCount;
}

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSMutableArray *photos;
@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, strong) NSMutableArray *models;
@property (nonatomic, strong) NSMutableArray *selected_model;/*已选择的图片*/
@property (nonatomic, strong) NSMutableArray *selected_asset;
@property (nonatomic, strong) NSMutableArray *selected_image;
@property (nonatomic, strong) UIViewController *superViewController;
@property (nonatomic, strong) HNBImagePickerController *imagePickerVc;

@end

@implementation RecentPhotoView

-(instancetype)initWithFrame:(CGRect)frame
         superViewController:(UIViewController *)superViewController
{
    self = [super initWithFrame:frame];
    if (self) {
        _superViewController = superViewController;
        
        self.backgroundColor = [UIColor whiteColor];
        
        _RtagBasic = [HNBUtils returnTimestampBaseCount]; // 100
        
        _photos = [[NSMutableArray alloc] init];
        _assets = [[NSMutableArray alloc] init];
        _models = [[NSMutableArray alloc] init];
        
        _selected_model = [[NSMutableArray alloc] init];
        _selected_asset = [[NSMutableArray alloc] init];
        _selected_image = [[NSMutableArray alloc] init];
        
        _itemWH = 215.f;
        _RlimitedCount = rSingleChose;
        
        
        if (![[RecentPHManage defaultPHManager] authorizationStatusAuthorized]) {
            _models = [[RecentPHManage defaultPHManager] getModelAssetWithCount:rPhotoShowCount];  /*实际取不到的*/
            
            _tipLable = [[UILabel alloc] init];
            _tipLable.frame = CGRectMake(8, 120, self.bounds.size.width - 16, 60);
            _tipLable.textAlignment = NSTextAlignmentCenter;
            _tipLable.numberOfLines = 0;
            _tipLable.font = [UIFont systemFontOfSize:16];
            _tipLable.textColor = [UIColor blackColor];
            NSString *appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleDisplayName"];
            if (!appName) appName = [[NSBundle mainBundle].infoDictionary valueForKey:@"CFBundleName"];
            NSString *tipText = [NSString stringWithFormat:[NSBundle hnb_localizedStringForKey:@"Allow %@ to access your album in \"Settings -> Privacy -> Photos\""],appName];
            _tipLable.text = tipText;
            [self addSubview:_tipLable];
            
            _settingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [_settingBtn setTitle:[NSBundle hnb_localizedStringForKey:@"Setting"] forState:UIControlStateNormal];
            _settingBtn.frame = CGRectMake(0, 180, self.bounds.size.width, 44);
            _settingBtn.titleLabel.font = [UIFont systemFontOfSize:18];
            [_settingBtn addTarget:self action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_settingBtn];
            
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(observeAuthrizationStatusChange) userInfo:nil repeats:YES];
        } else {
            [self configCollectionView];
        }
    }
    return self;
}

- (void)observeAuthrizationStatusChange {
    if ([[RecentPHManage defaultPHManager] authorizationStatusAuthorized]) {
        [_tipLable removeFromSuperview];
        [_settingBtn removeFromSuperview];
        [_timer invalidate];
        _timer = nil;
        [self configCollectionView];
    }
}

- (void)settingBtnClick {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

- (void)configCollectionView{
    _models = [[RecentPHManage defaultPHManager] getModelAssetWithCount:rPhotoShowCount];
    
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGRect rect = CGRectZero;
    rect.size.width = self.frame.size.width;
    rect.size.height = _itemWH;
    
    self.superViewController.automaticallyAdjustsScrollViewInsets = NO;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:_layout];
    _collectionView.alwaysBounceVertical = NO;
    _collectionView.alwaysBounceHorizontal = YES;
    
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[RecentPhotoCell class] forCellWithReuseIdentifier:cellNib_RecentPhotoCell];
    [self addSubview:_collectionView];
    
    [self configToolBar];
}

- (void)configToolBar {
    CGRect rect = self.frame;
    rect.origin.y = _itemWH;
    rect.size.height = 50.f;
    _toolBar = [[UIView alloc] initWithFrame:rect];
    [_toolBar setBackgroundColor:[UIColor whiteColor]];
    _toolBar.layer.borderColor = [UIColor DDR102_G102_B102ColorWithalph:0.5f].CGColor;
    _toolBar.layer.borderWidth = 0.5f;
    
    _goAlbertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _goAlbertBtn.frame = CGRectMake(22, 0, 44, rect.size.height);
    _goAlbertBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_goAlbertBtn addTarget:self action:@selector(pushImagePickerController) forControlEvents:UIControlEventTouchUpInside];
    [_goAlbertBtn setTitle:@"相册" forState:UIControlStateNormal];
    [_goAlbertBtn setTitleColor:[UIColor DDR102_G102_B102ColorWithalph:1.f] forState:UIControlStateNormal];
    
    _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _okBtn.enabled = _selected_model.count;
    _okBtn.layer.cornerRadius = 6.f;
    _okBtn.layer.masksToBounds = YES;
    _okBtn.layer.borderColor = [UIColor DDR102_G102_B102ColorWithalph:0.5f].CGColor;
    _okBtn.layer.borderWidth = 0.5f;
    _okBtn.frame = CGRectMake(self.bounds.size.width - 44 - 34, (50-26)/2, 66, 26);
    _okBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_okBtn addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [_okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_okBtn setTitleColor:[UIColor DDR102_G102_B102ColorWithalph:1.f] forState:UIControlStateNormal];
    
    [_toolBar addSubview:_goAlbertBtn];
    [_toolBar addSubview:_okBtn];
    [self addSubview:_toolBar];
}

#pragma mark -- Click Event

- (void)pushImagePickerController {
    HNBImagePickerController *imagePickerVc = [[HNBImagePickerController alloc] initWithMaxImagesCount:_RlimitedCount delegate:self];
    imagePickerVc.delegate = (id)self;
#pragma mark -- 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = NO;
    // 如果需要将拍照按钮放在外面，不要传这个参数
    imagePickerVc.selectedAssets = _selected_asset; // optional, 可选的
    imagePickerVc.selectedModels = _selected_model;
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮
    // 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    // 照片排列按修改时间***YES:升序***NO:降序***
    imagePickerVc.sortAscendingByModificationDate = NO;
#pragma mark -- 到这里为止
    
    // 通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosWithModelHanled:^(NSArray<UIImage *> *photos, NSArray<HNBAssetModel *> *models, NSArray *assets, BOOL isSelectOriginalPhoto) {
        _selected_model = [NSMutableArray arrayWithArray:models];
        _selected_asset = [NSMutableArray arrayWithArray:assets];
        for (HNBAssetModel *model in _selected_model) {
            [[HNBImageManager manager] getFastShowPhotoWithAsset:model.asset completion:^(UIImage *photo) {
                model.image = photo;
//                NSLog(@"%@",model.image);
            }];
        }
//        _selected_image = [[RecentPHManage defaultPHManager] getPhotoWithModelArr:_selected_model];
//        _selected_image = [NSMutableArray arrayWithArray:photos];
        [_collectionView reloadData];
        if (self.didFinishPickingPhoto) {
            [self setModelLocalURLAndBasicTag];
            //self.didFinishPickingPhoto(_selected_model);
        }
        [self showRecentPhoto];
    }];
    // 用户如果取消了选择的图片，把用户在预览选择的都取消掉
    [imagePickerVc setImagePickerControllerDidCancelHandle:^{
        [self showRecentPhoto];
    }];
    
    [self.superViewController presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)setModelLocalURLAndBasicTag {
    /*每次选图完成后赋值唯一ID*/
//    for (int i = 0; i < _selected_model.count; i++) {
//        HNBAssetModel *model = _selected_model[i];
//        UIImage *img = _selected_image[i];
//        model.basicTag = _RtagBasic + i;
//        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
//        NSString *imgPath = [path stringByAppendingString:[NSString stringWithFormat:@"/%lu.png",model.basicTag]];
//        BOOL isWrite = [UIImagePNGRepresentation(img) writeToFile:imgPath atomically:YES];
//        if (isWrite) {
//            NSLog(@"成功了--->图片缓存是:%@",imgPath);
//        }
//        model.localURL = imgPath;
//        if (i == _selected_model.count - 1) {
//            //遍历完成后,_RtagBasic迭代
//            _RtagBasic += 100;
//        }
////        NSLog(@"_RtagBasic：%lu",model.basicTag);
//    }
    NSMutableArray *tmpArr = [[NSMutableArray alloc] init];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    for (int i = 0; i < _selected_model.count; i++) {
        HNBAssetModel *model = _selected_model[i];
        UIImage *img = (UIImage *)model.image;
        model.basicTag = _RtagBasic + i;
        //NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        NSString *imgPath = [HNBFileManager richTextImagesCachePathWithKey:[NSString stringWithFormat:@"/%lu.png",model.basicTag]];
        model.localURL = imgPath;
        if (i == _selected_model.count - 1) {
            _RtagBasic += 100;
        }
        [tmpArr addObject:model];
        dispatch_group_async(group, queue, ^{
            //BOOL isWrite = [UIImagePNGRepresentation(img) writeToFile:imgPath atomically:YES];
            BOOL isWrite = [HNBFileManager writeRichTextImageData:UIImageJPEGRepresentation(img, 0.5) path:imgPath];
            if (isWrite) {
                NSLog(@"成功了--->图片缓存是:%@",imgPath);
            }else{
                NSLog(@"失败--->图片缓存是:%@",imgPath);
            }
        });
        
    }
    
    dispatch_group_notify(group, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"主线程更新UI完成。 \n \n tmpArr %@",tmpArr);
            if(tmpArr.count > 0){
                self.didFinishPickingPhoto(tmpArr);
            }

        });
    });
    
}

- (void)imagePickerController:(HNBImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets Models:(NSArray<HNBAssetModel *> *)models {
    _selected_model = [NSMutableArray arrayWithArray:models];
    _selected_asset = [NSMutableArray arrayWithArray:assets];
    _selected_image = [NSMutableArray arrayWithArray:photos];
    
    [_collectionView reloadData];
}

- (void)done {
//    NSLog(@"Done");
//    _selected_image = [[RecentPHManage defaultPHManager] getPhotoWithModelArr:_selected_model];
    for (HNBAssetModel *model in _selected_model) {
        [[HNBImageManager manager] getFastShowPhotoWithAsset:model.asset completion:^(UIImage *photo) {
            model.image = photo;
        }];
    }
    if (self.didFinishPickingPhoto) {
        [self setModelLocalURLAndBasicTag];
        //self.didFinishPickingPhoto(_selected_model);
    }
    [self hideRecentPhoto];
}

- (void)setLimitedChose:(NSUInteger)limitedCount {
    _RlimitedCount = limitedCount < rSingleChose ? limitedCount : rSingleChose;
}

- (void)hideRecentPhoto {
    _selected_image = [NSMutableArray array];
    _selected_asset = [NSMutableArray array];
    _selected_model = [NSMutableArray array];
    for (HNBAssetModel *model in _models) {
        model.isSelected = NO;
        model.tag = 0;
    }
    [self.collectionView reloadData];
    self.hidden = YES;
}

- (void)showRecentPhoto {
    _selected_image = [NSMutableArray array];
    _selected_asset = [NSMutableArray array];
    _selected_model = [NSMutableArray array];
    for (HNBAssetModel *model in _models) {
        model.isSelected = NO;
        model.tag = 0;
    }
    [self.collectionView reloadData];
    
    self.hidden = NO;
}

#pragma mark -- Collection Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSUInteger phCount = [RecentPHManage defaultPHManager].allPHCount >= rPhotoShowCount ? rPhotoShowCount : [RecentPHManage defaultPHManager].allPHCount;

    return phCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RecentPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellNib_RecentPhotoCell forIndexPath:indexPath];
    
    HNBAssetModel *model = _models[indexPath.row];
    [cell setCellByModel:model];
    
    __weak typeof(cell) weakCell = cell;
    __weak typeof(self) weakSelf = self;
    cell.didSelectPhotoBlock = ^(BOOL isSelected){
        RecentPhotoView *recentPHView = (RecentPhotoView *)weakSelf;
        
        if (isSelected) {
            weakCell.selectPhotoButton.selected = NO;
            model.isSelected = NO;
            
            NSArray *selectedModels = [NSArray arrayWithArray:weakSelf.selected_model];
            for (HNBAssetModel *model_item in selectedModels) {
                if ([[[RecentPHManage defaultPHManager] getAssetIdentifier:model.asset] isEqualToString:[[RecentPHManage defaultPHManager] getAssetIdentifier:model_item.asset]]) {
                    [recentPHView.selected_model removeObject:model_item];
                    [recentPHView.selected_asset removeObject:model_item.asset];
//                    [recentPHView.selected_image removeObject:model_item.image];
                    weakCell.selectView.numLabel.text = @"";
                    model.tag = 0;
                    break;
                }

            }
        }else{
            if (recentPHView.selected_model.count < _RlimitedCount) {
                [recentPHView.selected_model addObject:model];
                [recentPHView.selected_asset addObject:model.asset];
//                [recentPHView.selected_image addObject:model.image];
                
                weakCell.selectPhotoButton.selected = YES;
                model.isSelected = YES;
                model.tag = [recentPHView.selected_model indexOfObject:model] + 1;
            }else {
                NSString *msg;
                if (_RlimitedCount < rSingleChose) {
                    msg = [NSString stringWithFormat:@"最多只能选择%ld张",(long)rPhotoShowCount];
                }else {
                    msg = [NSString stringWithFormat:@"一次最多只能添加%ld张",(long)rSingleChose];
                }
                [[HNBToast shareManager] toastWithOnView:nil msg:msg afterDelay:0.8f style:HNBToastHudFailure];
            }
            
        }
        //点击选中后更新
        [self refreshCellNumForLabel];
    };
    //滑动的时候更新
    if ([_selected_model indexOfObject:model] || [_selected_model indexOfObject:model]+ 1 > 0) {
        NSInteger tempNum = [_selected_model indexOfObject:model] + 1;
        model.tag = tempNum;
        [cell setNumForLabel:model];
    }
    [self refreshCellNumForLabel];
    
    
    return cell;
}

- (void)refreshCellNumForLabel {
    /*判断有无选中图片*/
    if (_selected_model.count > 0) {
        _okBtn.enabled = YES;
        _okBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_okBtn setBackgroundColor:[UIColor colorWithRed:24.f/255.f green:143.f/255.f blue:255.f/255.f alpha:1.f]];
        [_okBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else {
        _okBtn.enabled = NO;
        _okBtn.layer.borderColor = [UIColor DDR102_G102_B102ColorWithalph:1.f].CGColor;
        [_okBtn setBackgroundColor:[UIColor clearColor]];
        [_okBtn setTitleColor:[UIColor DDR102_G102_B102ColorWithalph:1.f] forState:UIControlStateNormal];
    }
    NSArray *cellArr = _collectionView.visibleCells;
    for (RecentPhotoCell *cell in cellArr) {
        if (([_selected_model indexOfObject:cell.model] || [_selected_model indexOfObject:cell.model] + 1 > 0) && cell.model.isSelected) {
            NSInteger tempNum = [_selected_model indexOfObject:cell.model] + 1;
            cell.model.tag = tempNum;
            [cell setNumForLabel:cell.model];
        }else {
            [cell.selectView cancelChoose];
        }
    }
}

- (void)refreshCellForCancel {
    NSArray *cellArr = _collectionView.visibleCells;
    for (RecentPhotoCell *cell in cellArr) {
        cell.model.isSelected = NO;
        cell.model.tag = 0;
        [cell.selectView cancelChoose];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _photos = [[RecentPHManage defaultPHManager] getPhotoWithModelArr:_models];
    _assets = [[RecentPHManage defaultPHManager] getAssetWirhModelArr:_models];
    
    HNBAssetModel *model = _models[indexPath.row];
    if (_selected_model.count > 0) {
        for (int i = 0; i < _selected_model.count; i++) {
            HNBAssetModel *model_item = _selected_model[i];
            if ([[[RecentPHManage defaultPHManager] getAssetIdentifier:model.asset] isEqualToString:[[RecentPHManage defaultPHManager] getAssetIdentifier:model_item.asset]]) {
                [self setPush_ImagePickerControllerWith_Selected:i];
                return;
            }
        }
    }
    
    [self setPush_ImagePickerControllerWith_UnSelected:indexPath.row];
    return;
}

- (void)setPush_ImagePickerControllerWith_Selected:(NSInteger)index {
    HNBImagePickerController *imagePickerVc = [[HNBImagePickerController alloc] initWithSelectedModels:_selected_model selectedAssets:_selected_asset selectedPhotos:_selected_image index:index];
    imagePickerVc.delegate = (id)self;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.isSelectOriginalPhoto = YES;
    imagePickerVc.maxImagesCount = _RlimitedCount;

    [imagePickerVc setDidFinishPickingPhotosWithModelHanled:^(NSArray<UIImage *> *photos, NSArray<HNBAssetModel *> *models, NSArray *assets, BOOL isSelectOriginalPhoto) {
        _selected_model = [NSMutableArray arrayWithArray:models];
        _selected_asset = [NSMutableArray arrayWithArray:assets];
//        _selected_image = [NSMutableArray arrayWithArray:photos];
        [_collectionView reloadData];
        
    }];
    [imagePickerVc setDidBackPickingPhotosHandle:^(NSArray<HNBAssetModel *> *models, NSArray *assets) {
        _selected_model = [NSMutableArray arrayWithArray:models];
        _selected_asset = [NSMutableArray arrayWithArray:assets];

        [_collectionView reloadData];
        
    }];
    [self.superViewController presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)setPush_ImagePickerControllerWith_UnSelected:(NSInteger)index {
    HNBImagePickerController *imagePickerVc = [[HNBImagePickerController alloc] initWithModels:_models photos:_photos selectedModels:_selected_model selectedAssets:_selected_asset index:index];
    imagePickerVc.delegate = (id)self;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.isSelectOriginalPhoto = YES;
    imagePickerVc.maxImagesCount = _RlimitedCount;

    [imagePickerVc setDidFinishPickingPhotosWithModelHanled:^(NSArray<UIImage *> *photos, NSArray<HNBAssetModel *> *models, NSArray *assets, BOOL isSelectOriginalPhoto) {
        _selected_model = [NSMutableArray arrayWithArray:models];
        _selected_asset = [NSMutableArray arrayWithArray:assets];
//        _selected_image = [NSMutableArray arrayWithArray:photos];
        [_collectionView reloadData];
    }];
    [imagePickerVc setDidBackPickingPhotosHandle:^(NSArray<HNBAssetModel *> *models, NSArray *assets) {
        _selected_model = [NSMutableArray arrayWithArray:models];
        _selected_asset = [NSMutableArray arrayWithArray:assets];

        [_collectionView reloadData];
        
    }];
    [self.superViewController presentViewController:imagePickerVc animated:YES completion:nil];

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(115,_itemWH - 10.0f);
}


@end
