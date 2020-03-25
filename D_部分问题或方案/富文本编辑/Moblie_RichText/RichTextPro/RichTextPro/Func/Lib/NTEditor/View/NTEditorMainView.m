//
//  NTEditorMainView.m
//  RichTextPro
//
//  Created by hnbwyh on 2019/12/23.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "NTEditorMainView.h"
#import "NTEditorTitleView.h"
#import "NTEditorConfig.h"

@interface NTEditorMainView ()
{
    CGFloat height;
}
@property (nonatomic,strong) NTEditorTitleView  *titleHeader;

@end

@implementation NTEditorMainView

#pragma mark ------ init-dealloc

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        [self handleBlock];
    }
    return self;
}

-(void)dealloc {
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark ------

- (void)handleBlock {
    WSelf
    self.titleHeader.updateHight = ^(CGFloat offset_h) {
        [weakSelf layFrameWithHeight:CGRectGetHeight(weakSelf.titleHeader.frame) + offset_h];
    };
}

#pragma mark ------ UI

- (void)configUI {
    [self addSubview:self.titleHeader];
    self.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightRegular];
    height = 40.0;
    self.backgroundColor = [UIColor cyanColor];
}

-(void)layoutSubviews {
    [self layFrameWithHeight:height];
}

- (void)layFrameWithHeight:(CGFloat)h {
    height = h;
    CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.frame), h);
    [self.titleHeader setFrame:rect];
    NSLog(@"\n \n Main页面 %s \n %@ \n %@ \n",__FUNCTION__,self,self.titleHeader);
    self.textContainerInset = UIEdgeInsetsMake(CGRectGetMaxY(rect)+6.0, 0, 0, 0);
}

-(NTEditorTitleView *)titleHeader {
    if (!_titleHeader) {
        _titleHeader = [[NTEditorTitleView alloc] init];
    }
    return _titleHeader;
}

@end
