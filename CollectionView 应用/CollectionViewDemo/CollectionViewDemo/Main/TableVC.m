//
//  TableVC.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/9/28.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "TableVC.h"

@interface TableVC ()

@property (nonatomic,strong)    NSMutableArray *listData;

@property (nonatomic,strong)    NSMutableArray *vcs;

@end

@implementation TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    NSString *vcstring          = self.listData[indexPath.row];
    cell.textLabel.text         = vcstring;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    NSString *vcstring          = self.vcs[indexPath.row];
    UIViewController *vc        = [[NSClassFromString(vcstring) alloc] init];
    [self.navigationController pushViewController:vc animated:TRUE];
}

#pragma mark ------ lazy load

-(NSMutableArray *)listData{
    if (!_listData) {
        _listData = [NSMutableArray new];
        [_listData addObjectsFromArray:@[@"UI 测试",@"支付宝应用分类",@"常规瀑布流布局",@"环形布局",@"线性布局 - 动画",@"联动 - 类似锚点滑动"]];
    }
    return _listData;
}

-(NSMutableArray *)vcs{
    if (!_vcs) {
        _vcs = [NSMutableArray new];
        [_vcs addObjectsFromArray:@[@"UITestVC",@"FirstVC",@"SecondVC",@"CirCleLayoutVC",@"LineLayoutVC",@"RelatedScrollVC"]];
    }
    return _vcs;
}

@end
