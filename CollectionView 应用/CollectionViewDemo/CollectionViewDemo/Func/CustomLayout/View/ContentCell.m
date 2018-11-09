//
//  ContentCell.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/11/9.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "ContentCell.h"
#import "SDAutoLayout.h"

@interface ContentCell ()
@property (nonatomic,strong)        UILabel     *themLabel;
@property (nonatomic,strong)        UIView      *container;
@end

@implementation ContentCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configUI{
    [self.contentView addSubview:self.themLabel];
    [self.contentView addSubview:self.container];
    
    
    self.themLabel.text = @"标题";
    self.themLabel.backgroundColor = [UIColor greenColor];
    self.container.backgroundColor = [UIColor purpleColor];
    
    self.themLabel.sd_layout
    .leftSpaceToView(self.contentView, 10.0)
    .topSpaceToView(self.contentView, 10.0)
    .rightSpaceToView(self.contentView, 10.0)
    .heightIs(56.0);
    self.container.sd_layout
    .leftSpaceToView(self.contentView, 10.0)
    .rightSpaceToView(self.contentView, 10.0)
    .topSpaceToView(self.themLabel, 10.0)
    .heightIs(130.0);
    [self setupAutoHeightWithBottomView:self.container bottomMargin:10.0];
    self.themLabel.hidden = TRUE;
}

-(void)setDatas:(NSArray *)datas{
    if (datas) {
//        self.themLabel.hidden = FALSE;
//        NSMutableArray *views = [NSMutableArray new];
//        for (NSInteger cou = 0; cou < datas.count; cou ++) {
//            UILabel *l = [self createLabel];
//            l.text = datas[cou];
//            [self.container addSubview:l];
//            [views addObject:l];
//            l.sd_layout.heightIs(60);
//        }
//        [self.container setupAutoWidthFlowItems:views withPerRowItemsCount:2 verticalMargin:10 horizontalMargin:10 verticalEdgeInset:0 horizontalEdgeInset:0];
    }
}

- (UILabel *)createLabel{
    UILabel *l = [[UILabel alloc] init];
    l.font = [UIFont systemFontOfSize:16.0];
    l.textColor = [UIColor blackColor];
    l.backgroundColor = [UIColor cyanColor];
    l.numberOfLines = 0;
    return l;
}

-(UILabel *)themLabel{
    if (!_themLabel) {
        _themLabel = [[UILabel alloc] init];
        _themLabel.textColor           = [UIColor blackColor];
        _themLabel.font                = [UIFont systemFontOfSize:13.0];
        _themLabel.textAlignment       = NSTextAlignmentCenter;
    }
    return _themLabel;
}

-(UIView *)container{
    if (!_container) {
        _container = [[UIView alloc] init];
    }
    return _container;
}


@end
