//
//  CommonReusableHeader.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/9/28.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "CommonReusableHeader.h"

@interface CommonReusableHeader ()

@property (nonatomic,strong)    UILabel *themLabel;

@end

@implementation CommonReusableHeader

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
    self.backgroundColor                = [UIColor whiteColor];
    [self addSubview:self.themLabel];
}

-(void)setThem:(NSString *)them{
    _them = them;
    self.themLabel.text     = them;
}

-(UILabel *)themLabel{
    if (!_themLabel) {
        _themLabel      = [UILabel new];
        _themLabel.font            = [UIFont systemFontOfSize:15.0];
        _themLabel.textColor       = [UIColor blackColor];
    }
    return _themLabel;
}


-(void)layoutSubviews{
    CGRect rect         = self.bounds;
    rect.origin.x       = 10.0;
    [self.themLabel setFrame:rect];
}

@end
