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
    NSArray *cnts = @[@"重写分类方法-分类方法具有最高优先级",@"深浅Copy",
                      @"KVC-取值与设值，及异常处理",@"KVC-修改UI",@"KVC-集合运算符与对象运算符",@"KVC,字典与模型转换",
                      @"响应链"];
    NSArray *vcs  = @[@"CategoryVC",@"CopyVC",
                      @"KVCController",@"PageControlVC",@"PersonVC",@"ModelAndDicVC",
                      @"EventChainVC"];
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
