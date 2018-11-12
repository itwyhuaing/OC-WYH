//
//  TabBarItem.m
//  TableViewDemo
//
//  Created by hnbwyh on 2018/11/12.
//  Copyright © 2018年 TongXin. All rights reserved.
//

#import "TabBarItem.h"

@interface TabBarItem ()

@property (nonatomic,strong) UILabel *cntLabel;

@end

@implementation TabBarItem

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
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.cntLabel setFrame:self.bounds];
    
    self.backgroundColor            = [UIColor cyanColor];
    self.cntLabel.backgroundColor   = [UIColor orangeColor];
    
}

-(void)setTitle:(NSString *)title{
    if (title) {
        _title = title;
        self.cntLabel.text = title;
    }
}

-(UILabel *)cntLabel{
    if (!_cntLabel) {
        _cntLabel = [[UILabel alloc] init];
        [self.contentView addSubview:_cntLabel];
        _cntLabel.textColor = [UIColor blackColor];
        _cntLabel.font      = [UIFont systemFontOfSize:16.0];
        _cntLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _cntLabel;
}

@end
