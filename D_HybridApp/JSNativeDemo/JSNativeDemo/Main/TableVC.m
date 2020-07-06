//
//  TableVC.m
//  JSNativeDemo
//
//  Created by wangyinghua on 2018/4/9.
//  Copyright © 2018年 ZhiXing. All rights reserved.
//

#import "TableVC.h"

@interface TableVC ()

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) NSMutableArray *vcs;

@end

@implementation TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [[NSMutableArray alloc] initWithArray:@[@"log 日志调试",@"JavaScriptCore ",
                                                              @"WebViewJavascriptBridge + WKWebView",@"MessageHandler - WK 特有",
                                                              @"WKDemo 效果"]];
    self.vcs = [[NSMutableArray alloc] initWithArray:@[@"ConsoleLogVC",@"JSCoreVC",
                                                       @"JSBridgeVC",@"MsgHandlerVC",
                                                       @"WKWebVC"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *vcs_class_str = self.vcs[indexPath.row];
    Class cls = NSClassFromString(vcs_class_str);
    UIViewController *vc = (UIViewController *)[cls new];
    [self.navigationController pushViewController:vc animated:TRUE];
    
}

@end
