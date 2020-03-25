//
//  HNBToast.m
//  hinabian
//
//  Created by hnbwyh on 16/9/1.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//

#import "HNBToast.h"
#import "MBProgressHUD.h"

//190 x 110 单行最多容纳 10 个字 & 2行
#define HUD_WIDTH  (190*SCREEN_SCALE)
#define HUD_HEIGHT (110)

#define HUD_WIDTH_SQURE (100)

#define WORD_MUN_MIN (4)
#define WORD_MUN_MAX (10*SCREEN_SCALE)

@interface HNBToast ()

@property (nonatomic,strong) MBProgressHUD *toast;

@end

@implementation HNBToast

#pragma mark ------ shareManager

+(instancetype)shareManager{

    static HNBToast *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HNBToast alloc] init];
    });
    return instance;
}

//#pragma mark ------ 实例方法
//
//- (void)showWaitingStatusOnView:(UIView *)superView msg:(NSString *)msg{
//    
//    if (superView == nil) {
//        superView = [UIApplication sharedApplication].keyWindow;
//    }
//    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
//    if (msg.length <= 0) {
//        msg = @"请稍后 ...";
//    }
//    hud.label.text = msg;
//    hud.label.numberOfLines = 0;
//    hud.bezelView.backgroundColor = [UIColor blackColor];
//    hud.activityIndictorColor = UIActivityIndicatorViewStyleWhiteLarge;
//    hud.label.textColor = [UIColor whiteColor];
//    hud.minSize = CGSizeMake(HUD_WIDTH, HUD_WIDTH);
//    hud.y_offset = -0.0f;
//    hud.label.font = [UIFont systemFontOfSize:14.0];
//    _toast = hud;
//}
//
//
//-(void)showOnView:(UIView *)superView imageName:(NSString *)imgName msg:(NSString *)msg{
//    
//    if (superView == nil) {
//        superView = [UIApplication sharedApplication].keyWindow;
//    }
//    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
//    hud.mode = MBProgressHUDModeCustomView;
//    if (imgName.length > 0) {
//        UIImage *img = [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        hud.customView = [[UIImageView alloc] initWithImage:img];
//    }
//    hud.square = NO;
//    hud.y_offset = imgName.length > 0 ? 0.f : -10.f;
//    hud.label.text = msg;
//    hud.label.numberOfLines = 0;
//    hud.label.textColor = [UIColor whiteColor];
//    hud.label.font = [UIFont systemFontOfSize:14.0];
//    hud.minSize = CGSizeMake(HUD_WIDTH, HUD_HEIGHT);
//    hud.bezelView.backgroundColor = [UIColor blackColor];
//    _toast = hud;
//}
//
//- (void)dismissImageName:(NSString *)imgName msg:(NSString *)msg afterDelay:(NSTimeInterval)delay{
//
//    if (msg.length > 0) {
//        UIImage *img = [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        _toast.customView = [[UIImageView alloc] initWithImage:img];
//    }
//    
//    _toast.label.text = msg;
//    [_toast hideAnimated:YES afterDelay:delay];
//
//}
//
//-(void)dismissAfterDelay:(NSTimeInterval)delay{
//    [_toast hideAnimated:YES afterDelay:delay];
//}
//
//- (void)dismiss{
//    [_toast hideAnimated:YES];
//}
//
//- (void)showMesageWithHiddenOnView:(UIView *)superView imageName:(NSString *)imgName msg:(NSString *)msg afterDelay:(NSTimeInterval)delay{
//    
//    if (_toast != nil) {
//        [_toast hideAnimated:YES];
//    }
//    
//    if (superView == nil) {
//        superView = [UIApplication sharedApplication].keyWindow;
//    }
//    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
//    hud.mode = MBProgressHUDModeCustomView;
//    if (imgName.length > 0) {
//        UIImage *img = [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        hud.customView = [[UIImageView alloc] initWithImage:img];
//    }
//    hud.square = NO;
//    hud.y_offset = imgName.length > 0 ? 0.f : 50.f;
//    hud.label.text = msg;
//    hud.label.numberOfLines = 0;
//    hud.label.textColor = [UIColor whiteColor];
//    hud.label.font = [UIFont systemFontOfSize:14.0];
//    hud.minSize = CGSizeMake(HUD_WIDTH, HUD_HEIGHT);
//    hud.bezelView.backgroundColor = [UIColor blackColor];
//    [hud hideAnimated:YES afterDelay:delay];
//    
//}


- (void)toastWithOnView:(UIView *)superView msg:(NSString *)msg afterDelay:(NSTimeInterval)delay style:(HNBToastHudStyle)hudStyle{

    if (superView == nil) {
        superView = [UIApplication sharedApplication].keyWindow;
    }
    
    [_toast hideAnimated:YES];
    switch (hudStyle) {
        case HNBToastHudWaiting:
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
            //hud.margin = 15.0f;
            _toast = hud;
            [self modifyHNBToastHudWaitingToastWithMsg:msg];
        }
            break;
        case HNBToastHudSuccession:
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
            //hud.margin = 15.0f;
            _toast = hud;
            [self modifyToastWithMsg:msg imgName:@"toast_success"];
        }
            break;
        case HNBToastHudFailure:
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
            _toast = hud;
            [self modifyToastWithMsg:msg imgName:@"toast_problem"];
        }
            break;
        case HNBToastHudOnlyText:
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
            _toast = hud;
            [self modifyToastWithMsg:msg imgName:nil];
        }
            break;
        case HNBToastHudOnlyTitleAndDetailText:
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
            _toast = hud;
            [self modifyTitleAndDetailTextToastWithMsg:msg];
        }
            break;
            
        default:
            break;
    }
    
    if (delay > 0.f) {
        [_toast hideAnimated:YES afterDelay:delay];
    }
    
}

