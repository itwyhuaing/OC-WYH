//
//  PageControlVC.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/10/24.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "PageControlVC.h"
#import <objc/runtime.h>

@interface PageControlVC ()

@property (nonatomic,strong) NSTimer            *tr;
    
@property (nonatomic,strong) UIPageControl      *pgc;

@end

@implementation PageControlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self printUIPageControlList];
    
    CGSize size = CGSizeMake(300, 120);
    CGRect rect = [UIScreen mainScreen].bounds;
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((rect.size.width-size.width)/2.0, 100, size.width, size.height)];
    self.pgc = pageControl;
    [self.view addSubview:pageControl];
    pageControl.numberOfPages = 5;
    pageControl.backgroundColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    pageControl.pageIndicatorTintColor = [UIColor purpleColor];
    // KVC 设置私有属性
    [pageControl setValue:[UIImage imageNamed:@"red_love"] forKeyPath:@"_currentPageImage"];
    [pageControl setValue:[UIImage imageNamed:@"white_love"] forKeyPath:@"_pageImage"];
    //自动切换选中位置
    __block NSInteger cnt = 0;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 repeats:TRUE block:^(NSTimer * _Nonnull timer) {
        cnt ++;
        if (cnt >= 5) {
            cnt = 0;
        }
        pageControl.currentPage = cnt;
    }];
    self.tr = timer;
    
}

-(void)dealloc {
    if (self.tr) {
        [self.tr invalidate];
        self.tr = nil;
    }
    NSLog(@"%s",__FUNCTION__);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // KVC 设置私有属性 - 此处时机错误，导致异常
//    [self.pgc setValue:[UIImage imageNamed:@"red_love"] forKeyPath:@"_currentPageImage"];
//    [self.pgc setValue:[UIImage imageNamed:@"white_love"] forKeyPath:@"_pageImage"];
}



// 获取 UIPageControl 的所有属性
- (void)printUIPageControlList {
    unsigned int count;
    
    // 成员变量
    Ivar *ivarList = class_copyIvarList([UIPageControl class], &count);
    for (unsigned int i = 0; i < count; i ++) {
        Ivar vr = ivarList[i];
        const char *vrName = ivar_getName(vr);
        NSLog(@"ivar(%d) : %@ ",i,[NSString stringWithUTF8String:vrName]);
    }
    free(ivarList);
    /**
     ivar(0) : _lastUserInterfaceIdiom
     ivar(1) : _indicators
     ivar(2) : _currentPage
     ivar(3) : _displayedPage
     ivar(4) : _pageControlFlags
     ivar(5) : _currentPageImage
     ivar(6) : _pageImage
     ivar(7) : _currentPageImages
     ivar(8) : _pageImages
     ivar(9) : _backgroundVisualEffectView
     ivar(10) : _currentPageIndicatorTintColor
     ivar(11) : _pageIndicatorTintColor
     ivar(12) : _legibilitySettings
     ivar(13) : _numberOfPages
     */
    
    // 属性
    objc_property_t *list = class_copyPropertyList([UIPageControl class], &count);
    for (unsigned int i = 0; i < count; i ++) {
        const char *propertyName = property_getName(list[i]);
        NSLog(@"propertyName(%d) : %@ ",i,[NSString stringWithUTF8String:propertyName]);
    }
    free(list);
    /**
     propertyName(0) : hash
     propertyName(1) : superclass
     propertyName(2) : description
     propertyName(3) : debugDescription
     propertyName(4) : legibilityStyle
     propertyName(5) : legibilitySettings
     propertyName(6) : numberOfPages
     propertyName(7) : currentPage
     propertyName(8) : hidesForSinglePage
     propertyName(9) : defersCurrentPageDisplay
     propertyName(10) : pageIndicatorTintColor
     propertyName(11) : currentPageIndicatorTintColor
     */
    
    // 方法列表
    Method *mlist = class_copyMethodList([UIPageControl class], &count);
    for (unsigned int i = 0; i < count; i ++) {
        Method md = mlist[i];
        NSLog(@"method(%d) : %@",i,NSStringFromSelector(method_getName(md)));
    }
    free(mlist);
    /**

     method(0) : .cxx_destruct
     method(1) : encodeWithCoder:
     method(2) : initWithCoder:
     method(3) : initWithFrame:
     method(4) : layoutSubviews
     method(5) : canBecomeFocused
     method(6) : intrinsicContentSize
     method(7) : sizeThatFits:
     method(8) : endTrackingWithTouch:withEvent:
     method(9) : setCurrentPage:
     method(10) : _setCurrentPage:
     method(11) : _updateCurrentPageDisplay
     method(12) : currentPage
     method(13) : numberOfPages
     method(14) : updateCurrentPageDisplay
     method(15) : gestureRecognizerShouldBegin:
     method(16) : _populateArchivedSubviews:
     method(17) : setNumberOfPages:
     method(18) : sizeForNumberOfPages:
     method(19) : _effectiveContentView
     method(20) : setPageIndicatorTintColor:
     method(21) : setCurrentPageIndicatorTintColor:
     method(22) : _legibilitySettings
     method(23) : _invalidateIndicators
     method(24) : _indicatorViewEnabled:index:
     method(25) : _transitionIndicator:toEnabled:index:
     method(26) : _modernBounds
     method(27) : _indicatorSpacing
     method(28) : setHidesForSinglePage:
     method(29) : pageIndicatorTintColor
     method(30) : currentPageIndicatorTintColor
     method(31) : setDefersCurrentPageDisplay:
     method(32) : _setLegibilitySettings:
     method(33) : _legibilityStyle
     method(34) : _drawModernIndicatorInView:enabled:
     method(35) : _createModernIndicatorImageFromView:
     method(36) : isElementAccessibilityExposedToInterfaceBuilder
     method(37) : _controlEventsForActionTriggered
     method(38) : _didChangeFromIdiom:onScreen:traverseHierarchy:
     method(39) : _contentHuggingDefault_isUsuallyFixedHeight
     method(40) : _displayedPage
     method(41) : _contentHuggingDefault_isUsuallyFixedWidth
     method(42) : _pageIndicatorImageForPage:
     method(43) : _pageIndicatorCurrentImageForPage:
     method(44) : _commonPageControlInit
     method(45) : _activePageIndicatorImage
     method(46) : _pageIndicatorImage
     method(47) : _cachePageIndicatorImages
     method(48) : _setDisplayedPage:
     method(49) : _hasCustomImageForPage:enabled:
     method(50) : _indicatorFrameAtIndex:
     method(51) : _cachedPageIndicatorCurrentImageForPage:
     method(52) : _cachedPageIndicatorImageForPage:
     method(53) : _modernTransitionIndicator:toEnabled:index:legible:
     method(54) : _shouldDrawLegibly
     method(55) : _transitionIndicator:toEnabled:index:legible:
     method(56) : _indicatorViewEnabled:index:legible:
     method(57) : _modernIndicatorImageEnabled:
     method(58) : _modernColorEnabled:
     method(59) : _modernCornerRadius
     method(60) : hidesForSinglePage
     method(61) : defersCurrentPageDisplay
     method(62) : _setLegibilityStyle:
     
     */
    
    
    // 协议列表
    __unsafe_unretained Protocol **plist = class_copyProtocolList([UIPageControl class], &count);
    for (unsigned int i = 0; i < count; i ++) {
        Protocol *mp = plist[i];
        const char *pName = protocol_getName(mp);
        NSLog(@"protocol(%d) : %@ ",i,[NSString stringWithUTF8String:pName]);
    }
    free(plist);
    /**
     protocol(0) : DebugHierarchyObject_Fallback
     */
}

@end
