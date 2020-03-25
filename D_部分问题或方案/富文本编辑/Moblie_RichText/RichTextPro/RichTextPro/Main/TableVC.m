//
//  TableVC.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/2/5.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "TableVC.h"

@interface TableVC ()

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) NSMutableArray *vcs;

@end

@implementation TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  UI 修饰
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    NSArray *tmpds  = @[@"富文本编辑:\nUITextView 方式实现",
                        @"富文本编辑:\nWKWebView方式实现",];
    NSArray *tmpvcs = @[@"NTRichTextEditorVC",
                        @"JSRichTextEditorVC"];
    _vcs        = [[NSMutableArray alloc] initWithArray:tmpvcs];
    _dataSource = [[NSMutableArray alloc] initWithArray:tmpds];
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id_reuse"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id_reuse"];
    }
    cell.textLabel.text          = _dataSource[indexPath.row];
    cell.textLabel.numberOfLines = 0;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = (UIViewController *)[[NSClassFromString(self.vcs[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:vc animated:FALSE];
}

@end
