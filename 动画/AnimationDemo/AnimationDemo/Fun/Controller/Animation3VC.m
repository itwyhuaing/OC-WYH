//
//  Animation3VC.m
//  AnimationDemo
//
//  Created by hnbwyh on 2018/8/22.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "Animation3VC.h"
#import "UIImageView+JXImageView.h"
#import "UIImage+Addition.h"

@interface Animation3VC ()

// view
@property (nonatomic,strong) UIImageView    *displayV;                  // 用于展示向右侧滑动过程中的第二张图片

// data
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *rectData;

// parameter
@property (nonatomic,assign) CGFloat        velocityThreshold;          // 快速滑动速度阀值设置
@property (nonatomic,assign) CGFloat        edgeGapThreshold;           // 慢速滑动边缘阀值设置
@property (nonatomic,assign) CGFloat        alphaBaseValue;             // 图片透明度基准值
@property (nonatomic,assign) CGFloat        alphaGap;                   // 图片透明度间距值
@property (nonatomic,assign) CGFloat        rightDirection_VGap;        // 向右侧滑动时所展示的两张图片间距
@property (nonatomic,assign) CGFloat        vCornerRadius;              // 图片圆角

// switch
@property (nonatomic,assign) BOOL           leftDirectionAble;          // 向左侧滑动开关
@property (nonatomic,assign) BOOL           rightDirectionAble;         // 向右侧滑动开关

@end

@implementation Animation3VC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.leftDirectionAble              = TRUE;
    self.rightDirectionAble             = TRUE;
    self.velocityThreshold              = 900.0f;
    self.edgeGapThreshold               = 56.0f;
    self.alphaBaseValue                 = 0.8f;
    self.alphaGap                       = 0.08f;
    self.rightDirection_VGap            = 30.f;
    self.vCornerRadius                  = 6.0;
    
    CGFloat imgW                        = 692.0/2.0;
    CGFloat imgH                        = 380.0/2.0;
    
//    imgW                        = 530.0/2.0;
//    imgH                        = 290.0/2.0;
    
    CGFloat h_offset                    = 30.f;
    CGFloat v_offset                    = -3.0;
    CGPoint startPoint                  = CGPointMake(0, 100.0);
    
    CGRect rect                         = CGRectZero;
    rect.size                           = CGSizeMake(imgW, imgH);
    rect.origin                         = startPoint;
    CGRect preRect = CGRectZero;
    for (NSInteger cou = 0; cou < 4; cou ++) {
        
        // imageView
        UIImageView *imgV                       = [[UIImageView alloc] init];
        imgV.imgName                            = [NSString stringWithFormat:@"%ld%ld",cou+1,cou+1];
        [self.dataSource addObject:imgV];
        
        // 手势添加
        UIPanGestureRecognizer *pan             = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        imgV.userInteractionEnabled             = TRUE;
        [imgV addGestureRecognizer:pan];
        
        // frame
        if(cou > 0){
            rect.origin.x                       = CGRectGetMinX(preRect) + h_offset;
            rect.origin.y                       = CGRectGetMinY(preRect) + v_offset;
        }
        [self.rectData addObject:[NSValue valueWithCGRect:rect]];
        preRect                                 = rect;
        
        // 设置圆角
        imgV.layer.cornerRadius                 = self.vCornerRadius;
        imgV.clipsToBounds                      = TRUE;
    }
    
    // 倒序添加
    for (NSInteger cou = self.dataSource.count - 1; cou >= 0; cou --) {
        [self.view addSubview:self.dataSource[cou]];
    }
    
    // 更新 UI
    [self updateUIStatus];
}


#pragma mark ------ 设置缩放

- (void)updateUIStatus{
    
    // 图片视觉效果
    [self modifyAlphaWithDataSource:self.dataSource];
    //[self modifyFuzzyImageWithDataSource:self.dataSource];
    // 位置及缩放
    [self modifyStatusAboutDataSource:self.dataSource rcts:self.rectData];
    
}



