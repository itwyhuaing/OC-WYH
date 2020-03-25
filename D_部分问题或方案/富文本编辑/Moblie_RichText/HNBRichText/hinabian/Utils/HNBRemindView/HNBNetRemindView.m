
//
//  HNBNetRemindView.m
//  hinabian
//
//  Created by hnbwyh on 16/8/3.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//

#import "HNBNetRemindView.h"

@interface HNBNetRemindView ()

@property (nonatomic,strong) UIView *superView;
@property (nonatomic,weak) id<HNBNetRemindViewDelegate> delegate;
@property (nonatomic,strong) UIButton *tipBtn;
@property (nonatomic,strong) UIButton *labelBtn;

@end

@implementation HNBNetRemindView

#pragma mark ------ 初始化界面

-(void)loadWithFrame:(CGRect)frame superView:(UIView *)superV showType:(HNBNetRemindViewShowType)showType delegate:(id<HNBNetRemindViewDelegate>)delegate
{
   
        [self setFrame:frame];
        self.tag = showType; // 用于标示三类布局
        _superView = superV;
        _delegate = delegate;
        [superV addSubview:self];
    
        switch (showType) {
            case HNBNetRemindViewShowPoorNet:
            {
                [self setUpShowPoorNetViewWithFrame:frame];
            }
                break;
            case HNBNetRemindViewShowFailNetReq:
            {
                [self setUpShowFailNetReqViewWithFrame:frame];
            }
                break;
            case HNBNetRemindViewShowFailReleatedData:
            {
                [self setUpFailReleatedDataViewWithFrame:frame];
            }
                break;
            case HNBNetRemindViewShowFailToShowTip:
            {
                [self setUpFailToShowTipViewWithFrame:frame];
            }
                break;
                
            default:
                break;
        }
    self.isStatus = TRUE;
}

// 无网络状况
- (void)setUpShowPoorNetViewWithFrame:(CGRect)rect{

//    NSString *tmpmsg = @"网络不给力，点击重试";
    NSString *tmpmsg = @"网络不给力，请检查网络设置后重试";
    
    //[self setUpFailNetViewWith:rect title:tmpmsg];
    [self setUpUIPoorNetViewWith:rect title:tmpmsg];
    
}

// 请求失败状况
- (void)setUpShowFailNetReqViewWithFrame:(CGRect)rect{
    
    NSString *tmpmsg = @"加载失败，点击重试";
    [self setUpUIFailNetViewWith:rect title:tmpmsg];
}

// 没有请求到相关数据
- (void)setUpFailReleatedDataViewWithFrame:(CGRect)rect{
    
    [self setUpUIFailReleatedDataViewWith:rect];
}

- (void)setUpFailToShowTipViewWithFrame:(CGRect)rect{

    self.backgroundColor = [UIColor whiteColor];
    CGRect tmpRect = CGRectZero;
    tmpRect.size.height = 30.0;
    tmpRect.size.width = rect.size.width;
    tmpRect.origin.y = rect.size.height / 2.0 - tmpRect.size.height;
    tmpRect.origin.x = 0;
    _labelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_labelBtn setFrame:tmpRect];
    [_labelBtn addTarget:self action:@selector(reqNetErrorButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:_labelBtn];
    
}

#pragma mark ------ set up UI

