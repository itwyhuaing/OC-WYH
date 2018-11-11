//
//  CommonItem.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/9/28.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "CommonItem.h"

@interface CommonItem ()

@property (nonatomic,strong)        UIImageView         *cntIcon;

@end

@implementation CommonItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}


- (void)configUI{
    [self addSubview:self.cntIcon];
}

-(void)setData:(ItemModel *)data{
    _data = data;
    [self.cntIcon setImage:[UIImage imageNamed:data.icon]];
}

-(UIImageView *)cntIcon{
    if (!_cntIcon) {
        _cntIcon                = [UIImageView new];
        _cntIcon.contentMode    = UIViewContentModeCenter;
        _cntIcon.clipsToBounds  = TRUE;
    }
    return _cntIcon;
}

-(void)layoutSubviews{
    [self.cntIcon setFrame:self.bounds];
}

@end
