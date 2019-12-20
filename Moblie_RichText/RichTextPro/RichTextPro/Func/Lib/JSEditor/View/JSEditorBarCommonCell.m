//
//  JSEditorBarCommonCell.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/12/12.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "JSEditorBarCommonCell.h"

@interface JSEditorBarCommonCell ()

@property (nonatomic, strong) UIImageView       *icon;
@property (nonatomic, strong) UILabel           *title;

@end

@implementation JSEditorBarCommonCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews{
    CGRect rect = self.frame;
    rect.origin = CGPointZero;
    _icon = [[UIImageView alloc] initWithFrame:rect];
    _icon.contentMode = UIViewContentModeCenter;
    _icon.clipsToBounds = TRUE;
    [self addSubview:_icon];
//    _icon.backgroundColor = [UIColor orangeColor];
}

-(void)setData:(ToolBarItem *)data {
    if (data) {
        _data = data;
        NSString *iconName = data.isOn ? data.onIconName : data.offIconName;
        self.icon.image = [UIImage imageNamed:iconName];
    }
}

@end