- (void)setUpUIPoorNetViewWith:(CGRect)rect title:(NSString *)title{
    
    _tipBtn = [[UIButton alloc] init];
    [self addSubview:_tipBtn];
    UILabel *label = [[UILabel alloc] init];
    [self addSubview:label];
    UIButton *labelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:labelBtn];
    UILabel *mesLabel = [[UILabel alloc] init];
    [self addSubview:mesLabel];
    
    CGFloat imgWH = 100.f * SCREEN_SCALE;
    CGFloat labelOneH = 30.f * SCREEN_SCALE;
    CGFloat gap = 12.f * SCREEN_SCALE;
    CGFloat y_offset = gap + imgWH; // Y 方向上图片中心向上偏离父视图中心
    mesLabel.numberOfLines = 0;
    mesLabel.font = [UIFont systemFontOfSize:FONT_UI24PX];
    mesLabel.textColor = [UIColor DDR153_G153_B153ColorWithalph:1.f];//[UIColor colorWithRed:170.0/255.0f green:170.0/255.0f blue:170.0/255.0f alpha:1.0f];
    [mesLabel setFrame:CGRectMake(0, 0, SCREEN_WIDTH - 8 * gap, 0)];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"可能原因如下:"];
    [text appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n"]];
    [text appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"1）海那边APP网络被关闭，请前往设置-无线局域网打开"]];
    [text appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n"]];
    [text appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"2）未启用 Wi-Fi 网络/移动网络"]];
    mesLabel.attributedText = text;
    [mesLabel sizeToFit];
    
    _tipBtn.sd_layout
    .centerYIs(rect.size.height/2.f - y_offset)
    .centerXIs(rect.size.width/2.f)
    .widthIs(imgWH)
    .heightIs(imgWH);
    
    label.sd_layout
    .leftSpaceToView(self,gap * 4.f)
    .rightSpaceToView(self,gap)
    .topSpaceToView(_tipBtn,gap)
    .heightIs(labelOneH);
    
    labelBtn.sd_layout
    .rightSpaceToView(self,0)
    .widthIs(120.f * SCREEN_SCALE)
    .heightRatioToView(label,1.f)
    .centerYEqualToView(label);
    
    mesLabel.sd_layout
    .topSpaceToView(label,gap * 2.f)
    .leftSpaceToView(self,gap * 4.f)
    .rightSpaceToView(self,gap * 4.f)
    .heightIs(mesLabel.frame.size.height);
    
    self.backgroundColor = [UIColor whiteColor];
    
    
    [_tipBtn addTarget:self action:@selector(reqNetErrorButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [labelBtn addTarget:self action:@selector(reqNetErrorButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [_tipBtn setBackgroundImage:[UIImage imageNamed:@"loading_net"] forState:UIControlStateNormal];
    label.attributedText = [self yh_changeColorWithColor:[UIColor DDNavBarBlue] totalString:title subStringArray:@[@"重试"]];

//    _tipBtn.backgroundColor = [UIColor redColor];
//    label.backgroundColor = [UIColor greenColor];
//    labelBtn.backgroundColor = [UIColor yellowColor];
//    mesLabel.backgroundColor = [UIColor purpleColor];
    
}

- (void)setUpUIFailNetViewWith:(CGRect)rect title:(NSString *)title{

    self.backgroundColor = [UIColor whiteColor];
    CGFloat verticalGap = 10.0;
    CGRect tmpRect = CGRectZero;
    tmpRect.size.width = 100.0;
    tmpRect.size.height = 100.0;
    tmpRect.origin.x = rect.size.width / 2.0 - tmpRect.size.width / 2.0;
    tmpRect.origin.y = rect.size.height / 2.0 - verticalGap / 2.0 - tmpRect.size.height;
    _tipBtn = [[UIButton alloc] initWithFrame:tmpRect];
    [_tipBtn addTarget:self action:@selector(reqNetErrorButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    tmpRect.size.width = rect.size.width;
    tmpRect.size.height = 30.0;
    tmpRect.origin.y = rect.size.height / 2.0 + verticalGap / 2.0;
    tmpRect.origin.x = 0;
    _labelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_labelBtn setFrame:tmpRect];
    [_labelBtn addTarget:self action:@selector(reqNetErrorButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [_tipBtn setBackgroundImage:[UIImage imageNamed:@"loading_net"] forState:UIControlStateNormal];
    [_labelBtn setAttributedTitle:[self yh_changeColorWithColor:[UIColor DDNavBarBlue] totalString:title subStringArray:@[@"点击"]] forState:UIControlStateNormal]; // // #25B6ED
    
    [self addSubview:_tipBtn];
    [self addSubview:_labelBtn];
    
}


- (void)setUpUIFailReleatedDataViewWith:(CGRect)rect{

    self.backgroundColor = [UIColor whiteColor];
    CGFloat verticalGap = 10.0;
    CGRect tmpRect = CGRectZero;
    tmpRect.size.width = 100.0;
    tmpRect.size.height = 100.0;
    tmpRect.origin.x = rect.size.width / 2.0 - tmpRect.size.width / 2.0;
    tmpRect.origin.y = rect.size.height / 2.0 - verticalGap / 2.0 - tmpRect.size.height;
    _tipBtn = [[UIButton alloc] initWithFrame:tmpRect];
    [_tipBtn addTarget:self action:@selector(reqNetErrorButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    tmpRect.size.width = rect.size.width;
    tmpRect.size.height = 30.0;
    tmpRect.origin.y = rect.size.height / 2.0 + verticalGap / 2.0;
    tmpRect.origin.x = 0;
    UILabel *tipmsgLabel = [[UILabel alloc] initWithFrame:tmpRect];
    tipmsgLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:FONT_UI28PX];
    tipmsgLabel.textColor = [UIColor colorWithRed:170.0/255.0f green:170.0/255.0f blue:170.0/255.0f alpha:1.0f];
    tipmsgLabel.textAlignment = NSTextAlignmentCenter;
    tmpRect.origin.y = CGRectGetMaxY(tipmsgLabel.frame) + 5.0;
    _labelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_labelBtn setFrame:tmpRect];
    [_labelBtn addTarget:self action:@selector(reqNetErrorButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    tmpRect.origin.x = 0.0;
    tmpRect.origin.y = 0.0;
    UIButton *labelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [labelBtn setFrame:tmpRect];
    [labelBtn addTarget:self action:@selector(reqNetErrorButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [_tipBtn setBackgroundImage:[UIImage imageNamed:@"loading_net"] forState:UIControlStateNormal];
    [tipmsgLabel setText:@"未找到相关内容"];
    NSString *tmpmsg = @"我来提问";
    NSMutableAttributedString *msg = [[NSMutableAttributedString alloc] initWithString:tmpmsg];
    [msg addAttributes:@{
                         NSForegroundColorAttributeName:[UIColor DDNavBarBlue], // #25B6ED
                         NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:FONT_UI28PX]
                         }
                 range:NSMakeRange(0, tmpmsg.length)];
    [_labelBtn setAttributedTitle:msg forState:UIControlStateNormal];
    
    [self addSubview:_tipBtn];
    [self addSubview:tipmsgLabel];
    [self addSubview:_labelBtn];
    
}

#pragma mark ------ method

// 单纯改变文本中部分字符颜色 NSExpansionAttributeName:@(0.15)
- (NSMutableAttributedString *)yh_changeColorWithColor:(UIColor *)color totalString:(NSString *)totalStr subStringArray:(NSArray *)subArray{
    // [UIFont fontWithName:@"Helvetica-Bold" size:FONT_UI28PX]
    NSMutableAttributedString *tmpString = [[NSMutableAttributedString alloc] initWithString:totalStr];
    [tmpString addAttributes:@{
                         NSForegroundColorAttributeName:[UIColor DDR153_G153_B153ColorWithalph:1.f],
                         NSFontAttributeName:[UIFont systemFontOfSize:FONT_UI28PX],
                         }
                 range:NSMakeRange(0, totalStr.length)];
    for (NSString *s in subArray) {
        NSRange r = [totalStr rangeOfString:s options:NSBackwardsSearch];
        [tmpString addAttribute:NSForegroundColorAttributeName value:color range:r];
        [tmpString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:FONT_UI32PX] range:r];
    }
    return tmpString;
}


- (void)setTipWithMsg:(NSString *)title subStringArray:(NSArray *)subs{

    [_labelBtn setAttributedTitle:[self yh_changeColorWithColor:[UIColor DDNavBarBlue] totalString:title subStringArray:subs] forState:UIControlStateNormal];
    
}

#pragma mark ------ clickEvent 

- (void)reqNetErrorButtonPressed:(UIButton *)btn{

    if (_delegate && [_delegate respondsToSelector:@selector(clickOnNetRemindView:)]) {
        [_delegate clickOnNetRemindView:self];
        self.isStatus = FALSE;
    }
    
}

@end
