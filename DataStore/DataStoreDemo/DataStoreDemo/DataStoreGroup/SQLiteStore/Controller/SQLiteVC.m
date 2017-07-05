//
//  SQLiteVC.m
//  LXYHOCFunctionsDemo
//
//  Created by hnbwyh on 17/6/8.
//  Copyright © 2017年 lachesismh. All rights reserved.
//

#import "SQLiteVC.h"
#import "YHDataBaseManager.h"
#import "Movie.h"
#import "MovieCell.h"

#define kURLString @"https://api.douban.com/v2/movie/top250"

@interface SQLiteVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *movieTableView;
    
    //数据源
    NSMutableArray *movies;
}

@end

@implementation SQLiteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableView];
    movies = [[NSMutableArray alloc] init];
    
    // 删除旧库
    [[YHDataBaseManager sharedManager] deleteDataBaseWithFileName:@"Movie.db"];
    
    // 创建新库
    BOOL isSuc = [[YHDataBaseManager sharedManager] createDataBaseWithFileName:@"Movie.db"];
    NSLog(@" 数据库建库状态 : %d",isSuc);
    
    // 清空
    BOOL isClear = [[YHDataBaseManager sharedManager] clearDataFromTable:@"Movie"];
    NSLog(@" 数据库清空状态 : %d",isClear);
    // 入库
    [self getNewData];
    
}

-(void)rightNavBtnEvent:(UIButton *)btn{
    
}

- (void)getNewData{
    
    
    
    NSArray *jsonArray = @[
                           @{@"title":@"\u8096\u7533\u514b\u7684\u6551\u8d4e",@"img":@"https://img3.doubanio.com\/img\/celebrity\/large\/17525.jpg"},
                           @{@"title":@"\u8fd9\u4e2a\u6740\u624b\u4e0d\u592a\u51b7",@"img":@"https://img3.doubanio.com\/img\/celebrity\/large\/8833.jpg"},
                           @{@"title":@"\u9738\u738b\u522b\u59ec",@"img":@"https://img3.doubanio.com\/img\/celebrity\/large\/551.jpg"},
                           @{@"title":@"\u963f\u7518\u6b63\u4f20",@"img":@"https://img3.doubanio.com\/img\/celebrity\/large\/26764.jpg"},
                           @{@"title":@"\u5343\u4e0e\u5343\u5bfb",@"img":@"https://img3.doubanio.com\/img\/celebrity\/large\/1463193210.13.jpg"},
                           @{@"title":@"\u8f9b\u5fb7\u52d2\u7684\u540d\u5355",@"img":@"https://img3.doubanio.com\/img\/celebrity\/large\/44906.jpg"}
                           ];
    
    //解析
    for (NSDictionary *dic in jsonArray)
    {
        Movie *movie = [[Movie alloc] initWithDic:dic];
        
        [movies addObject:movie];
        
        //保存
        BOOL suc = [[YHDataBaseManager sharedManager] insertDataToDatabase:movie];
        NSLog(@"插入数据状态 : %d",suc);
        
    }
    [movieTableView reloadData];
    
}

//创建tableView
- (void)initTableView
{
    movieTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    movieTableView.delegate = self;
    movieTableView.dataSource = self;
    movieTableView.rowHeight = 70;
    [self.view addSubview:movieTableView];
    
    //注册单元格
    //[movieTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [movieTableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return movies.count + 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if (movies.count > 0 && indexPath.row < movies.count)
    {
        Movie *movie = movies[indexPath.row];
        //赋值
        [cell setModel:movie];
    }else{
        
        if (indexPath.row == movies.count) {
            [cell setTitle:@"allData"];
        }else if (indexPath.row == movies.count + 1){
            [cell setTitle:@"isModify"];
        }else if (indexPath.row == movies.count + 2){
            [cell setTitle:@"rslData"];
        }else if (indexPath.row == movies.count + 3){
            [cell setTitle:@"isDel"];
        }else if (indexPath.row == movies.count + 4){
            NSLog(@" === ");
        }
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row >= movies.count) {
        if (indexPath.row == movies.count) {
            NSArray *allData = [[YHDataBaseManager sharedManager] getAllDataFromDatabase];
            NSLog(@" allData %@ ",allData);
        }else if (indexPath.row == movies.count + 1){
            BOOL isModify = [[YHDataBaseManager sharedManager] updateValue:@"千与千寻" atKey:@"title" where:@"id=1"];//@"title=肖申克的救赎"
            [self refreshUIWithCurrentDataBase];
            NSLog(@" isModify %d ",isModify);
        }else if (indexPath.row == movies.count + 2){
            NSArray *rslData = [[YHDataBaseManager sharedManager] selectValue:@"千与千寻" atKey:@"title"];
            NSLog(@" rslData %@ ",rslData);
        }else if (indexPath.row == movies.count + 3){
            BOOL isDel = [[YHDataBaseManager sharedManager] deleteDataFromDatabaseWhere:@"title='肖申克的救赎'"];
            [self refreshUIWithCurrentDataBase];
            NSLog(@" isDel %d ",isDel);
        }else if (indexPath.row == movies.count + 4){
            NSLog(@" === ");
        }
        
        
    }
    
}

- (void)refreshUIWithCurrentDataBase{

    movies = [[NSMutableArray alloc] initWithArray:[[YHDataBaseManager sharedManager] getAllDataFromDatabase]];
    [movieTableView reloadData];
    
}

@end
