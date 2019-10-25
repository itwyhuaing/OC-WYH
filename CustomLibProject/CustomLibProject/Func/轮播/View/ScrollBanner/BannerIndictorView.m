//
//  BannerIndictorView.m
//  YHScrollBannerView
//
//  Created by wangyinghua on 2017/5/12.
//  Copyright © 2017年 wangyinghua. All rights reserved.
//

#import "BannerIndictorView.h"

@interface BannerIndictorView ()
{
    BannerIndictorViewStyle      theBarStyle;
    NSInteger              theTotalCount;
}
@property (nonatomic,strong) UIPageControl          *pageControl;    // UIPageControl
@property (nonatomic,strong) UILabel                *indexLabel;     // UILabel
@property (nonatomic,strong) NSMutableArray         *indicatorItems; // 条状滚动

@end


@implementation BannerIndictorView

#pragma mark ------ init UI

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configBannerIndictorViewWithStyle:BannerIndictorViewStylePageControl frame:CGRectZero totalPageCount:0];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configBannerIndictorViewWithStyle:BannerIndictorViewStylePageControl frame:CGRectZero totalPageCount:0];
    }
    return self;
}


-(void)configBannerIndictorViewWithStyle:(BannerIndictorViewStyle)barStyle frame:(CGRect)frame totalPageCount:(NSInteger)totalCount{
    // 读取 初始 值
    theBarStyle        = barStyle;
    theTotalCount      = totalCount;
    // 设置 frame
    [self setFrame:frame];
    
    // 个性化定制
    switch (barStyle) {
        case BannerIndictorViewStylePageControl:
        {
            [self configPageControlWithFrame:frame totalPageCount:totalCount];
        }
            break;
        case BannerIndictorViewStyleIndexCount:
        {
            [self configIndexCountWithFrame:frame totalPageCount:totalCount];
        }
            break;
        case BannerIndictorViewStyleAnimationImage:
        {
            [self configAnimationImageBarWithFrame:frame totalPageCount:totalCount];
        }
            break;
        default:
            break;
    }
    
}

// UIPageControl
- (void)configPageControlWithFrame:(CGRect)frame totalPageCount:(NSInteger)totalCount{
    // pageControl 处理
    [self.pageControl setFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
    self.pageControl.userInteractionEnabled             = NO;
    self.pageControl.currentPageIndicatorTintColor      = [UIColor whiteColor];
    self.pageControl.pageIndicatorTintColor             = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:0.4f];
    self.pageControl.numberOfPages                      = totalCount;
    self.pageControl.currentPage                        = 0;
    self.pageControl.currentPageIndicatorTintColor      = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor             = [UIColor orangeColor];
    self.pageControl.hidesForSinglePage                 = totalCount <= 1;
    
}

// UILabel
- (void)configIndexCountWithFrame:(CGRect)frame totalPageCount:(NSInteger)totalCount{
    // label 处理
    [self.indexLabel setFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
    self.indexLabel.font                = [UIFont systemFontOfSize:15.f];
    self.indexLabel.textAlignment       = NSTextAlignmentCenter;
    self.indexLabel.text                = [NSString stringWithFormat:@"1 / %ld",totalCount];
}

// 条状滚动
- (void)configAnimationImageBarWithFrame:(CGRect)frame totalPageCount:(NSInteger)totalCount{
    // 确保无需生成冗余控件
    for (UIView *v in self.subviews) {
        [v removeFromSuperview];
        [self.indicatorItems removeAllObjects];
    }
    
    // 生成子控件
    CGRect rect             = CGRectZero;
    rect.size.height        = kCommonHeight;
    rect.origin.y           = kTopBottomGap;
    UIView *prev            = [[UIView alloc] initWithFrame:CGRectZero];
    for (NSInteger cou = 0; cou < totalCount; cou ++) {
        rect.origin.x         = CGRectGetMaxX(prev.frame);
        if (cou <= 0) {
            rect.size.width   = kMaxWidth;
        }else{
            rect.size.width   = kMinWidth;
            rect.origin.x     += kInternalGap;
        }
        UIImageView *indicatorImg           = [[UIImageView alloc] initWithFrame:rect];
        indicatorImg.layer.cornerRadius     = kCommonHeight/2.0;
        indicatorImg.layer.masksToBounds    = TRUE;
        [self addSubview:indicatorImg];
        [self.indicatorItems addObject:indicatorImg];
        indicatorImg.backgroundColor = [UIColor whiteColor];
        prev = indicatorImg;
    }
}


#pragma mark ------ goToPageAtLocation

-(void)goToPageAtLocation:(NSInteger)location{
    switch (theBarStyle) {
        case BannerIndictorViewStylePageControl:
            {
                self.pageControl.currentPage = location - 1;
            }
            break;
        case BannerIndictorViewStyleIndexCount:
            {
                self.indexLabel.text = [NSString stringWithFormat:@"%lu / %lu",(long)location,theTotalCount];
            }
            break;
        case BannerIndictorViewStyleAnimationImage:
            {
                if (self.indicatorItems.count > 0 && location-1 < self.indicatorItems.count) {
                    
                    CGRect rect             = CGRectZero;
                    rect.size.height        = kCommonHeight;
                    rect.origin.y           = kTopBottomGap;
                    UIView *prev            = [[UIView alloc] initWithFrame:CGRectZero];
                    for (NSInteger cou = 0; cou < self.indicatorItems.count; cou ++) {
                        UIView *v = self.indicatorItems[cou];
                        rect.origin.x         = CGRectGetMaxX(prev.frame);
                        if (cou > 0) {
                            rect.origin.x     += kInternalGap;
                        }
                        if (cou != location - 1) {
                            rect.size.width   = kMinWidth;
                        }else{
                            rect.size.width   = kMaxWidth;
                        }
                        [UIView animateWithDuration:0.2 animations:^{
                            [v setFrame:rect];
                        }];
                        prev = v;
                    }
                 }
              }
            break;
            
        default:
            break;
    }
}

#pragma mark ------ Lazy load

-(NSMutableArray *)indicatorItems{
    if (!_indicatorItems) {
        _indicatorItems   = [NSMutableArray new];
    }
    return _indicatorItems;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl   = [[UIPageControl alloc] init];_pageControl.backgroundColor = [UIColor redColor];
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

- (UILabel *)indexLabel{
    if (!_indexLabel) {
        _indexLabel   = [[UILabel alloc] init];
        [self addSubview:_indexLabel];
    }
    return _indexLabel;
}

@end

