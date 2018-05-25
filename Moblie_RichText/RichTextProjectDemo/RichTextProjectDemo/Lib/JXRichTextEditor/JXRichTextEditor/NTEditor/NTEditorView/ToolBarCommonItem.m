//
//  ToolBarCommonItem.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/9.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "ToolBarCommonItem.h"

@interface ToolBarCommonItem ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *title;

@end

@implementation ToolBarCommonItem


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
    //_icon.backgroundColor = [UIColor greenColor];
    
}

-(void)configContentForThem:(NSString *)them{
    if (them &&  _icon) {
        [_icon setImage:[UIImage imageNamed:them]];
    }
}

@end
