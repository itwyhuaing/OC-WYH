//
//  FucnsTable.m
//  JXRichTextDemo
//
//  Created by hnbwyh on 2019/4/15.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "FucnsTable.h"

@interface FucnsTable ()

@property (nonatomic,strong) NSArray<NSString *> *thems;
@property (nonatomic,strong) NSArray<NSString *> *vcs;

@end

@implementation FucnsTable

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSStringFromClass(self.class);
    self.thems = @[@"Hpple 解析",@"Web展示-UITextView展示",@"固定富文本",@"可编辑富文本"];
    self.vcs   = @[@"HppleVC",@"WebVC",@"AttributedTextParserVC",@"RichTextEditorVC"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vcs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FuncCellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FuncCellID"];
    }
    cell.textLabel.text = self.thems[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:FALSE];
    NSString *vcstring = self.vcs[indexPath.row];
    UIViewController *vc = [[NSClassFromString(vcstring) alloc] init];
    [self.navigationController pushViewController:vc animated:TRUE];
}

@end