- (void)modifyStatusAboutDataSource:(NSArray *)ds rcts:(NSArray *)rs{
    /**
     1. 复原
     2. frame
     3. 缩放
     4. 图片赋值
     */
    // 位置及缩放
    for (NSInteger cou = 0; cou < ds.count; cou ++) {
        
        CGFloat xScale                      = 0.885;
        CGFloat yScale                      = 0.88;
        UIImageView *imgV                   = (UIImageView *)ds[cou];
        CGRect      rect                    = [(NSValue *)rs[cou] CGRectValue];
        if(cou <= 0){
            [UIView animateWithDuration:0.1 animations:^{
                imgV.layer.transform            = CATransform3DIdentity;
            }];
        }else{
            imgV.layer.transform            = CATransform3DIdentity;
        }
        imgV.layer.transform            = CATransform3DIdentity;
        // 设置 frame
        [imgV setFrame:rect];
        // 设置缩放
        if(cou == 1){
            imgV.layer.transform            = CATransform3DMakeScale(xScale, yScale, 1.0);
        }else if (cou == 2){
            imgV.layer.transform            = CATransform3DMakeScale(xScale-0.128, yScale-0.117, 1.0);
        }else if (cou == 3){
            imgV.layer.transform            = CATransform3DMakeScale(xScale-0.128*2.0, yScale-0.117*2.0, 1.0);
        }
    }
    
}

#pragma mark ------ 手势操作

- (void)pan:(UIPanGestureRecognizer *)p{
    /**
     1. 区分方向
     
     2. 区分速度
     
     3. 取出两张图片
     
     4. 依据阀值(手势状态)是否更新数组 并 修改展示效果
     
     */
    [self testStatusWithPan:p];
    CGPoint velocity                = [p velocityInView:p.view];
    CGPoint tp                      = [p translationInView:p.view];
    
    if(velocity.x < 0){ // 向左
        // 取图片
        UIImageView *curShowImageV  = [self.dataSource firstObject];
        if (velocity.x < 0 - self.velocityThreshold && p.state == UIGestureRecognizerStateEnded){ // 快速 && 保证只执行一次
            [self directionLeftQuickWithCurrentShowImageV:curShowImageV];
        }else{ // 慢速
            [self directionLeftSlowWithCurrentShowImageV:curShowImageV px_offset:tp.x gestureState:p.state];
        }
    }else if (velocity.x > 0){ // 向右
        UIImageView *curShowImageV  = [self.dataSource firstObject];
        UIImageView *willShowImageV = [self.dataSource lastObject];
        [self directionRightWithCurrentShowImageV:curShowImageV willShowImageV:willShowImageV px_offset:tp.x gestureState:p.state];
    }
    
}

#pragma mark - 快速左滑

- (void)directionLeftQuickWithCurrentShowImageV:(UIImageView *)cimgV{
    NSLog(@"\n\n快速左滑\n\n");
    [self directionLeftAnimationWithCurrentShowImageV:cimgV];
    
    // 先右滑不松手再左滑需要检查图片展示情况
    [self hiddenTheSecondImageV];
}

#pragma mark - 慢速左滑

- (void)directionLeftSlowWithCurrentShowImageV:(UIImageView *)cimgV px_offset:(CGFloat)x_offset gestureState:(UIGestureRecognizerState)state{
    [self directionLeftUpdateFrameWithCurrentShowImageV:cimgV px_offset:x_offset];
    // 先右滑不松手再左滑需要检查图片展示情况
    [self updateFrameForTheSecondImageVWithCurrentShowImageV:cimgV px_offset:x_offset];
    
    // 手势结束
    if (state == UIGestureRecognizerStateEnded){
        // 对当前图片处理
        if (CGRectGetMinX(cimgV.frame) + CGRectGetWidth(cimgV.frame) <= self.edgeGapThreshold){
            [self directionLeftAnimationWithCurrentShowImageV:cimgV];
        }else{
            CGRect rect     = [(NSValue *)self.rectData[0] CGRectValue];
            [cimgV setFrame:rect];
        }
        
        // 先右滑不松手再左滑需要检查图片展示情况
        [self hiddenTheSecondImageV];
    }
    
    NSLog(@"\n\n慢速左滑:\n%@\n%f\n",cimgV,x_offset);
}


