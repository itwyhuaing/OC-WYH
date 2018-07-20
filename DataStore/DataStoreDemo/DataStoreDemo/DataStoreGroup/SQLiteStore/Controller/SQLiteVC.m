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
    //数据源
    NSMutableArray *movies;
}
@property (nonatomic,strong) UITableView *moviewTableView;

@end

@implementation SQLiteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.displayLabel.text = @" 1> 点击启动按钮,删除旧数据库，创建新数据库 \n \n \n 2> 观察沙盒路径文件变化";

}

-(void)rightNavBtnEvent:(UIButton *)btn{
    // 布局
    [self initTableView];
    movies = [[NSMutableArray alloc] init];
    
    // 数据库操作
    // 删除旧库
    BOOL isDele = [[YHDataBaseManager sharedManager] deleteDataBaseWithFileName:@"Movie.db"];
    NSLog(@" 删除旧库 : %d",isDele);
    
    // 创建新库
    BOOL isNew = [[YHDataBaseManager sharedManager] createDataBaseWithFileName:@"Movie.db"];
    NSLog(@" 新建数据库 : %d",isNew);
    
    // 入库
    [self getNewData];
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
    for (NSDictionary *dic in jsonArray){
        Movie *movie = [[Movie alloc] initWithDic:dic];
        [movies addObject:movie];
        //保存
        BOOL suc = [[YHDataBaseManager sharedManager] insertDataToDatabase:movie];
        NSLog(@"插入数据状态 : %d",suc);
    }
    [self.moviewTableView reloadData];
    
}

//创建tableView
- (void)initTableView{
    [self.view addSubview:self.moviewTableView];
    
    //注册单元格
    //[self.movieTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.moviewTableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return movies.count + 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *rtnCell;
    if (movies.count > 0 && indexPath.row < movies.count){
        MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CntCell"];
        Movie *movie = movies[indexPath.row];
        //赋值
        [cell setModel:movie];
        rtnCell = cell;
    }
    else{
        MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FunctionCell"];
        if (indexPath.row == movies.count) {
            [cell setTitle:@"其他功能测试"];
        }else if (indexPath.row == movies.count + 1){
            [cell setTitle:@"allData"];
        }else if (indexPath.row == movies.count + 2){
            [cell setTitle:@"isModify"];
        }else if (indexPath.row == movies.count + 3){
            [cell setTitle:@"rslData"];
        }else if (indexPath.row == movies.count + 4){
            [cell setTitle:@"isDel"];
        }else{
            NSLog(@" === ");
        }
        rtnCell = cell;
    }
    return rtnCell;
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
    [self.moviewTableView reloadData];
    
}

-(UITableView *)moviewTableView{
    if(!_moviewTableView){
        CGRect rect = self.view.bounds;
        _moviewTableView = [[UITableView alloc] initWithFrame:rect];
        _moviewTableView.delegate = self;
        _moviewTableView.dataSource = self;
        _moviewTableView.rowHeight = 70;
    }
    return _moviewTableView;
}


@end
