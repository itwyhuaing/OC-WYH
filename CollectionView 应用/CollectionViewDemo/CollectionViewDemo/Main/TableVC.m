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
    NSString *vcstring          = self.listData[indexPath.row];
    UIViewController *vc        = [[NSClassFromString(vcstring) alloc] init];
    [self.navigationController pushViewController:vc animated:TRUE];
}

#pragma mark ------ lazy load

-(NSMutableArray *)listData{
    if (!_listData) {
        _listData = [NSMutableArray new];
        [_listData addObjectsFromArray:@[@"UITestVC",@"FirstVC",@"SecondVC",@"CirCleLayoutVC",@"LineLayoutVC",@"ThirdVC"]];
    }
    return _listData;
}

@end
