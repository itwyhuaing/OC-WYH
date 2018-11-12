//
//  GangedTable.m
//  TableViewDemo
//
//  Created by hnbwyh on 2018/11/12.
//  Copyright © 2018年 TongXin. All rights reserved.
//

#import "GangedTable.h"
#import "GangedTableBar.h"
#import "GangedTableElementCell.h"
#import "GangedTableModel.h"

//测试
#import "SDAutoLayout.h"

// section
typedef enum : NSUInteger {
    GangedTableSection0 = 0,
    GangedTableSection1,
    GangedTableSectionCount,
} GangedTableSection;


@interface GangedTable () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,GangedTableBarDelegate>

@property (nonatomic,strong)    UIView                 *blankHeader;
@property (nonatomic,strong)    GangedTableBar        *gtTabBar;

@end


@implementation GangedTable

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self configGangedTable];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configGangedTable];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self configGangedTable];
    }
    return self;
}

- (void)configGangedTable{
    self.backgroundColor = [UIColor whiteColor];
    self.delegate        = (id)self;
    self.dataSource      = (id)self;
    [self registerClass:[GangedTableElementCell class] forCellReuseIdentifier:NSStringFromClass(GangedTableElementCell.class)];
    if(@available(iOS 11.0,*)){
        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

#pragma mark ------ UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return GangedTableSectionCount;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 1;
    if (section == GangedTableSection1) {
        rows = self.dataModel.elements.count;
    }
    return rows;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *hv = self.blankHeader;
    if (section == GangedTableSection1) {
        hv = self.gtTabBar;
    }
    return hv;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 0;
    if (section == GangedTableSection1) {
        height = CGRectGetHeight(self.gtTabBar.frame);
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = 0.0;
    if (indexPath.section <= GangedTableSection0) {
        cellHeight = self.gtableHeader ? CGRectGetHeight(self.gtableHeader.frame) : 0.0;
    } else if (indexPath.section == GangedTableSection1){
        cellHeight = [tableView cellHeightForIndexPath:indexPath model:self.dataModel.elements[indexPath.row] keyPath:@"elementData" cellClass:[GangedTableElementCell class] contentViewWidth:[self cellContentViewWith]];
    }
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *returnCell;
    if (indexPath.section <= 0) {
        returnCell = [[UITableViewCell alloc] init];
    } else {
        GangedTableElementCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(GangedTableElementCell.class)];
        cell.elementData = self.dataModel.elements[indexPath.row];
        returnCell = cell;
    }
    
    returnCell.layer.borderWidth = 0.6;
    returnCell.layer.borderColor = [UIColor grayColor].CGColor;
    
    return returnCell;
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}


#pragma mark ------ UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint targetPoint = scrollView.contentOffset;
    targetPoint.y       += 60;
    NSIndexPath *idx = [self indexPathForRowAtPoint:targetPoint];
    [self.gtTabBar gangedTableBarScrollToItemAtIndexPath:idx];
    NSLog(@"\n scrollViewDidScroll 偏移:%ld \n",idx.row);
}

#pragma mark ------ GangedTableBarDelegate

-(void)gangedTableBar:(GangedTableBar *)bar didSelectedAtIndexPath:(NSIndexPath *)index{
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index.row inSection:GangedTableSection1]
                atScrollPosition:UITableViewScrollPositionTop
                        animated:FALSE];
}


#pragma mark ------ set data

-(void)setDataModel:(GangedTableModel *)dataModel{
    if (![dataModel isEqual:_dataModel]) {
        _dataModel = dataModel;
        self.gtTabBar.thems = dataModel.barThems;
        [self reloadData];
    }
}

#pragma mark ------ click evnent


#pragma mark ------ lazy load

-(UIView *)blankHeader{
    if (!_blankHeader) {
        _blankHeader = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _blankHeader;
}

-(GangedTableBar *)gtTabBar{
    if (!_gtTabBar) {
        _gtTabBar = [[GangedTableBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 30.0)];
        _gtTabBar.delegate = (id)self;
    }
    return _gtTabBar;
}

@end
