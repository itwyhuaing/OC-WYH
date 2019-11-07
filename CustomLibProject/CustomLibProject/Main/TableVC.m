//
//  TableVC.m
//  CustomLibProject
//
//  Created by hnbwyh on 2019/10/18.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "TableVC.h"

@interface TableVC ()

@property (nonatomic,strong) NSMutableArray<NSArray *> *datas;

@end

@implementation TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self generateDataSource];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas[0].count;}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    cell.textLabel.text = [self.datas firstObject][indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:FALSE];
    NSString *vcstring = [self.datas lastObject][indexPath.row];
    UIViewController *vc     = [[NSClassFromString(vcstring) alloc] init];
    [self.navigationController pushViewController:vc animated:TRUE];
}

- (void)generateDataSource {
    NSArray *cnts = @[@"ScrollView 方式实现轮播图",@"UICollection方式实现轮播图"];
    NSArray *vcs  = @[@"ScrollBannerVC",@"CollectionBannerVC"];
    [self.datas addObject:cnts];
    [self.datas addObject:vcs];
}

-(NSMutableArray<NSArray *> *)datas {
    if (!_datas) {
        _datas = [NSMutableArray new];
    }
    return _datas;
}

@end