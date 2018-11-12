//
//  GangedTable.m
//  TableViewDemo
//
//  Created by hnbwyh on 2018/11/12.
//  Copyright © 2018年 TongXin. All rights reserved.
//

#import "GangedTable.h"
#import "GangedTableElementCell.h"

//测试
#import "SDAutoLayout.h"

// section
typedef enum : NSUInteger {
    GangedTableSection0 = 0,
    GangedTableSection1,
    GangedTableSectionCount,
} GangedTableSection;


@interface GangedTable () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) UIView                 *blankHeader;


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
        rows = self.dataModels.count;
    }
    return rows;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *hv = self.blankHeader;
    if (section == GangedTableSection1 && self.gtableBar) {
        hv = self.gtableBar;
    }
    return hv;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 0;
    if (section == GangedTableSection1 && self.gtableBar) {
        height = CGRectGetHeight(self.gtableBar.frame);
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = 0.0;
    if (indexPath.section <= GangedTableSection0) {
        cellHeight = self.gtableHeader ? CGRectGetHeight(self.gtableHeader.frame) : 0.0;
    } else if (indexPath.section == GangedTableSection1){
        cellHeight = [tableView cellHeightForIndexPath:indexPath model:self.dataModels[indexPath.row] keyPath:@"elementData" cellClass:[GangedTableElementCell class] contentViewWidth:[self cellContentViewWith]];
    }
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *returnCell;
    if (indexPath.section <= 0) {
        returnCell = [[UITableViewCell alloc] init];
    } else {
        GangedTableElementCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(GangedTableElementCell.class)];
        cell.elementData = self.dataModels[indexPath.row];
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
    NSLog(@"\n scrollViewDidScroll 偏移:%ld \n",idx.row);
}

#pragma mark ------ set data

-(void)setDataModels:(NSArray<ElementModel *> *)dataModels{
    if (![dataModels isEqualToArray:_dataModels]) {
        
        _dataModels = dataModels;
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

@end
