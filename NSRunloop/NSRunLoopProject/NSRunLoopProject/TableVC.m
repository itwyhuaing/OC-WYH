//
//  TableVC.m
//  JXPlayerDemo
//
//  Created by hnbwyh on 2019/1/24.
//  Copyright © 2019年 JiXia. All rights reserved.
//

#import "TableVC.h"
#import "FirstVC.h"
#import "SecondVC.h"

@interface TableVC ()

@property (nonatomic,strong)        NSMutableArray<NSString *> *cnts;

@end

@implementation TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cnts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CntCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CntCellID"];
    }
    cell.textLabel.text = self.cnts[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    UIViewController *rltVC;
    if (indexPath.row == 0) {
        FirstVC *vc = [[FirstVC alloc] init];
        rltVC = vc;
    }else{
        SecondVC *vc = [[SecondVC alloc] init];
        rltVC = vc;
    }
    [self.navigationController pushViewController:rltVC animated:TRUE];
}

-(NSMutableArray<NSString *> *)cnts{
    if (!_cnts) {
        _cnts = [[NSMutableArray alloc] initWithObjects:@"多源处理 - 滚动 UIScroView、定时器",@"线程保活", nil];
    }
    return _cnts;
}

@end
