//
//  CustomLineCell.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/10/24.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "CustomLineCell.h"


@interface InfoBar ()

@property (nonatomic,strong)    UIImageView         *icon;
@property (nonatomic,strong)    UILabel             *them;

@end

@implementation InfoBar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI{
    [self addSubview:self.icon];
    [self addSubview:self.them];
    CGRect rect     = CGRectZero;
    rect.size       = CGSizeMake(30, 30);
    rect.origin.x   = 6.0;
    rect.origin.y   = (CGRectGetHeight(self.frame) - 30.0)/2.0;
    [self.icon setFrame:rect];
    rect.origin.x   = CGRectGetMaxX(rect) + 6.0;
    rect.origin.y   = 0.0;
    rect.size.height= CGRectGetHeight(self.frame);
    rect.size.width = CGRectGetWidth(self.frame) - rect.origin.x;
    [self.them setFrame:rect];
    
    self.icon.backgroundColor = [UIColor redColor];
    self.them.backgroundColor = [UIColor cyanColor];
}

-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
    }
    return _icon;
}

-(UILabel *)them{
    if (!_them) {
        _them = [[UILabel alloc] init];
    }
    return _them;
}

@end


@interface CustomLineCell ()

@property (nonatomic,weak)      UIImageView *photoView;

@property (nonatomic,weak)      UIView      *infoV;

@end

@implementation CustomLineCell

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

-(UIView *)infoV{
    if (!_infoV) {
        UIView *info      = [[UIView alloc] init];
        //[self.contentView addSubview:info];
        _infoV = info;
    }
    return _infoV;
}


- (void)setImageName:(NSString *)imageName {
    
    _imageName = [imageName copy];
    
    self.photoView.image            = [UIImage imageNamed:_imageName];
    // self.infoV.backgroundColor      = [UIColor redColor];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect rect             = self.bounds;
    self.photoView.frame    = rect;
    rect.size.height        = CGRectGetWidth(rect) * 0.5;
    rect.size.width         = CGRectGetWidth(rect) * 0.5;
    rect.origin.x           = self.bounds.size.width/2.0 - rect.size.width/2.0;
    rect.origin.y           = self.bounds.size.height/2.0 - rect.size.height/2.0;
    [self.infoV setFrame:rect];
}

@end
