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

@interface TableVC ()
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  UI 修饰
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //NSArray *tmp = @[@"FirstVC",@"DefendContinHitVC - UIButton 防连击",@"3",@"4",@"5",@"6"];
    NSArray *tmp = @[@"CALayerVC",@"UIBezierPathVC",@"LayerPathVC 简单应用 - 镂空效果"];
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
            vc = [[CALayerVC alloc] init];
            [self.navigationController pushViewController:vc animated:TRUE];
        }
            break;
        case 1:
        {
            vc = [[UIBezierPathVC alloc] init];
            [self.navigationController pushViewController:vc animated:TRUE];
        }
            break;
        case 2:
        {
            vc = [[LayerPathVC alloc] init];
            [self.navigationController pushViewController:vc animated:TRUE];
        }
            break;
        case 3:
        {
            
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