- (void)dismiss{
    
    [_toast hideAnimated:YES];
}

#pragma mark ------ HNBToastHudWaiting

- (void)modifyHNBToastHudWaitingToastWithMsg:(NSString *)msg{

    if (msg.length <= 0) {
        msg = @"请稍后";
    }
    
    if (msg.length <= WORD_MUN_MIN) {
        _toast.maxSize = CGSizeMake(HUD_WIDTH_SQURE, HUD_WIDTH_SQURE);
        _toast.minSize = CGSizeMake(HUD_WIDTH_SQURE, HUD_WIDTH_SQURE);
        _toast.square = YES;
        
    }
    else if(msg.length > WORD_MUN_MIN && msg.length < WORD_MUN_MAX)
    {
        _toast.maxSize = CGSizeMake(HUD_WIDTH, HUD_WIDTH_SQURE);
    }
    else if (msg.length >= WORD_MUN_MAX && msg.length <= WORD_MUN_MAX * 2) {
        
        _toast.maxSize = CGSizeMake(HUD_WIDTH, HUD_HEIGHT);
        _toast.minSize = CGSizeMake(HUD_WIDTH, HUD_HEIGHT);
        
    }else if (msg.length > WORD_MUN_MAX * 2){
        
        _toast.maxSize = CGSizeMake(HUD_WIDTH, SCREEN_HEIGHT);
    }
    _toast.activityIndictorColor = UIActivityIndicatorViewStyleWhiteLarge;
    _toast.label.text = msg;
    [self modifyToast:_toast];
}

#pragma mark ------ HNBToastHudSuccession HNBToastHudFailure HNBToastHudOnlyText

- (void)modifyToastWithMsg:(NSString *)msg imgName:(NSString *)imgName{
    if ([msg isKindOfClass:[NSString class]]) {     //防护
        _toast.mode = MBProgressHUDModeCustomView;
        if (imgName.length > 0) {
            
            // 图片
            UIImage *img = [[UIImage imageNamed:imgName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            _toast.customView = [[UIImageView alloc] initWithImage:img];
            
            // 文字
            
            if (msg != nil && msg.length > 0 && msg.length <= WORD_MUN_MIN) {
                _toast.maxSize = CGSizeMake(HUD_WIDTH_SQURE, HUD_WIDTH_SQURE);
                _toast.minSize = CGSizeMake(HUD_WIDTH_SQURE, HUD_WIDTH_SQURE);
                _toast.square = YES;
            }
            else if(msg.length > WORD_MUN_MIN && msg.length < WORD_MUN_MAX)
            {
                _toast.maxSize = CGSizeMake(HUD_WIDTH, HUD_WIDTH_SQURE);
            }
            else if (msg.length >= WORD_MUN_MAX && msg.length <= WORD_MUN_MAX * 2) {
                
                _toast.maxSize = CGSizeMake(HUD_WIDTH, HUD_HEIGHT);
                _toast.minSize = CGSizeMake(HUD_WIDTH, HUD_HEIGHT);
                
            }
            else if (msg.length > WORD_MUN_MAX * 2)
            {
                _toast.maxSize = CGSizeMake(HUD_WIDTH, SCREEN_HEIGHT);
            }
            
            
        }else{
            
            if (msg.length >= WORD_MUN_MAX) {
                
                _toast.maxSize = CGSizeMake(HUD_WIDTH, SCREEN_HEIGHT);
                
            }
            
        }
        
        _toast.label.text = msg;
        [self modifyToast:_toast];
    }else{
        return;
    }
}

#pragma mark ------ HNBToastHudOnlyTitleAndDetailText

- (void)modifyTitleAndDetailTextToastWithMsg:(NSString *)msg{
    // msg格式 : "title"P&"content"
    NSArray *tmpArr = [msg componentsSeparatedByString:@"P&"];
    NSString *title = [tmpArr firstObject];
    NSString *content = [tmpArr lastObject];
    
    _toast.mode = MBProgressHUDModeCustomView;
    _toast.maxSize = CGSizeMake(SCREEN_WIDTH * 0.8, SCREEN_HEIGHT);
    
    _toast.label.text = title;
    _toast.detailsLabel.text = content;
    _toast.label.numberOfLines = 0;
    _toast.label.textColor = [UIColor whiteColor];
    _toast.detailsLabel.textColor = [UIColor whiteColor];
    _toast.label.font = [UIFont fontWithName:@"Helvetica-Bold" size:FONT_UI32PX];
    _toast.detailsLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:FONT_UI28PX];
    _toast.bezelView.color = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.7];
    
}

#pragma mark ------

- (void)modifyToast:(MBProgressHUD *)toast{
    
    _toast.label.font = [UIFont systemFontOfSize:FONT_UI28PX];
    _toast.label.numberOfLines = 0;
    _toast.label.textColor = [UIColor whiteColor];
    _toast.bezelView.color = [UIColor colorWithRed:0/255.0f green:0/255.0f blue:0/255.0f alpha:0.7];
    
}

#pragma mark ------ setter

-(void)setMaxSize:(CGSize)maxSize{
    _toast.maxSize = maxSize;
}

-(void)setMinSize:(CGSize)minSize{
    _toast.minSize = minSize;
}

- (void)setY_offset:(CGFloat)y_offset{
    _toast.y_offset = y_offset;
}

- (void)setBgColor:(UIColor *)bgColor{
    _toast.backgroundColor = bgColor;
}

@end
