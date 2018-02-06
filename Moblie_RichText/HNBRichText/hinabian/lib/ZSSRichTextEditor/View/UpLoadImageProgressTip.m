//
//  UpLoadImageProgressTip.m
//  hinabian
//
//  Created by hnbwyh on 2017/8/22.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import "UpLoadImageProgressTip.h"

@interface UpLoadImageProgressTip ()

@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,strong) UIButton *removeBtn;

@end

@implementation UpLoadImageProgressTip

+ (instancetype)defaultInstance{

    static UpLoadImageProgressTip *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UpLoadImageProgressTip alloc] initWithFrame:CGRectZero];
        instance.currentState = UpLoadImageProgressTipNone;
    });
    return instance;
}

- (void)displayUpLoadImageProgressTiporiginY:(CGFloat)originY{
    
        CGRect rect = CGRectZero;
        rect.size.height = 28.0 * SCREEN_WIDTHRATE_6;
        rect.size.width = SCREEN_WIDTH;
        rect.origin.y = originY;
        [self setFrame:rect];
        self.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:97.0/255.0 blue:97.0/255.0 alpha:1.0];
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    
        // subView
        self.removeBtn.sd_layout
        .rightSpaceToView(self, 12.0)
        .widthIs(18.0 * SCREEN_WIDTHRATE_6)
        .heightEqualToWidth()
        .centerYEqualToView(self);
        self.textLabel.sd_layout
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 0)
        .leftSpaceToView(self, 12.0+18.0 * SCREEN_WIDTHRATE_6+12.0)
        .rightSpaceToView(self.removeBtn, 12.0);
    
//        self.removeBtn.backgroundColor = [UIColor greenColor];
//        self.textLabel.backgroundColor = [UIColor purpleColor];
    
}


- (void)removeUpLoadImageProgressTip{
    //NSLog(@" removeUpLoadImageProgressTip ");
    if (!CGRectEqualToRect(self.frame, CGRectZero)) {
        [self setFrame:CGRectZero];
        [self removeFromSuperview];
        self.currentState = UpLoadImageProgressTipRemove;
    }
}

- (void)updateUpLoadImageProgressTipText:(NSString *)text{
    
    if (_currentState != UpLoadImageProgressTipRemove) {
        if (CGRectEqualToRect(self.frame, CGRectZero)) {
            [self displayUpLoadImageProgressTiporiginY:SCREEN_STATUSHEIGHT+SCREEN_NAVHEIGHT];
        }
        [self.textLabel setText:text];
    }
    
}

#pragma mark ------ 懒加载

- (UILabel *)textLabel{
    if (_textLabel == nil) {
        _textLabel = [[UILabel alloc] init];
        [_textLabel setTextColor:[UIColor whiteColor]];
        [_textLabel setFont:[UIFont systemFontOfSize:FONT_UI22PX]];
        [_textLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_textLabel];
    }
    return _textLabel;
}


- (UIButton *)removeBtn{
    if (_removeBtn == nil) {
        _removeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_removeBtn setImage:[UIImage imageNamed:@"rt_delete_tip.png"] forState:UIControlStateNormal];
        [_removeBtn addTarget:self action:@selector(removeTheView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_removeBtn];
    }
    return _removeBtn;
}


#pragma mark ------ private method

- (void)removeTheView:(UIButton *)btn{
    //NSLog(@" removeTheView ");
    [self removeUpLoadImageProgressTip];
}

@end
