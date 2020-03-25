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
#import "JXChartVC.h"
#import "FifthVC.h"

@interface UIBezierPathVC ()
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation UIBezierPathVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @" UIBezierPathVC ";
    //  UI 修饰
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSArray *tmp = @[@"CAShapeLayer UIBezierPath 绘制图形",@"绘制直线、折线、曲线",@"拖动四个点动态绘制曲线",@"坐标系内绘制线条",@"应用：柱状图、曲线图、折线图",@"曲线简单绘制"];
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
            vc = [[JXChartVC alloc] init];
            [self.navigationController pushViewController:vc animated:TRUE];
        }
            break;
        case 5:
        {
            vc = [[FifthVC alloc] init];
            [self.navigationController pushViewController:vc animated:TRUE];
        }
            break;
            
        default:
            break;
    }
}

@end
