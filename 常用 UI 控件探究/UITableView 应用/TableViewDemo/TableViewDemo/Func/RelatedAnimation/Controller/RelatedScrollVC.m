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

@interface RelatedScrollVC () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic,strong) UITableView            *table;
@property (nonatomic,strong) NSMutableArray         *listData;

@end

@implementation RelatedScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor   = [UIColor grayColor];
    self.table.backgroundColor  = [UIColor redColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = FALSE;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]
                      atScrollPosition:UITableViewScrollPositionTop
                              animated:TRUE];
    
}


#pragma mark ------ UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rows = 1;
    if (section == 1) {
        rows = self.listData.count + 1;
    }
    return rows;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIButton *hv = [UIButton buttonWithType:UIButtonTypeCustom];//[[UIView alloc] initWithFrame:CGRectZero];
    hv.backgroundColor = [UIColor orangeColor];
    if (section == 1) {
        [hv setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 60.0)];
        [hv addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return hv;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height = 0;
    if (section == 1) {
        height = 60;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = 0.0;
    if (indexPath.section <= 0) {
        cellHeight = 200.0;
    } else {
        cellHeight = [tableView cellHeightForIndexPath:indexPath model:[NSArray new] keyPath:@"datas" cellClass:[ContentCell class] contentViewWidth:[self cellContentViewWith]];
    }
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *returnCell;
    if (indexPath.section <= 0) {
        returnCell = [[UITableViewCell alloc] init];
    } else {
        ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(ContentCell.class)];
        cell.datas = @[@"美国国家概况",
                       @"美国国家虽无及州政府税务规则",
                       @"美国国家虽无及州政府税务规则",
                       @"美国国家虽无及州政府税务规则"];
        cell.title = [NSString stringWithFormat:@"Title %ld",indexPath.row];
        
        CGRect rectInTable = [self.table rectForRowAtIndexPath:indexPath];
        
        
        
        
        
        returnCell = cell;
    }
    
    returnCell.layer.borderWidth = 0.6;
    returnCell.layer.borderColor = [UIColor grayColor].CGColor;
    
    return returnCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:FALSE];
}

- (void)clickEvent:(UIButton *)btn{
    NSLog(@"\n 点击切换 \n");
    [self.table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]
                      atScrollPosition:UITableViewScrollPositionTop
                              animated:TRUE];
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
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_table];
        _table.delegate     = (id)self;
        _table.dataSource   = (id)self;
        [_table registerClass:[ContentCell class] forCellReuseIdentifier:NSStringFromClass(ContentCell.class)];
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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint targetPoint = scrollView.contentOffset;
    targetPoint.y       += 60;
    NSIndexPath *idx = [self.table indexPathForRowAtPoint:targetPoint];
    NSLog(@"\n scrollViewDidScroll 偏移:%ld \n",idx.row);
}

//-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(CGPoint)targetContentOffset{
//    NSLog(@"\n scrollViewWillEndDragging 偏移:%f \n",targetContentOffset.y);
//}
//
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSLog(@"\n scrollViewDidEndDecelerating 偏移:%f \n",scrollView.contentOffset.y);
//}

@end
