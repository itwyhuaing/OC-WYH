//
//  TableVC.m
//  RACDemo
//
//  Created by hnbwyh on 2019/5/5.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "TableVC.h"

@interface TableVC ()

@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic,strong) NSMutableArray *vcs;

@end

@implementation TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:FALSE];
    NSString *VCString = self.vcs[indexPath.row];
    UIViewController *vc = [[NSClassFromString(VCString) alloc] init];
    [self.navigationController pushViewController:vc animated:TRUE];
}


- (NSMutableArray *)data{
    if (!_data) {
        _data = [[NSMutableArray alloc] init];
        [_data addObjectsFromArray:@[@"Test"]];
    }
    return _data;
}

-(NSMutableArray *)vcs{
    if (!_vcs) {
        _vcs = [[NSMutableArray alloc] init];
        [_vcs addObjectsFromArray:@[@"TestVC"]];
    }
    return _vcs;
}

@end
