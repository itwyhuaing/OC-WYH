//
//  CollectionBannerCell.m
//  CustomLibProject
//
//  Created by hnbwyh on 2019/10/21.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "CollectionBannerCell.h"

@interface CollectionBannerCell ()

@property (nonatomic,strong,readwrite) UILabel *themLabel;

@end

@implementation CollectionBannerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.themLabel];
    }
    return self;
}

-(void)layoutSubviews {
    [self.themLabel setFrame:self.bounds];
}

-(UILabel *)themLabel {
    if (!_themLabel) {
        _themLabel = [UILabel new];
        _themLabel.font = [UIFont systemFontOfSize:30.0];
        _themLabel.textAlignment = NSTextAlignmentCenter;
        _themLabel.numberOfLines = 0;
    }
    return _themLabel;
}

@end
