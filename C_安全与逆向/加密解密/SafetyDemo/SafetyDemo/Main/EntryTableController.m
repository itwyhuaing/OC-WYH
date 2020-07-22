//
//  EntryTableController.m
//  AnimationDemo
//
//  Created by hnbwyh on 2020/6/28.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import "EntryTableController.h"

@interface EntryTableController ()

@property (nonatomic,strong) NSMutableArray *thems;
@property (nonatomic,strong) NSMutableArray *vcs;

@end

@implementation EntryTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  UI 修饰
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _thems = [[NSMutableArray alloc] initWithArray:@[@"RSAController",@"MD5Controller",]];
    _vcs   = [[NSMutableArray alloc] initWithArray:@[@"RSAController",@"MD5Controller",]];
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
