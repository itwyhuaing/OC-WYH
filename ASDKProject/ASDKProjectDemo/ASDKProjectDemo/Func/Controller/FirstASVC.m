//
//  FirstASVC.m
//  ASDKProjectDemo
//
//  Created by hnbwyh on 17/7/10.
//  Copyright © 2017年 hainbwyh. All rights reserved.
//

#import "FirstASVC.h"
#import "TesTypeOneASCell.h"

@interface FirstASVC () <ASTableDelegate,ASTableDataSource>

@property (nonatomic,strong) ASTableNode *asTable;

@end

@implementation FirstASVC

#pragma mark ------ life cycle

-(instancetype)init{
    
    _asTable = [[ASTableNode alloc] init];
    if (self = [super initWithNode:_asTable]) {
        
        [self addTableNode];
        
    }
    return self;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)addTableNode{
    
    //_asTable = [[ASTableNode alloc] initWithStyle:UITableViewStylePlain];
    _asTable.delegate = self;
    _asTable.dataSource = self;
    _asTable.backgroundColor = [UIColor whiteColor];
    [self.node addSubnode:_asTable];
    _asTable.view.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [_asTable setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 20 - 44)];
    _asTable.view.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark ------ ASTableDelegate,ASTableDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}

-(ASCellNodeBlock)tableView:(ASTableView *)tableView nodeBlockForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ASCellNode *(^cellNodeBlock)() = ^ASCellNode *() {
        TesTypeOneASCell *nodeCell = [[TesTypeOneASCell alloc] initWithDataModel:nil];
        return nodeCell;
    };
    return cellNodeBlock;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@" %s --- %ld ",__FUNCTION__,indexPath.row);
}

#pragma mark ------ click btn

- (void)backNavBtnClick:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark ------ didReceiveMemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
