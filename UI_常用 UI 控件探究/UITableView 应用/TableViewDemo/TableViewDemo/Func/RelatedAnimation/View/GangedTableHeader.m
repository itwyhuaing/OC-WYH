//
//  GangedTableHeader.m
//  TableViewDemo
//
//  Created by hnbwyh on 2018/11/13.
//  Copyright © 2018年 TongXin. All rights reserved.
//

#import "GangedTableHeader.h"

//测试
#import "UIFont+FHFont.h"
#import "SDAutoLayout.h"

@interface GangedTableHeader ()

@property (nonatomic,strong)    UIImageView     *imgV;
@property (nonatomic,strong)    UIButton        *countryBtn;
@property (nonatomic,strong)    UILabel         *countryInfo;
@property (nonatomic,strong)    UIButton        *nhBtn;
@property (nonatomic,strong)    UIButton        *ohBtn;

@end

@implementation GangedTableHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)configUI{
    [self sd_addSubviews:@[self.imgV,self.countryBtn,self.countryInfo,self.nhBtn,self.ohBtn]];
    self.imgV.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    //self.countryBtn.sd_layout
    //.leftSpaceToView(self, 29.0 * )
}

+(CGFloat)height{
    CGFloat h = 140.0/375.0 * CGRectGetWidth([UIScreen mainScreen].bounds);
    return h;
}

-(UIImageView *)imgV{
    if (!_imgV) {
        _imgV = [[UIImageView alloc] init];
        _imgV.contentMode       = UIViewContentModeScaleAspectFill;
        _imgV.clipsToBounds     = TRUE;
    }
    return _imgV;
}

-(UIButton *)countryBtn{
    if (!_countryBtn) {
        _countryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_countryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _countryBtn;
}

-(UILabel *)countryInfo{
    if (!_countryInfo) {
        _countryInfo = [[UILabel alloc] init];
        _countryInfo.textColor = [UIColor whiteColor];
    }
    return _countryInfo;
}

- (UIButton *)nhBtn{
    if (!_nhBtn) {
        _nhBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nhBtn.backgroundColor = [UIColor colorWithRed:0.3 green:0.6 blue:0.5 alpha:1.0];
        _nhBtn.layer.masksToBounds = TRUE;
    }
    return _nhBtn;
}

-(UIButton *)ohBtn{
    if (!_ohBtn) {
        _ohBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nhBtn.backgroundColor = [UIColor colorWithRed:0.3 green:0.6 blue:0.5 alpha:1.0];
        _nhBtn.layer.masksToBounds = TRUE;
    }
    return _ohBtn;
}

@end
