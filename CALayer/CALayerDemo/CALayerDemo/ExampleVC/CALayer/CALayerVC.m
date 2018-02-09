//
//  CALayerVC.m
//  CALayerDemo
//
//  Created by hnbwyh on 2018/2/9.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "CALayerVC.h"
#import "CAFirstVC.h"

@interface CALayerVC ()
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation CALayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @" CALayerVC ";
    //  UI 修饰
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //NSArray *tmp = @[@"FirstVC",@"DefendContinHitVC - UIButton 防连击",@"3",@"4",@"5",@"6"];
    NSArray *tmp = @[@"1",@"2",@"3",@"4",@"5",@"6"];
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
            vc = [[CAFirstVC alloc] init];
            [self.navigationController pushViewController:vc animated:TRUE];
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
            
        default:
            break;
    }
}

@end
