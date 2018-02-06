//
//  HNBTribePickerView.m
//  hinabian
//
//  Created by hnbwyh on 2017/8/15.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import "HNBTribePickerView.h"

@interface HNBTribePickerView ()
{
    UILabel *_left;
    UILabel *_right;
    UIButton *_lookBtn;
}
@end

@implementation HNBTribePickerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        UILabel *line = [[UILabel alloc] init];
//        [self addSubview:line];
        
        _left = [[UILabel alloc] init];
        [self addSubview:_left];
        
        _right = [[UILabel alloc] init];
        [self addSubview:_right];
        
        _lookBtn = [[UIButton alloc] init];
        [self addSubview:_lookBtn];
        
//        line.sd_layout
//        .topSpaceToView(self, 0)
//        .leftSpaceToView(self, 0)
//        .rightSpaceToView(self, 0)
//        .heightIs(0.8);
        
        _left.sd_layout
        .leftSpaceToView(self, 15)
        .widthIs(120)
        .heightIs(49.0); // self - height 49
        
        _lookBtn.sd_layout
        .rightSpaceToView(self, 15)
        .centerYEqualToView(self)
        .widthIs(15 * SCREEN_WIDTHRATE_6)
        .heightIs(15 * SCREEN_WIDTHRATE_6);
        
        _right.sd_layout
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 0)
        .rightSpaceToView(_lookBtn, 8)
        .leftSpaceToView(_left, 0);
        
        // 赋值及属性设置
        _left.text = @"选择圈子";
        _right.text = @"点击查看";
        [_lookBtn setImage:[UIImage imageNamed:@"lookTribe"] forState:UIControlStateNormal];
        _left.textAlignment = NSTextAlignmentLeft;
        _right.textAlignment = NSTextAlignmentRight;
        _left.font = [UIFont systemFontOfSize:FONT_UI34PX];
        _left.textColor = [UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1.0];
        _right.font = [UIFont systemFontOfSize:FONT_UI32PX];
        _right.textColor = [UIColor colorWithRed:102.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
        self.backgroundColor = [UIColor whiteColor];
        //line.backgroundColor = [UIColor colorFromHexString:@"#c9c9c9"];
        
        // 事件
        [_lookBtn addTarget:self action:@selector(clickLookBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        // Test
//        _left.backgroundColor = [UIColor redColor];
//        _right.backgroundColor = [UIColor yellowColor];
//        _lookBtn.backgroundColor = [UIColor purpleColor];
        
    }
    return self;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedHNBTribePickerView:)]) {
        [_delegate didSelectedHNBTribePickerView:self];
    }
    
}

- (void)clickLookBtn:(UIButton *)btn{

    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedHNBTribePickerView:)]) {
        [_delegate didSelectedHNBTribePickerView:btn];
    }
    
}

-(void)updateDisplayTribeName:(NSString *)displayTribeName{
    if (![displayTribeName isEqualToString:@"null"] && displayTribeName.length > 0) {
        _left.text = displayTribeName;
        if ([_left.text isEqualToString:@"选择圈子"]) {
            _left.textColor = [UIColor colorWithRed:68.0/255.0 green:68.0/255.0 blue:68.0/255.0 alpha:1.0];
        } else {
            _left.textColor = [UIColor colorWithRed:24.0/255.0 green:143.0/255.0 blue:255.0/255.0 alpha:1.0];
        }
    }
}

@end
