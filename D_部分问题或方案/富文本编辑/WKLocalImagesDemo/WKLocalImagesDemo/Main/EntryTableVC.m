//
//  EntryTableVC.m
//  TestDemo
//
//  Created by hnbwyh on 2021/1/13.
//

#import "EntryTableVC.h"

@interface EntryTableVC ()

@property (nonatomic,strong) NSMutableArray *vcsData;
@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation EntryTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *vcs        = @[@"FirstVC",@"SecondVC",
                            @"FirstVC",@"SecondVC"];
    NSArray *cnts       = @[@"图片储存不同位置",@"跨域读取",
                            @"",@""];
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
    UIViewController *vc = (UIViewController *)[[NSClassFromString(self.vcsData[indexPath.row]) alloc] init];
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
