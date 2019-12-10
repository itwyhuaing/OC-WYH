//
//  JSEditorToolBar.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/12/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "JSEditorToolBar.h"


@interface JSEditorToolBar ()

@property (nonatomic,strong) UIImageView        *keyImageView;
@property (nonatomic,strong) UIScrollView       *toolBarScroll;

/**rain
 * 功能区按钮
 */
@property (nonatomic,strong) UIButton *imageFromDeviceBtn;
@property (nonatomic,strong) UIButton *boldBtn;                 // 粗体
@property (nonatomic,strong) UIButton *italicBtn;               // 斜体
@property (nonatomic,strong) UIButton *strikeThroughBtn;        // 删除线
@property (nonatomic,strong) UIButton *h1Btn;                   // 1 号字体
@property (nonatomic,strong) UIButton *h2Btn;                   // 2 号字体
@property (nonatomic,strong) UIButton *h3Btn;                   // 3 号字体
@property (nonatomic,strong) UIButton *h4Btn;                   // 4 号字体

@end

@implementation JSEditorToolBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createToolBar];
    }
    return self;
}

- (void)createToolBar {
    // alloc
    self.keyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                      0,
                                                                      TOOL_BAR_HEIGHT,
                                                                      TOOL_BAR_HEIGHT)];
    
    self.toolBarScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.keyImageView.frame),
                                                                        0,
                                                                        CGRectGetWidth(self.frame) - CGRectGetWidth(self.keyImageView.frame),
                                                                        TOOL_BAR_HEIGHT)];
    // 属性设置
    NSString *tmpImgName = @"ZSSkeyboard_down.png";
    self.keyImageView.image = [UIImage imageNamed:tmpImgName];
    self.keyImageView.contentMode = UIViewContentModeScaleAspectFill;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyBoardOperator)];
    self.keyImageView.userInteractionEnabled = YES;
    [self.keyImageView addGestureRecognizer:tap];
    
    // 描边
    self.layer.borderWidth = 0.3;
    self.layer.borderColor = [UIColor colorWithRed:201.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1.0].CGColor;
    
    // 层级
    [self addSubview:self.keyImageView];
    [self addSubview:self.toolBarScroll];
    
    // 功能按钮
    [self addFunctionBtnItem];
    
    // 测试
    self.backgroundColor = [UIColor cyanColor];
    self.toolBarScroll.backgroundColor = [UIColor redColor];
    self.keyImageView.backgroundColor = [UIColor purpleColor];
}


