//
//  JXCollectionViewCell.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/10/10.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "JXCollectionViewCell.h"

@interface JXCollectionViewCell ()

@property (weak,nonatomic) UIImageView *photoView;

@end

@implementation JXCollectionViewCell

- (UIImageView *)photoView {
    if (!_photoView) {
        UIImageView *photoView = [[UIImageView alloc] init];
        photoView.layer.borderColor = [[UIColor whiteColor] CGColor];
        photoView.layer.borderWidth = 5;
        [self.contentView addSubview:photoView];
        _photoView = photoView;
    }
    return _photoView;
}

- (void)setImageName:(NSString *)imageName {
    
    _imageName = [imageName copy];
    
    self.photoView.image = [UIImage imageNamed:_imageName];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.photoView.frame = self.bounds;
}

@end
