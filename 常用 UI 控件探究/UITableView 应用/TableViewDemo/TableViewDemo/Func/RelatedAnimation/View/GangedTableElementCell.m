//
//  GangedTableElementCell.m
//  TableViewDemo
//
//  Created by hnbwyh on 2018/11/12.
//  Copyright © 2018年 TongXin. All rights reserved.
//

#import "GangedTableElementCell.h"
#import "GangedTableModel.h"

//测试
#import "SDAutoLayout.h"

// 初始化时设置的d item 最大个数
#define kMaxItemCount   10

@interface GangedTableElementCell ()
@property (nonatomic,strong)        UILabel                 *themLabel;
@property (nonatomic,strong)        UIView                  *container;
@property (nonatomic,strong)        NSMutableArray          *itemLabels;

@end

@implementation GangedTableElementCell


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
    [self setupAutoHeightWithBottomView:self.container bottomMargin:20.0];
    self.themLabel.hidden = TRUE;
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

-(NSMutableArray *)itemLabels{
    if (!_itemLabels) {
        _itemLabels = [[NSMutableArray alloc] init];
        for (NSInteger cou = 0; cou < kMaxItemCount; cou ++) {
            [_itemLabels addObject:[self createLabel]];
        }
    }
    return _itemLabels;
}

#pragma mark --- set data

-(void)setElementData:(ElementModel *)elementData{
    if (![elementData isEqual:_elementData]) {
        _elementData = elementData;
        self.themLabel.hidden       = FALSE;
        self.themLabel.text         = elementData.them;
        NSMutableArray *views = [NSMutableArray new];
        for (NSInteger cou = 0; cou < elementData.items.count; cou ++) {
            ItemModel *f = elementData.items[cou];
            UILabel *l = (cou > kMaxItemCount - 1) ? [self createLabel] : self.itemLabels[cou];
            l.text = f.cnt;
            [self.container addSubview:l];
            [views addObject:l];
            l.sd_layout.heightIs(60);
        }
        [self.container setupAutoWidthFlowItems:views withPerRowItemsCount:2 verticalMargin:10 horizontalMargin:10 verticalEdgeInset:10 horizontalEdgeInset:10];
    }
}

@end

