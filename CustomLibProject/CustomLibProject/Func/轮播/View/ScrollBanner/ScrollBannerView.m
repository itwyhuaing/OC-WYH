//
//  ScrollBannerView.m
//  YHScrollBannerView
//
//  Created by wangyinghua on 2017/5/12.
//  Copyright © 2017年 wangyinghua. All rights reserved.
//

#import "ScrollBannerView.h"
#import "BannerMacro.h"

@interface ScrollBannerView () <UIScrollViewDelegate>
{
    NSInteger scrollIndex;
}
@property (nonatomic,strong) UIScrollView                   *scrollView;

@property (nonatomic,assign) CGRect                         selRect;
@property (nonatomic,strong) NSMutableArray                 *imgViewArr;
@property (nonatomic,strong) NSMutableArray                 *imgNameArr;


@property (nonatomic,strong) NSTimer                        *timer;
@property (nonatomic,assign) NSTimeInterval                 timeInterval;
@property (nonatomic,assign) BOOL                           isManual;

@property (nonatomic,assign) NSInteger                      currentLocation;

@end

@implementation ScrollBannerView

/**
 重构init方法
 
 @param frame frame
 @param ti 轮播时间 -- 非0轮播
 @return 实例化后的轮播容器
 */
-(instancetype)initWithFrame:(CGRect)frame autoPlayTimeInterval:(NSTimeInterval)ti {
    self = [super initWithFrame:frame];
    if (self) {
        scrollIndex = 0;
        [self addSubview:self.scrollView];
        
        CGRect rect         = frame;
        rect.origin.x       = 0;
        rect.origin.y       = 0;
        [self.scrollView setFrame:rect];
        self.scrollView.delegate                            = self;
        self.scrollView.pagingEnabled                       = YES;
        self.scrollView.scrollsToTop                        = NO;
        self.scrollView.showsHorizontalScrollIndicator      = NO;
        
        _selRect            = frame;
        _timeInterval       = ti;
        _isManual           = NO;
        
        [self addObservers];
    }
    return self;
}

#pragma mark ----- 新数据处理 - UI刷新

/**
 重置轮播容器数据，并且启动定时器
 
 @param dataSource 轮播容器数据
 */
- (void)reFreshBannerViewWithDataSource:(NSArray<NSString *> *)dataSource {
    if ([self isGoONAccordingDataSource:dataSource]) {
        // 1. 依据外部给定数据源修改页面所需数据源 imgNameArr - 头尾各自再插入一个图片元素
        [self modifyImageNameArrayWithDataSource:dataSource];
        // 2. 设置 ScrollView - 依据图片资源数组imgNameArr添加 UIImageView
        [self reLayoutUIBasedImageCount:self.imgNameArr.count];
        // 3. UIImageView 赋值
        [self refreshImageViewWithDataSource:self.imgNameArr];
        // 4. 自动轮播设置
        [self autoScrollBannerWithDataSource:dataSource];
    }
}

/**<依据数据源是否自动轮播>*/
- (void)autoScrollBannerWithDataSource:(NSArray<NSString *> *)dataSource {
    if (dataSource.count == 1) {
        self.scrollView.scrollEnabled = NO;
        [self stopTimer];
    } else {
        self.scrollView.scrollEnabled = YES;
        if (_timeInterval > 0) {
            //满足条件才启动定时器
            [self startTimer];
        } else {
            [self stopTimer];
        }
    }
}

/**<检查数据源判断是否继续>*/
- (BOOL)isGoONAccordingDataSource:(NSArray<NSString *> *)dataSource{
    BOOL rlt = TRUE;
    if (dataSource == nil || dataSource.count <= 0) {
        // 空数组返回不处理
        rlt = FALSE;
    }else{
        // 检查数据类型
        for (NSInteger cou = 0; cou < dataSource.count; cou ++) {
            id obj = dataSource[cou];
            if (![obj isKindOfClass:[NSString class]]) {
                rlt = FALSE;
            }
        }
    }
    return rlt;
}

/**
 依据外部传递的数据源组装 Banner 所需的 UIImageView 数组

 @param dataSource 外部数据源
 */
- (void)modifyImageNameArrayWithDataSource:(NSArray<NSString *> *)dataSource {
    [self.imgNameArr removeAllObjects];
    [self.imgNameArr addObjectsFromArray:dataSource];
    [self.imgNameArr insertObject:[dataSource lastObject] atIndex:0];
    [self.imgNameArr addObject:[dataSource firstObject]];
}

/**
 依据 UIImageView 数组个数布局 ScrollView

 @param imgCount 数组个数
 */
- (void)reLayoutUIBasedImageCount:(NSInteger)imgCount {
    // 1. scroll 布局方向
    [self.scrollView setContentSize:CGSizeMake(_selRect.size.width * imgCount, 0)];
    // 2. 布局 imageView - 外部给的数据源个数多于或少于当前已生成的 imageView
    NSInteger currentImageVCount = self.imgViewArr.count;
    if (imgCount > currentImageVCount) {
        CGRect rect = _selRect;
        for (NSInteger cou = currentImageVCount; cou < imgCount; cou ++) {
            rect.origin.y = 0;
            rect.origin.x = cou * _selRect.size.width;
           
            UIImageView *imgV = [[UIImageView alloc] initWithFrame:rect];
            imgV.tag = IMGVIEW_LOCATION_TAG + cou;
            [imgV setContentMode:UIViewContentModeScaleAspectFill];
            imgV.clipsToBounds = TRUE;
            [self.scrollView addSubview:imgV];
            [self.imgViewArr addObject:imgV];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedImageView:)];
            imgV.userInteractionEnabled = YES;
            [imgV addGestureRecognizer:tap];
        }
    } else {
        for (NSInteger cou = imgCount; cou < self.imgViewArr.count; cou ++) {
            UIImageView *imgV = self.imgViewArr[cou];
            [imgV removeFromSuperview];
        }
    }
    
    //  设置 setContentOffset 显示数据源中的第一张图片
    [self.scrollView setContentOffset:CGPointMake(_selRect.size.width, 0) animated:NO];
}

