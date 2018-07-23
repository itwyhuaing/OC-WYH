//
//  ViewController.m
//  DataStoreDemo
//
//  Created by hnbwyh on 17/6/27.
//  Copyright © 2017年 hainbwyh. All rights reserved.
//

#import "ViewController.h"
#import "DataStoreMainView.h"

@interface ViewController ()<YHBaseTableDelegate>

@property (nonatomic,strong) DataStoreMainView *mainView;
@property (nonatomic,strong) NSMutableArray *list;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _list = [[NSMutableArray alloc] initWithArray:@[@"PlistVC",@"DefaultVC",@"FileWRVC",@"EncodeVC",@"SQLiteVC",@"JXSQLiteVC",@"CoreDataVC"]];
    _mainView = [[DataStoreMainView alloc] initWithFrame:CGRectMake(0,
                                                                    0,
                                                                    [UIScreen mainScreen].bounds.size.width,
                                                                    [UIScreen mainScreen].bounds.size.height - 64 - 49) dataSource:_list];
    _mainView.yhDelegate = self;
    [self.view addSubview:_mainView];
    
}


#pragma mark ----- YHBaseTableDelegate

-(void)yhBaseTable:(YHBaseTable *)yhTable didSelectedCellIndexPath:(NSIndexPath *)index{
    
    NSString *vcstring = _list[index.row];
    UIViewController *vc = [[NSClassFromString(vcstring) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
