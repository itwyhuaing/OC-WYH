//
//  TesTypeOneASCell.m
//  ASDKProjectDemo
//
//  Created by hnbwyh on 17/7/10.
//  Copyright © 2017年 hainbwyh. All rights reserved.
//

#import "TesTypeOneASCell.h"

@interface TesTypeOneASCell ()

@property (nonatomic,strong) ASImageNode *imgNode;
@property (nonatomic,strong) ASTextNode *titleNode;
@property (nonatomic,strong) ASTextNode *briefInfoNode;
@property (nonatomic,strong) ASTextNode *dateNode;
@property (nonatomic,strong) UIImageView *imgV;

@property (nonatomic,strong) ASDisplayNode *underLine;

@end

@implementation TesTypeOneASCell

-(instancetype)initWithDataModel:(BaseDataModel *)dataModel{

    self = [super initWithDataModel:dataModel];
    if (self) {
        
        [self addImgNode];
        [self addTitleNode];
        [self addBriefInfoNode];
        [self addDateNode];
        [self addUnderLine];

        
    }
    return self;
    
}

-(void)didLoad{
    [super didLoad];
    [self addImgView];
}

#pragma mark ------ add node - imgv

- (void)addImgNode{
    
    ASImageNode *imgN = [[ASImageNode alloc] init];
    imgN.layerBacked = YES;
    [self addSubnode:imgN];
    _imgNode = imgN;
    
}

- (void)addTitleNode{
    
    ASTextNode *titleN = [[ASTextNode alloc] init];
    titleN.layerBacked = YES;
    titleN.placeholderEnabled = YES;
    titleN.placeholderColor = [UIColor redColor];
    NSDictionary *at = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0],NSForegroundColorAttributeName:[UIColor colorWithRed:155/255 green:155/255 blue:155/255 alpha:1.0]};
    titleN.attributedString = [[NSAttributedString alloc] initWithString:@"测试文本1，测试文本2，测试文本3，测试文本4，测试文本5，测试文本6" attributes:at];
    [self addSubnode:titleN];
    _titleNode = titleN;
    
}

- (void)addBriefInfoNode{
    
    ASTextNode *tN = [[ASTextNode alloc] init];
    tN.layerBacked = YES;
    tN.placeholderEnabled = YES;
    tN.placeholderColor = [UIColor redColor];
    NSDictionary *at = @{NSFontAttributeName:[UIFont systemFontOfSize:12.0],NSForegroundColorAttributeName:[UIColor colorWithRed:155/255 green:155/255 blue:155/255 alpha:1.0]};
    tN.attributedString = [[NSAttributedString alloc] initWithString:@"虎妞在纽约" attributes:at];
    [self addSubnode:tN];
    _briefInfoNode = tN;
    
}

- (void)addDateNode{
    
    ASTextNode *tN = [[ASTextNode alloc] init];
    tN.layerBacked = YES;
    tN.placeholderEnabled = YES;
    tN.placeholderColor = [UIColor redColor];
    NSDictionary *at = @{NSFontAttributeName:[UIFont systemFontOfSize:12.0],NSForegroundColorAttributeName:[UIColor colorWithRed:155/255 green:155/255 blue:155/255 alpha:1.0]};
    tN.attributedString = [[NSAttributedString alloc] initWithString:@"2017年7月10日" attributes:at];
    [self addSubnode:tN];
    _dateNode = tN;
    
}

- (void)addUnderLine{
    
    ASDisplayNode *underLine = [[ASDisplayNode alloc] init];
    underLine.layerBacked = YES;
    underLine.backgroundColor = [UIColor colorWithRed:233/255 green:233/255 blue:233/255 alpha:1.0];
    [self addSubnode:underLine];
    _underLine = underLine;
    
}

- (void)addImgView{
    
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"image.png"];
    [self.view addSubview:imgView];
    _imgV = imgView;
    
}

#pragma mark ------ 设置尺寸

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize{
    
//    _titleNode.backgroundColor = [UIColor redColor];
//    _imgNode.backgroundColor = [UIColor greenColor];
//    _briefInfoNode.backgroundColor = [UIColor yellowColor];
//    _dateNode.backgroundColor = [UIColor orangeColor];
    
    _titleNode.flexShrink = YES;
    _imgNode.preferredFrameSize = CGSizeMake(80, 80);
    _underLine.preferredFrameSize = CGSizeMake(constrainedSize.max.width, 0.5);
    
    ASLayoutSpec *h1 = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                               spacing:10
                                                        justifyContent:ASStackLayoutJustifyContentStart alignItems:ASStackLayoutAlignItemsCenter children:@[_briefInfoNode,_dateNode]];
    
    ASStackLayoutSpec *v1 = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                    spacing:0
                                                             justifyContent:ASStackLayoutJustifyContentSpaceBetween
                                                                 alignItems:ASStackLayoutAlignItemsStart
                                                                   children:@[_titleNode,h1]];
    v1.flexShrink = YES;
    
    ASStackLayoutSpec *h2 = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionHorizontal
                                                                    spacing:10
                                                             justifyContent:ASStackLayoutJustifyContentStart
                                                                 alignItems:ASStackLayoutAlignItemsStretch
                                                                   children:@[_imgNode,v1]];
    
    ASInsetLayoutSpec *inset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(10, 10, 10, 10) child:h2];
    
    ASStackLayoutSpec *v2 = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                    spacing:0
                                                             justifyContent:ASStackLayoutJustifyContentEnd
                                                                 alignItems:ASStackLayoutAlignItemsCenter
                                                                   children:@[inset,_underLine]];
    
    
    return v2;
}

-(void)layout{
    
    [super layout];
    _imgV.frame = _imgNode.frame;
    
}

@end
