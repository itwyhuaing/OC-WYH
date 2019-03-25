//
//  TableVC.m
//  OptimizedProDemo
//
//  Created by hnbwyh on 2019/3/25.
//  Copyright © 2019 ZhiXingJY. All rights reserved.
//

#import "TableVC.h"

@interface TableVC ()

@property (nonatomic,strong)    NSMutableArray<NSString *>              *thems;
@property (nonatomic,strong)    NSMutableArray<NSString *>              *vcs;

@end

@implementation TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.thems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    cell.textLabel.text = self.thems[indexPath.row];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *VCString = self.vcs[indexPath.row];
    if (VCString && VCString.length > 0) {
        Class cl = NSClassFromString(VCString);
        UIViewController *vc = [[cl alloc] init];
        [self.navigationController pushViewController:vc animated:FALSE];
    }
}

#pragma mark - lazy load

-(NSMutableArray<NSString *> *)thems {
    if (!_thems) {
        _thems = [[NSMutableArray alloc] init];
        [_thems addObjectsFromArray:@[@"Net",@"NSArray 防止 Crash",
                                      @"",@"",
                                      @"",@"",
                                      @"",@"",
                                      @"",@"",
                                      @"",@""]];
    }
    return _thems;
}

-(NSMutableArray<NSString *> *)vcs {
    if (!_vcs) {
        _vcs = [[NSMutableArray alloc] init];
        [_vcs addObjectsFromArray:@[@"",@"ArrayVC",
                                      @"",@"",
                                      @"",@"",
                                      @"",@"",
                                      @"",@"",
                                      @"",@""]];
    }
    return _vcs;
}


@end