- (void)addFunctionBtnItem {
    NSArray *imgNames = @[@"ZSSimageFromDevice.png",@"ZSSbold.png",@"ZSSitalic.png",
                          @"ZSSstrikethrough.png",@"ZSSh1.png",@"ZSSh2.png",@"ZSSh3.png",@"ZSSh4.png"];
    CGFloat funSize_w = (CGRectGetWidth(self.frame) - CGRectGetWidth(self.keyImageView.frame)
                         - imgNames.count * 10.0)/imgNames.count;
    CGRect rect = CGRectZero;
    rect.size = CGSizeMake(funSize_w, 44.0);
    rect.origin.x = 10;
    _imageFromDeviceBtn = [self createButtonWithFrame:rect imgName:@"ZSSimageFromDevice.png"];
    [_imageFromDeviceBtn addTarget:self action:@selector(insertImageFromDevice:) forControlEvents:UIControlEventTouchUpInside];
    
    rect.origin.x = CGRectGetMaxX(_imageFromDeviceBtn.frame) + 10.0;
    _boldBtn = [self createButtonWithFrame:rect imgName:@"ZSSbold.png"];
    [_boldBtn addTarget:self action:@selector(setBold:) forControlEvents:UIControlEventTouchUpInside];
    
    rect.origin.x = CGRectGetMaxX(_boldBtn.frame) + 10.0;
    _italicBtn = [self createButtonWithFrame:rect imgName:@"ZSSitalic.png"];
    [_italicBtn addTarget:self action:@selector(setItalic:) forControlEvents:UIControlEventTouchUpInside];
    
    rect.origin.x = CGRectGetMaxX(_italicBtn.frame) + 10.0;
    _strikeThroughBtn = [self createButtonWithFrame:rect imgName:@"ZSSstrikethrough.png"];
    [_strikeThroughBtn addTarget:self action:@selector(setStrikethrough:) forControlEvents:UIControlEventTouchUpInside];
    
    rect.origin.x = CGRectGetMaxX(_strikeThroughBtn.frame) + 10.0;
    _h1Btn = [self createButtonWithFrame:rect imgName:@"ZSSh1.png"];
    [_h1Btn addTarget:self action:@selector(heading1:) forControlEvents:UIControlEventTouchUpInside];
    
    rect.origin.x = CGRectGetMaxX(_h1Btn.frame) + 10.0;
    _h2Btn = [self createButtonWithFrame:rect imgName:@"ZSSh2.png"];
    [_h2Btn addTarget:self action:@selector(heading2:) forControlEvents:UIControlEventTouchUpInside];
    
    rect.origin.x = CGRectGetMaxX(_h2Btn.frame) + 10.0;
    _h3Btn = [self createButtonWithFrame:rect imgName:@"ZSSh3.png"];
    [_h3Btn addTarget:self action:@selector(heading3:) forControlEvents:UIControlEventTouchUpInside];
    
    rect.origin.x = CGRectGetMaxX(_h3Btn.frame) + 10.0;
    _h4Btn = [self createButtonWithFrame:rect imgName:@"ZSSh4.png"];
    [_h4Btn addTarget:self action:@selector(heading4:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (UIButton *)createButtonWithFrame:(CGRect)rect imgName:(NSString *)imgName{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [btn setFrame:rect];
    [self.toolBarScroll addSubview:btn];
    btn.backgroundColor = [UIColor colorWithRed:(arc4random()%200)/255.0 green:(arc4random()%200)/255.0 blue:(arc4random()%200)/255.0 alpha:1.0];
    return btn;
}


- (void)updateToolBarWithButtonName:(NSString *)name {
    
    // Items that are enabled
    NSArray *itemNames = [name componentsSeparatedByString:@","];
    
    for (NSInteger cou = 0;cou < itemNames.count;cou ++) {
        if([itemNames containsObject:@"strikeThrough"]){
            [_strikeThroughBtn setImage:[UIImage imageNamed:@"ZSSstrikethrough_selected.png"] forState:UIControlStateNormal];
        }else{
            [_strikeThroughBtn setImage:[UIImage imageNamed:@"ZSSstrikethrough.png"] forState:UIControlStateNormal];
        }

        if([itemNames containsObject:@"bold"]){
            [_boldBtn setImage:[UIImage imageNamed:@"ZSSbold_selected.png"] forState:UIControlStateNormal];
        }else{
            [_boldBtn setImage:[UIImage imageNamed:@"ZSSbold.png"] forState:UIControlStateNormal];
        }

        if([itemNames containsObject:@"italic"]){
            [_italicBtn setImage:[UIImage imageNamed:@"ZSSitalic_selected.png"] forState:UIControlStateNormal];
        }else{
            [_italicBtn setImage:[UIImage imageNamed:@"ZSSitalic.png"] forState:UIControlStateNormal];
        }

        if([itemNames containsObject:@"h1"]){
            [_h1Btn setImage:[UIImage imageNamed:@"ZSSh1_selected.png"] forState:UIControlStateNormal];
        }else{
            [_h1Btn setImage:[UIImage imageNamed:@"ZSSh1.png"] forState:UIControlStateNormal];
        }

        if([itemNames containsObject:@"h2"]){
            [_h2Btn setImage:[UIImage imageNamed:@"ZSSh2_selected.png"] forState:UIControlStateNormal];
        }else{
            [_h2Btn setImage:[UIImage imageNamed:@"ZSSh2.png"] forState:UIControlStateNormal];
        }

        if([itemNames containsObject:@"h3"]){
            [_h3Btn setImage:[UIImage imageNamed:@"ZSSh3_selected.png"] forState:UIControlStateNormal];
        }else{
            [_h3Btn setImage:[UIImage imageNamed:@"ZSSh3.png"] forState:UIControlStateNormal];
        }

        if([itemNames containsObject:@"h4"]){
            [_h4Btn setImage:[UIImage imageNamed:@"ZSSh4_selected.png"] forState:UIControlStateNormal];
        }else{
            [_h4Btn setImage:[UIImage imageNamed:@"ZSSh4.png"] forState:UIControlStateNormal];
        }
        
    }
    
}

-(void)insertImageFromDevice:(UIButton *)btn{
    OperateIntention intention = btn.selected ? OperateIntentionON : OperateIntentionOFF;
    self.toolBarBlk ? self.toolBarBlk(JSEditorToolBarInsertImage, intention) : nil;
    btn.selected = !btn.selected;
}

-(void)setBold:(UIButton *)btn{
    OperateIntention intention = btn.selected ? OperateIntentionON : OperateIntentionOFF;
    self.toolBarBlk ? self.toolBarBlk(JSEditorToolBarBold, intention) : nil;
    btn.selected = !btn.selected;
}

-(void)setItalic:(UIButton *)btn{
    OperateIntention intention = btn.selected ? OperateIntentionON : OperateIntentionOFF;
    self.toolBarBlk ? self.toolBarBlk(JSEditorToolBarItalic, intention) : nil;
    btn.selected = !btn.selected;
}

-(void)setStrikethrough:(UIButton *)btn{
    OperateIntention intention = btn.selected ? OperateIntentionON : OperateIntentionOFF;
    self.toolBarBlk ? self.toolBarBlk(JSEditorToolBarStrikethrough, intention) : nil;
    btn.selected = !btn.selected;
}

-(void)heading1:(UIButton *)btn{
    OperateIntention intention = btn.selected ? OperateIntentionON : OperateIntentionOFF;
    self.toolBarBlk ? self.toolBarBlk(JSEditorToolBarH1, intention) : nil;
    btn.selected = !btn.selected;
}

-(void)heading2:(UIButton *)btn{
    OperateIntention intention = btn.selected ? OperateIntentionON : OperateIntentionOFF;
    self.toolBarBlk ? self.toolBarBlk(JSEditorToolBarH2, intention) : nil;
    btn.selected = !btn.selected;
}

-(void)heading3:(UIButton *)btn{
    OperateIntention intention = btn.selected ? OperateIntentionON : OperateIntentionOFF;
    self.toolBarBlk ? self.toolBarBlk(JSEditorToolBarH3, intention) : nil;
    btn.selected = !btn.selected;
}

-(void)heading4:(UIButton *)btn{
    OperateIntention intention = btn.selected ? OperateIntentionON : OperateIntentionOFF;
    self.toolBarBlk ? self.toolBarBlk(JSEditorToolBarH4, intention) : nil;
    btn.selected = !btn.selected;
}

- (void)keyBoardOperator {
    self.toolBarBlk ? self.toolBarBlk(JSEditorToolBarKeyBaord, OperateIntentionOther) : nil;
}

@end
