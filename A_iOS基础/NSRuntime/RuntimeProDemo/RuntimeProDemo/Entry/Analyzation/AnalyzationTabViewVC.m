//
//  AnalyzationTabViewVC.m
//  RuntimeProDemo
//
//  Created by hnbwyh on 2020/8/17.
//  Copyright © 2020 ZhiXingJY. All rights reserved.
//

#import "AnalyzationTabViewVC.h"

@interface AnalyzationTabViewVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView            *list;

@property (nonatomic,strong) NSMutableArray         *dataSource;

@end

@implementation AnalyzationTabViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);
    CGRect rct = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    _list = [[UITableView alloc] initWithFrame:rct style:UITableViewStyleGrouped];
    NSLog(@"\n %s \n %@ \n",__FUNCTION__,self);
    _list.delegate   = (id)self;
    _list.dataSource = (id)self;
    [_list registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    [self.view addSubview:_list];
    _dataSource = [[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld Section - %ld Row",indexPath.section,indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"\n\n 点击了 %ld cell \n",indexPath.row);
    
}

@end
