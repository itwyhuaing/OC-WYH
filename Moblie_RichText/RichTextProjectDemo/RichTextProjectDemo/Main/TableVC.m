//
//  TableVC.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/2/5.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "TableVC.h"
#import "RichTextEditor.h"
#import "JXTextViewVC.h"
#import "AttibutedTestVC.h"
#import "AttributedTest2VC.h"
#import "TextViewLoadHtmlVC.h"
#import "WKLoadHtmlVC.h"

@interface TableVC ()

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) NSMutableArray *vcs;

@end

@implementation TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  UI 修饰
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSArray *tmpds  = @[@"富文本编辑:UITextView属性测试第一部分",@"富文本编辑:UITextView属性测试第二部分",
                        @"富文本编辑:UITextView实现方式",@"富文本编辑:WKWebView实现方式 - WK",
                        @"富文本展示:UITextView加载HTML",@"富文本展示:WKWebView加载HTML"];
    NSArray *tmpvcs = @[@"AttibutedTestVC",@"AttributedTest2VC",
                        @"JXTextViewVC",@"RichTextEditor",
                        @"TextViewLoadHtmlVC",@"WKLoadHtmlVC"];
    _vcs        = [[NSMutableArray alloc] initWithArray:tmpvcs];
    _dataSource = [[NSMutableArray alloc] initWithArray:tmpds];
}

#pragma mark - Table view data source

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id_reuse"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell_id_reuse"];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc = (UIViewController *)[[NSClassFromString(self.vcs[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:vc animated:FALSE];
}

@end
