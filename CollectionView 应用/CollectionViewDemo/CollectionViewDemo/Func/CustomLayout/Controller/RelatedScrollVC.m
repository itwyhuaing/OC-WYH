//
//  RelatedScrollVC.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/11/8.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "RelatedScrollVC.h"
#import "SDAutoLayout.h"
#import "ContentCell.h"

@interface RelatedScrollVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView            *table;
@property (nonatomic,strong) NSMutableArray         *listData;

@end

@implementation RelatedScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor   = [UIColor orangeColor];
    self.table.backgroundColor  = [UIColor redColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = FALSE;
    self.view.backgroundColor       = [UIColor whiteColor];
}

#pragma mark ------ UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count + 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *hv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100.0)];
    hv.backgroundColor = [UIColor orangeColor];
    return hv;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = 0.0;
    if (indexPath.row <= 0) {
        cellHeight = 60.0;
    } else {
        cellHeight = [tableView cellHeightForIndexPath:indexPath model:@[] keyPath:@"datas" cellClass:[ContentCell class] contentViewWidth:[self cellContentViewWith]];
    }
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ContentCell.class)];
    cell.datas = @[@"美国国家概况",
                   @"美国国家虽无及州政府税务规则",
                   @"美国国家虽无及州政府税务规则",
                   @"美国国家虽无及州政府税务规则"];
    return cell;
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}


#pragma mark ------ lazy load

-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_table];
        _table.delegate     = (id)self;
        _table.dataSource   = (id)self;
        [_table registerClass:[ContentCell class] forCellReuseIdentifier:NSStringFromClass(ContentCell.class)];
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _table.sd_layout
        .topSpaceToView(self.view, 0)
        .bottomEqualToView(self.view)
        .leftEqualToView(self.view)
        .rightEqualToView(self.view);
        
        if(@available(iOS 11.0,*)){
            _table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = FALSE;
        }
    }
    return _table;
}


-(NSMutableArray *)listData{
    if (!_listData) {
        _listData = [NSMutableArray new];
        [_listData addObjectsFromArray:@[@"Them1",@"Them2",
                                         @"Them3",@"Them4",
                                         @"Them5",@"Them6",
                                         @"Them7",@"Them8"]];
    }
    return _listData;
}

@end
