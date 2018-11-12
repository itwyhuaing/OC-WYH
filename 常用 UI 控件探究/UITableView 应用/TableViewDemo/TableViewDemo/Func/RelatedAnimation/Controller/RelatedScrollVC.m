//
//  RelatedScrollVC.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/11/8.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "RelatedScrollVC.h"
#import "GangedTable.h"
#import "GangedTableBar.h"

#import "GangedTableModel.h"

//测试
#import "SDAutoLayout.h"

@interface RelatedScrollVC () 

@property (nonatomic,strong)  GangedTable            *gtable;
@property (nonatomic,strong)  GangedTableBar         *gtTabBar;

@end

@implementation RelatedScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor   = [UIColor grayColor];
    self.gtable.gtableHeader    = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 200.0)];
    self.gtable.gtableBar       = self.gtTabBar;
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = FALSE;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)loadData{
    
    NSArray *barThems = @[@"baritem1",@"baritem2",@"baritem3",@"baritem4",@"baritem5",@"baritem6"];
    NSMutableArray *items = [NSMutableArray new];
    for (NSInteger i = 0; i < 5; i ++) {
        ItemModel *ifm = [ItemModel new];
        ifm.cnt = [NSString stringWithFormat:@"内容%ld-美国社会",i];
        ifm.pid = [NSString stringWithFormat:@"id%ld",i];
        [items addObject:ifm];
    }
    
    NSMutableArray *elements = [NSMutableArray new];
    for (NSInteger e = 0; e < barThems.count; e ++) {
        ElementModel *ef = [ElementModel new];
        [elements addObject:ef];
        ef.items = items;
        ef.them = [NSString stringWithFormat:@"Thme%ld",e];
    }
    
    // 数据模型
    GangedTableModel *f = [[GangedTableModel alloc] init];
    f.barThems = barThems;
    f.elements = elements;
    
    // 赋值
    self.gtable.dataModels = f.elements;
    self.gtTabBar.thems    = barThems;
}

#pragma mark ------ lazy load

-(GangedTable *)gtable{
    if (!_gtable) {
        _gtable = [[GangedTable alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.view addSubview:_gtable];
        _gtable.sd_layout
        .leftEqualToView(self.view)
        .rightEqualToView(self.view)
        .topSpaceToView(self.view, 0)
        .bottomEqualToView(self.view);
    }
    return _gtable;
}

-(GangedTableBar *)gtTabBar{
    if (!_gtTabBar) {
        _gtTabBar = [[GangedTableBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 60.0)];
    }
    return _gtTabBar;
}

@end
