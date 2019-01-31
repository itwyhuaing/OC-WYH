//
//  TableVC.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/2/5.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "TableVC.h"
#import "DataModel.h"

@interface TableVC ()
@property (nonatomic,strong) NSMutableArray<DataModel *> *dataSource;
@end

@implementation TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  UI 修饰
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSArray *vcs        = @[@"FirstVC",@"SecondVC",@"ThirdVC",@"FourthVC",@"Animation1VC",@"Animation2VC",@"Animation3VC",@"Animation4VC",@"Animation5VC"];
    NSArray *desCnts    = @[@"平面平移",@"平面缩放",@"平面旋转",@"在一个形变基础上的另一个形变",@"卡片动画",@"字体缩放动画",@"Animation3VC",@"Animation4VC",@"Animation5VC"];
    _dataSource         = [NSMutableArray new];
    for (NSInteger cou = 0; cou < vcs.count; cou ++) {
        DataModel *f    = [DataModel new];
        f.vc            = vcs[cou];
        f.desCnt        = desCnts[cou];
        [_dataSource addObject:f];
    }
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
    cell.textLabel.text = _dataSource[indexPath.row].desCnt;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = [[NSClassFromString(_dataSource[indexPath.row].vc) alloc] init];
    [self.navigationController pushViewController:vc animated:TRUE];
}

@end
