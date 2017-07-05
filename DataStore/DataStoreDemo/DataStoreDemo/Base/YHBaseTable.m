//
//  YHBaseTable.m
//  LXYHOCFunctionsDemo
//
//  Created by hnbwyh on 17/6/8.
//  Copyright © 2017年 lachesismh. All rights reserved.
//

#import "YHBaseTable.h"

@interface YHBaseTable () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *listData;

@end

@implementation YHBaseTable

-(instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect rect = CGRectZero;
        rect.size = frame.size;
        _table = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        [self addSubview:_table];
        _listData = [[NSMutableArray alloc] initWithArray:dataSource];
        
    }
    return self;
}



#pragma mark ------ UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHBaseTableCommanCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YHBaseTableCommanCellID"];
    }
    cell.textLabel.text = _listData[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_yhDelegate && [_yhDelegate respondsToSelector:@selector(yhBaseTable:didSelectedCellIndexPath:)]) {
        [_yhDelegate yhBaseTable:self didSelectedCellIndexPath:indexPath];
    }
    
}

@end