- (void)updateFrameForTheSecondImageVWithCurrentShowImageV:(UIImageView *)cimgV px_offset:(CGFloat)x_offset{
    NSLog(@"\n\n %s \n\n",__FUNCTION__);
    if(!self.displayV.hidden){
        CGRect rect                    = CGRectZero;
        rect.size                      = cimgV.frame.size;
        rect.origin.x                  = CGRectGetMinX(cimgV.frame) - self.rightDirection_VGap - rect.size.width;
        rect.origin.y                  = CGRectGetMinY(cimgV.frame);
        [self.displayV setFrame:rect];
    }
}

#pragma mark - 慢速右滑

- (void)directionRightWithCurrentShowImageV:(UIImageView *)cimgV willShowImageV:(UIImageView *)wImageV px_offset:(CGFloat)x_offset gestureState:(UIGestureRecognizerState)state{
    NSLog(@"\n\n右滑\n\n");
    [self directionRifhtUpdateFrameWithCurrentShowImageV:cimgV willShowImageV:wImageV px_offset:x_offset];
    if (state == UIGestureRecognizerStateEnded){
        [self directionRightAnimationWithWillShowImageV:wImageV];
        [self hiddenTheSecondImageV];
    }
}

#pragma mark - left - animation

- (void)directionLeftAnimationWithCurrentShowImageV:(UIImageView *)cimgV{
    // 更新数组
    [self.dataSource removeObjectAtIndex:0];
    [self.dataSource addObject:cimgV];
    
    // 更新图层
    for (UIImageView *imgV in self.dataSource) {
        [imgV removeFromSuperview];
    }
    for (NSInteger cou = self.dataSource.count - 1; cou >= 0; cou --) {
        [self.view addSubview:self.dataSource[cou]];
    }
    
    // 更新 UI
    [self updateUIStatus];
}

#pragma mark - left - frame

- (void)directionLeftUpdateFrameWithCurrentShowImageV:(UIImageView *)cimgV px_offset:(CGFloat)x_offset{
    CGRect rect     = [(NSValue *)self.rectData[0] CGRectValue];
    rect.origin.x   += x_offset;
    [cimgV setFrame:rect];
}


#pragma mark - right - animation

- (void)directionRightAnimationWithWillShowImageV:(UIImageView *)wImageV{
    // 更新数组
    [self.dataSource removeObject:wImageV];
    [self.dataSource insertObject:wImageV atIndex:0];
    
    // 更新图层
    for (UIImageView *imgV in self.dataSource) {
        [imgV removeFromSuperview];
    }
    for (NSInteger cou = self.dataSource.count - 1; cou >= 0; cou --) {
        [self.view addSubview:self.dataSource[cou]];
    }
    
    // 更新 UI
    [self updateUIStatus];
}


#pragma mark - right - frame

- (void)directionRifhtUpdateFrameWithCurrentShowImageV:(UIImageView *)cimgV willShowImageV:(UIImageView *)wImageV px_offset:(CGFloat)x_offset{
    // 右侧第一张图片
    CGRect fRect     = [(NSValue *)self.rectData[0] CGRectValue];
    fRect.origin.x   += x_offset;
    [cimgV setFrame:fRect];
    
    // 右侧第二张图片
    if (x_offset >= self.rightDirection_VGap){
        [self showTheSecondImageV];
        CGRect sRect                    = CGRectZero;
        sRect.origin.x                  = -fRect.size.width + (x_offset - self.rightDirection_VGap);
        sRect.origin.y                  = fRect.origin.y;
        sRect.size                      = fRect.size;
        self.displayV.image             = [UIImage imageNamed:wImageV.imgName];
        [self.displayV setFrame:sRect];
        [self.view bringSubviewToFront:self.displayV];
    }
}

