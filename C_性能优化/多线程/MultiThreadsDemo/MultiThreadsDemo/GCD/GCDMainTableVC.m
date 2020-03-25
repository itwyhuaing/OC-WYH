//
//  GCDMainTableVC.m
//  GCDProjectDemo
//
//  Created by wangyinghua on 2018/8/25.
//  Copyright © 2018年 ZhiXing. All rights reserved.
//

#import "GCDMainTableVC.h"
#import "BaseVC.h"

@interface GCDMainTableVC ()

@property (nonatomic,strong) NSMutableArray *vcsData;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation GCDMainTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *vcs        = @[@"TestVC1",@"TestVC2",@"TestVC3",@"TestVC4",@"TestVC5",@"TestVC6",@"TestVC7",@"TestVC8"];
    NSArray *cnts       = @[@"Semaphore - 线程等待",@"Queue 队列生成、获取，优先级变更、合并",@"After",@"Group-Notify-Wait:队列组操作、通知、等待",@"数竞争冒险 - 数据读写问题解决",@"Apply高效率循环",@"Queue 挂起/恢复",@"Once - 单例对象"];
    [self.vcsData addObjectsFromArray:vcs];
    [self.dataSource addObjectsFromArray:cnts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    cell.textLabel.text   = self.dataSource[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseVC *vc = (BaseVC *)[[NSClassFromString(self.vcsData[indexPath.row]) alloc] init];
    vc.title = self.dataSource[indexPath.row];
    [self.navigationController pushViewController:vc animated:TRUE];
}

#pragma mark ------ lazy load

-(NSMutableArray *)vcsData{
    if (!_vcsData) {
        _vcsData = [NSMutableArray new];
    }
    return _vcsData;
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

@end
