//
//  HNBLinearCell.m
//  FineHouse
//
//  Created by 蔡成汉 on 2018/8/31.
//  Copyright © 2018年 Hinabian. All rights reserved.
//

#import "HNBLinearCell.h"
#import <SDAutoLayout/SDAutoLayout.h>
#import "HomeDataModel.h"

@interface HNBLinearCell ()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UILabel *titleLab;

@end

@implementation HNBLinearCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initialView];
        [self makeConstraints];
    }
    return self;
}

- (void)initialView {
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.titleLab];
}

- (void)makeConstraints {
    self.imgView.sd_layout
    .topEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
    
    self.titleLab.sd_layout
    .topEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
}

- (void)setData:(HomeHotCityDataModel *)data {
    _data = data;
    NSString *imageUrl = _data.img;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:imageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            [UIImage cornerImage:image size:self.bounds.size roundingCorners:UIRectCornerAllCorners cornerRadius:4 complete:^(UIImage *cornerImage) {
                self.imgView.image = cornerImage;
            }];
        }
    }];
}

- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc]init];
        _imgView.backgroundColor = [UIColor clearColor];
        _imgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        _imgView.layer.shadowOpacity = 0.5;
        _imgView.layer.shadowRadius = 4;
        _imgView.layer.shadowOffset = CGSizeMake(2, 3);
    }
    return _imgView;
}

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont systemFontOfSize:40];
    }
    return _titleLab;
}

@end
