//
//  ChatTableCell.m
//  LXYHOCFunctionsDemo
//
//  Created by wyh on 15/11/27.
//  Copyright © 2015年 lachesismh. All rights reserved.
//

#import "ChatTableCell.h"
#import "MessageObj.h"

@interface ChatTableCell ()
{
    UIButton *timeBtn;
    UIImageView *iconImgView;
    UIButton *contentBtn;
}
@end

@implementation ChatTableCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        timeBtn.titleLabel.font = kTimeFont;
        [timeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [timeBtn setBackgroundImage:[UIImage imageNamed:@"chat_timeline_bg"] forState:UIControlStateNormal];
        [self addSubview:timeBtn];
        
        iconImgView = [[UIImageView alloc] init];
        [self addSubview:iconImgView];
        
        contentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [contentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        contentBtn.titleLabel.numberOfLines = 0;
        contentBtn.titleLabel.font = kContentFont;
        [self addSubview:contentBtn];
        
//        timeBtn.backgroundColor = [UIColor redColor];
//        iconImgView.backgroundColor = [UIColor greenColor];
//        contentBtn.backgroundColor = [UIColor blueColor];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
    
}

-(void)setMsgManager:(MessageManager *)msgManager{

    _msgManager = msgManager;
    MessageObj *msgObj = _msgManager.msgObj;
    
    [timeBtn setTitle:msgObj.time forState:UIControlStateNormal];
    [timeBtn setFrame:_msgManager.timeF];
    [iconImgView setImage:[UIImage imageNamed:msgObj.iconName]];
    [iconImgView setFrame:_msgManager.iconF];
    [contentBtn setTitle:msgObj.msgContent forState:UIControlStateNormal];
    [contentBtn setFrame:msgManager.contentF];
    [contentBtn setContentEdgeInsets:UIEdgeInsetsMake(kContentTop, kContentLeft, kContentBottom, kContentRight)];
    if (msgObj.msgType == MsgTypeMe) {
    [contentBtn setContentEdgeInsets:UIEdgeInsetsMake(kContentTop, kContentRight, kContentBottom, kContentLeft)];
    }
    UIImage *normal , *focused;
    if (msgObj.msgType == MsgTypeMe) {
        normal = [UIImage imageNamed:@"chatto_bg_normal.png"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        focused = [UIImage imageNamed:@"chatto_bg_focused.png"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
    }else{
        normal = [UIImage imageNamed:@"chatfrom_bg_normal.png"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.7];
        focused = [UIImage imageNamed:@"chatfrom_bg_focused.png"];
        focused = [focused stretchableImageWithLeftCapWidth:focused.size.width * 0.5 topCapHeight:focused.size.height * 0.7];
    }
    [contentBtn setBackgroundImage:normal forState:UIControlStateNormal];
    [contentBtn setBackgroundImage:focused forState:UIControlStateHighlighted];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
