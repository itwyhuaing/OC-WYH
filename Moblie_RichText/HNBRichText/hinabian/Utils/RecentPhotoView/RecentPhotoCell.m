//
//  RecentPhotoCell.m
//  hinabian
//
//  Created by 何松泽 on 2017/8/2.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import "RecentPhotoCell.h"
#import "RecentPHManage.h"
#import "UIView+Layout.h"
#import "RecentSelectView.h"
#import "HNBAssetModel.h"

@implementation RecentPhotoCell

-(void)prepareForReuse{
    _recentPH.image = nil;
}

-(void)awakeFromNib{
    [super awakeFromNib];
}

-(void)setCellByModel:(HNBAssetModel *)model
{
    _model = model;
    self.representedAssetIdentifier = [[RecentPHManage defaultPHManager] getAssetIdentifier:model.asset];
    PHImageRequestID imageRequestID = [[RecentPHManage defaultPHManager] getPhotoWithAsset:model.asset photoWidth:self.tz_width completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {

        if ([self.representedAssetIdentifier isEqualToString:[[RecentPHManage defaultPHManager] getAssetIdentifier:model.asset]]) {
            self.recentPH.image = photo;
        } else {
            [[PHImageManager defaultManager] cancelImageRequest:self.imageRequestID];
        }
        if (!isDegraded) {
            self.imageRequestID = 0;
        }
    }];
    if (imageRequestID && self.imageRequestID && imageRequestID != self.imageRequestID) {
        [[PHImageManager defaultManager] cancelImageRequest:self.imageRequestID];
        // NSLog(@"cancelImageRequest %d",self.imageRequestID);
    }
    self.imageRequestID = imageRequestID;
    
    /*这个过于高清，会造成卡顿*/
//    PHAsset *tempAsset = model.asset;
//    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
//    // 同步获得图片, 只会返回1张图片
//    options.synchronous = YES;
//    options.version = PHImageRequestOptionsVersionCurrent;
//    options.resizeMode = PHImageRequestOptionsResizeModeFast;
//    options.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
//    [[PHImageManager defaultManager] requestImageDataForAsset: tempAsset options: options resultHandler: ^(NSData * imageData, NSString * dataUTI, UIImageOrientation orientation, NSDictionary * info) {
//        UIImageView *imgView = [[UIImageView alloc]initWithFrame:self.bounds];
//        imgView.contentMode = UIViewContentModeScaleAspectFit;
//        imgView.clipsToBounds = YES;
//        imgView.image = [UIImage imageWithData:imageData];
//        [self.contentView addSubview:imgView];
//        _recentPH = imgView;
//        
//    }];
    
    [self setBackgroundColor:[UIColor blackColor]];
    [self.selectView cancelChoose];
    self.selectPhotoButton.selected = model.isSelected;
//    self.selectImageView.image = self.selectPhotoButton.isSelected ? [UIImage imageNamed:@"reg_content_agree_btn_default"] : [UIImage imageNamed:@"reg_content_agree_btn_nonselect"];
    self.selectImageView.image = self.selectPhotoButton.isSelected ? [UIImage imageNamed:@""] : [UIImage imageNamed:@""];
    if (self.selectPhotoButton.isSelected) {
        self.selectView.numLabel.hidden = NO;
        [self.selectView setBackgroundColor:[UIColor colorWithRed:24.f/255.f green:143.f/255.f blue:255.f/255.f alpha:1.f]];
    }else{
        [self.selectView cancelChoose];
    }
}

- (void)setNumForLabel:(HNBAssetModel *)model {
    if (model.isSelected) {
        self.selectView.numLabel.hidden = NO;
        [self.selectView setBackgroundColor:[UIColor colorWithRed:24.f/255.f green:143.f/255.f blue:255.f/255.f alpha:1.f]];
    }
    self.selectView.numLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)model.tag];
}

- (void)selectPhotoButtonClick:(UIButton *)sender {
    if (self.didSelectPhotoBlock) {
        self.didSelectPhotoBlock(sender.isSelected);
    }
    self.selectImageView.image = self.selectPhotoButton.isSelected ? [UIImage imageNamed:@""] : [UIImage imageNamed:@""];
    if (self.selectPhotoButton.isSelected) {
        self.selectView.numLabel.hidden = NO;
        [self.selectView setBackgroundColor:[UIColor colorWithRed:24.f/255.f green:143.f/255.f blue:255.f/255.f alpha:1.f]];
    }else{
        [self.selectView cancelChoose];
    }
    if (sender.isSelected) {
        [UIView showOscillatoryAnimationWithLayer:_selectView.numLabel.layer type:TZOscillatoryAnimationToBigger];
//        [UIView showOscillatoryAnimationWithLayer:_selectImageView.layer type:HNBOscillatoryAnimationToBigger];
    }else {
        [UIView showOscillatoryAnimationWithLayer:_selectView.numLabel.layer type:TZOscillatoryAnimationToSmaller];
    }
}

- (UIImageView *)recentPH{
    if (_recentPH == nil) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:self.bounds];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        imgView.clipsToBounds = YES;
        [self.contentView addSubview:imgView];
        _recentPH = imgView;
    }
    return _recentPH;
    
}

- (UIButton *)selectPhotoButton {
    if (_selectImageView == nil) {
        UIButton *selectPhotoButton = [[UIButton alloc] init];
//        selectPhotoButton.frame = CGRectMake(self.bounds.size.width - 44, 0, 44, 44);
        selectPhotoButton.frame = CGRectMake(self.bounds.size.width - 74, 0, 74, 74);
        [selectPhotoButton addTarget:self action:@selector(selectPhotoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:selectPhotoButton];
        _selectPhotoButton = selectPhotoButton;
    }
    return _selectPhotoButton;
}

- (UIImageView *)selectImageView {
    if (_selectImageView == nil) {
        float dis = 10.f;
        UIImageView *selectImageView = [[UIImageView alloc] init];
        selectImageView.frame = CGRectMake(self.bounds.size.width - 27 - dis, dis, 27, 27);
        [self.contentView addSubview:selectImageView];
        _selectImageView = selectImageView;
    }
    return _selectImageView;
}

- (RecentSelectView *)selectView {
    if (_selectView == nil) {
        float dis = 5.f;
        RecentSelectView *tempView = [[RecentSelectView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 27 - dis, dis, 27, 27)];
        tempView.numLabel.hidden = YES;
        [tempView setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:tempView];
        _selectView = tempView;
    }
    return _selectView;
}

@end
