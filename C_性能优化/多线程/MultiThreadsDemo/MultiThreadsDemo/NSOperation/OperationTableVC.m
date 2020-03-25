//
//  OperationTableVC.m
//  MultiThreadsDemo
//
//  Created by hnbwyh on 2020/3/17.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import "OperationTableVC.h"
#import "BaseVC.h"

@interface OperationTableVC ()
@property (nonatomic,strong) NSMutableArray *vcsData;
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation OperationTableVC


- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *vcs        = @[@"OperationTest1VC",
                            @"OperationTestVC2",
                            @"ThreadLockVC"];
    NSArray *cnts       = @[@"InvocationOperation/BlockOperation/addDependency/addExecutionBlock/queuePriority",
                            @"线程间通信",
                            @"线程锁:NSLock",
                            ];
    [self.vcsData addObjectsFromArray:vcs];
    [self.dataSource addObjectsFromArray:cnts];
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
