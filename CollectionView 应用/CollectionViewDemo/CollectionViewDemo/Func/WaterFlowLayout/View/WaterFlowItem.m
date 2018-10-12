
//
//  WaterFlowItem.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/9/29.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "WaterFlowItem.h"
#import "WaterFlowModel.h"

@interface WaterFlowItem ()

@property (nonatomic,strong)            UILabel             *cntlabel;

@end


@implementation WaterFlowItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI{
    [self.contentView addSubview:self.cntlabel];
}

-(void)setDataModel:(WaterFlowModel *)dataModel{
    _dataModel                          =  dataModel;
    self.cntlabel.text                  = dataModel.cntText;
    self.cntlabel.backgroundColor       = [UIColor redColor];
}

-(UILabel *)cntlabel{
    if (!_cntlabel) {
        _cntlabel               = [UILabel new];
        _cntlabel.font          = [UIFont systemFontOfSize:13.0];
        _cntlabel.textColor     = [UIColor blackColor];
    }
    return _cntlabel;
}

-(void)layoutSubviews{
    [self.cntlabel setFrame:self.bounds];
}

@end
