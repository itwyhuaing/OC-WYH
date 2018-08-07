//
//  ViewController.m
//  CoreDataPro
//
//  Created by hnbwyh on 2018/8/7.
//  Copyright © 2018年 TongXing. All rights reserved.
//

#import "ViewController.h"
#import "OperateVC.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView            *table;
@property (nonatomic,strong) NSMutableArray         *listData;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.listData addObjectsFromArray:@[@"增",@"删",@"改",@"查",@"清空"]];
    [self.view addSubview:self.table];
}

#pragma mark ------ UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHBaseTableCommanCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YHBaseTableCommanCellID"];
    }
    cell.textLabel.text = self.listData[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OperateVC *vc = [[OperateVC alloc] init];
    vc.operation = self.listData[indexPath.row];
    [self.navigationController pushViewController:vc animated:TRUE];
}

#pragma mark ------ lazy load

-(UITableView *)table{
    if (!_table) {
        CGRect rect = CGRectZero;
        rect.size = self.view.frame.size;
        _table = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}

-(NSMutableArray *)listData{
    if (!_listData) {
        _listData = [[NSMutableArray alloc] init];
    }
    return _listData;
}

@end