#pragma mark - 右侧滑动过程中 第二张图片的展示与隐藏

- (void)hiddenTheSecondImageV{
    self.displayV.hidden            = TRUE;
}

- (void)showTheSecondImageV{
    self.displayV.hidden            = FALSE;
}

#pragma mark ------ 设置图片浅色视觉效果

- (void)modifyAlphaWithDataSource:(NSArray *)ds{
    for (NSInteger cou = 0; cou < ds.count; cou ++) {
        UIImageView *imgV                   = (UIImageView *)ds[cou];
        // 检查图片展示
        UIImage *curImage                   = [UIImage imageNamed:imgV.imgName];
        imgV.image                          = curImage;
        imgV.alpha                          = cou <= 0 ? 1.0 : self.alphaBaseValue - (self.alphaGap * cou);
    }
}

- (void)modifyFuzzyImageWithDataSource:(NSArray *)ds{
    for (NSInteger cou = 0; cou < ds.count; cou ++) {
        UIImageView *imgV                   = (UIImageView *)ds[cou];
        // 检查图片展示
        UIImage *curImage                   = [UIImage imageNamed:imgV.imgName];
        imgV.image                          = cou <= 0 ? curImage : [UIImage fuzzyImage:curImage];
    }
}

#pragma mark ------ lazy load

-(NSMutableArray *)dataSource{
    if(!_dataSource){
        _dataSource     = [NSMutableArray new];
    }
    return _dataSource;
}

-(NSMutableArray *)rectData{
    if(!_rectData){
        _rectData       = [NSMutableArray new];
    }
    return _rectData;
}


-(UIImageView *)displayV{
    if (!_displayV){
        _displayV       = [[UIImageView alloc] initWithFrame:CGRectZero];
        _displayV.layer.cornerRadius        = self.vCornerRadius;
        _displayV.clipsToBounds             = TRUE;
        [self.view addSubview:_displayV];
    }
    return _displayV;
}

#pragma mark ------ 手势状态测试


/**
 UIGestureRecognizerStatePossible,
 
 UIGestureRecognizerStateBegan,
 UIGestureRecognizerStateChanged,
 UIGestureRecognizerStateEnded,
 UIGestureRecognizerStateCancelled,
 
 UIGestureRecognizerStateFailed,
 
 
 UIGestureRecognizerStateRecognized = UIGestureRecognizerStateEnded
 */

- (void)testStatusWithPan:(UIPanGestureRecognizer *)p{
    switch (p.state) {
            case UIGestureRecognizerStateBegan:
        {
            NSLog(@"\n\n nUIGestureRecognizerStateBegan\n\n");
        }
            break;
            case UIGestureRecognizerStateChanged:
        {
            NSLog(@"\n\n UIGestureRecognizerStateChanged\n\n");
        }
            break;
            case UIGestureRecognizerStateEnded:
        {
            NSLog(@"\n\n UIGestureRecognizerStateEnded\n\n");
        }
            break;
            case UIGestureRecognizerStateCancelled:
        {
            NSLog(@"\n\n UIGestureRecognizerStateCancelled\n\n");
        }
            break;
            case UIGestureRecognizerStateFailed:
        {
            NSLog(@"\n\n UIGestureRecognizerStateFailed\n\n");
        }
            break;
            //            case UIGestureRecognizerStateRecognized:
            //            {
            //                NSLog(@"\n\n UIGestureRecognizerStateRecognized\n\n");
            //            }
            //            break;
            
        default:
            break;
    }
}

@end