/**
 UIImageView 赋值

 @param data 数据源
 */
- (void)refreshImageViewWithDataSource:(NSArray *)data {
    for (NSInteger cou = 0; cou < data.count; cou ++) {
        UIImageView *imgV = self.imgViewArr[cou];
        NSString *imgPara = data[cou];
        if ([imgPara hasPrefix:@"http"]) {
            //[imgV sd_setImageWithURL:[NSURL URLWithString:data[cou]]];
        } else {
            imgV.image = [UIImage imageNamed:data[cou]];
        }
    }
}

#pragma mark ----- UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isManual = YES;
    [_timer setFireDate:[NSDate distantFuture]];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.scrollView.contentOffset.x >= (self.imgNameArr.count - 1) * _selRect.size.width) {
        [self.scrollView setContentOffset:CGPointMake(_selRect.size.width, 0) animated:NO];
    } else if (self.scrollView.contentOffset.x <= 0){
        [self.scrollView setContentOffset:CGPointMake((self.imgNameArr.count - IMGVIEW_EXTRA_COUNT) * _selRect.size.width, 0) animated:NO];
    }
    _currentLocation = floor(self.scrollView.contentOffset.x/_selRect.size.width);    
    if (_isManual) {
        _isManual = NO;
        [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_timeInterval]];
    }
    
    // 会重复触发，可加限制条件
    if (_currentLocation != scrollIndex) {
        scrollIndex = _currentLocation;
        if (scrollIndex >= 1 && scrollIndex <= self.imgNameArr.count - 2) {
            if (self.delegate && [self.delegate respondsToSelector:@selector(scrollBannerView:didEndScrollAtIndex:)]) {
                [self.delegate scrollBannerView:self didEndScrollAtIndex:scrollIndex];
            }
        }
    }
}

#pragma mark ------ autoScrollToTarget

- (void)autoScroll {
    NSInteger nextLocation = (_currentLocation + 1);
    [self.scrollView setContentOffset:CGPointMake(nextLocation * _selRect.size.width, 0) animated:YES];
}

#pragma mark ------ tappedImageView

- (void)tappedImageView:(UITapGestureRecognizer *)tap {
    UIImageView *imgV = (UIImageView *)tap.view;
    NSInteger location = imgV.tag - IMGVIEW_LOCATION_TAG;
    if (location == 0) {
        location = self.imgViewArr.count - IMGVIEW_EXTRA_COUNT;
    } else if (location == self.imgViewArr.count - 1) {
        location = 1;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(scrollBannerView:didSelectedImageViewAtIndex:)]) {
        [_delegate scrollBannerView:self didSelectedImageViewAtIndex:location];
    }
}

/**
 定时器的启停
 */
-(void)timerStatusFire:(NSNotification *)ntf {
    if ([self.timer isValid] && self.timer) {
        if ([ntf.name isEqualToString:kScrollBannerViewTimerOnNotify]) {
            NSLog(@"\n 接收到启动通知 \n");
            [self.timer setFireDate:[NSDate distantPast]];
        }else{
            NSLog(@"\n 接收到暂停通知 \n");
            [self.timer setFireDate:[NSDate distantFuture]];
        }
    }
}

/**
 计时器开始
 */
- (void)startTimer {
    [self stopTimer];
    _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(timerTask) userInfo:nil repeats:YES];
    [_timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:_timeInterval]];
}

/**
 计时器停止
 */
- (void)stopTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

/**
 计时器任务
 */
- (void)timerTask {
    NSLog(@"\n 定时器执行 \n");
    [self autoScroll];
}


- (void)didMoveToSuperview {
    NSLog(@"\n %s \n",__FUNCTION__);
    if (_timer) {
        if (!(self.superview && self.window)) {
            [self stopTimer];
        }
    }
}

-(void)dealloc {
    NSLog(@"\n %s \n",__FUNCTION__);
    [self stopTimer];
}

- (void)addObservers {
    // 添加通知监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timerStatusFire:) name:kScrollBannerViewTimerOnNotify object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timerStatusFire:) name:kScrollBannerViewTimerOffNotify object:nil];
}

- (void)removeObservers {
    // 移除监听通知
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kScrollBannerViewTimerOnNotify
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kScrollBannerViewTimerOffNotify
                                                  object:nil];
}

#pragma mark ------ lazy load

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

-(NSMutableArray *)imgViewArr {
    if (_imgViewArr == nil) {
        _imgViewArr = [[NSMutableArray alloc] init];
    }
    return _imgViewArr;
}

-(NSMutableArray *)imgNameArr {
    if (_imgNameArr == nil) {
        _imgNameArr = [[NSMutableArray alloc] init];
    }
    return _imgNameArr;
}

@end
