//
//  TableVC.m
//  CALayerDemo
//
//  Created by hnbwyh on 2018/2/8.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "TableVC.h"
#import "CALayerVC.h"
#import "UIBezierPathVC.h"
#import "LayerPathVC.h"
#import "LayerPathController.h"

@interface TableVC ()
@property (nonatomic,strong) NSMutableArray *thems;
@property (nonatomic,strong) NSMutableArray *vcs;
@end

@implementation TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  UI 修饰
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _thems = [[NSMutableArray alloc] initWithArray:@[
                                                    @"CALayerVC",@"UIBezierPathVC",
                                                    @"LayerPathVC 简单应用 - 镂空效果",@"动态设置叠加图片的透明度"]];
    _vcs   = [[NSMutableArray alloc] initWithArray:@[@"CALayerVC",@"UIBezierPathVC",
                                                     @"LayerPathVC",@"LayerPathController"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _thems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id_reuse"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id_reuse"];
    }
    cell.textLabel.text = _thems[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = (UIViewController *)[[NSClassFromString(self.vcs[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:vc animated:TRUE];
    
}

@end
