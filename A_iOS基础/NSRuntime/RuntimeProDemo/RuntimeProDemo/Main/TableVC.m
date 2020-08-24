//
//  TableVC.m
//  RuntimeProDemo
//
//  Created by hnbwyh on 2018/1/29.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "TableVC.h"
#import "FirstTableVC.h"
#import "DefendContinHitVC.h"
#import "CategaryVC.h"

@interface TableVC ()

@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) NSMutableArray *vcs;

@end

@implementation TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //  UI 修饰
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSArray *tmp = @[@"属性/方法遍历、方法拦截",@"DefendContinHitVC - UIButton 防连击",@"CategaryVC",
                     @"UIControl 点击事件拦截",@"UIGestureRecognizer 响应事件拦截",
                     @"UITableView didCell "];
    _dataSource = [[NSMutableArray alloc] initWithArray:tmp];
    _vcs = [[NSMutableArray alloc] initWithArray:@[
        @"FirstTableVC",@"DefendContinHitVC",@"CategaryVC",
        @"AnalyzationUICotrolVC",@"AnalyzationGestureVC",@"AnalyzationTabViewVC",
    ]];
    
    NSLog(@"\n HookUITableView : \n %s \n %@ \n %@ \n",__FUNCTION__,self,self.tableView);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id_reuse"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id_reuse"];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *vcstring = self.vcs[indexPath.row];
    if (vcstring) {
        Class cl = NSClassFromString(vcstring);
        UIViewController *vc = (UIViewController *)[cl new];
        [self.navigationController pushViewController:vc animated:TRUE];
    }
}

@end
