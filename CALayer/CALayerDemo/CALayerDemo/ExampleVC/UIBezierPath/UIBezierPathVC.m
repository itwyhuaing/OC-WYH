//
//  UIBezierPathVC.m
//  CALayerDemo
//
//  Created by hnbwyh on 2018/2/9.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "UIBezierPathVC.h"
#import "FirstVC.h"
#import "SecondVC.h"
#import "ThirdVC.h"
#import "FourthVC.h"

@interface UIBezierPathVC ()
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation UIBezierPathVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @" UIBezierPathVC ";
    //  UI 修饰
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSArray *tmp = @[@"FirstVC",@"SecondVC",@"ThirdVC",@"FourthVC",];
    _dataSource = [[NSMutableArray alloc] initWithArray:tmp];
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
    UIViewController *vc;
    switch (indexPath.row) {
        case 0:
        {
            vc = [[FirstVC alloc] init];
            [self.navigationController pushViewController:vc animated:TRUE];
        }
            break;
        case 1:
        {
            vc = [[SecondVC alloc] init];
            [self.navigationController pushViewController:vc animated:TRUE];
        }
            break;
        case 2:
        {
            vc = [[ThirdVC alloc] init];
            [self.navigationController pushViewController:vc animated:TRUE];
        }
            break;
        case 3:
        {
            vc = [[FourthVC alloc] init];
            [self.navigationController pushViewController:vc animated:TRUE];
        }
            break;
        case 4:
        {
            
        }
            break;
            
        default:
            break;
    }
}

@end
