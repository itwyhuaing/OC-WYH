//
//  JXFontVC.m
//  JXObjCategary
//
//  Created by hnbwyh on 2018/10/18.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "JXFontVC.h"

static NSString *cntText = @"汉体书写信息技术标准相,容档案下载使用界面简单,支援服务升级资讯专业制,作创意空间快速无线上网,兙兛兞兝兡兣嗧瓩糎,洛杉矶 · 市场热度指数";

@interface JXFontVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)    UITableView     *table;
@property (strong, nonatomic)   NSArray         *fontNames;

// 测试展示
@property (nonatomic,strong)    UILabel         *cntLabel;
@property (nonatomic,strong)    UITextView      *cntTextView;

@end

@implementation JXFontVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor       = [UIColor whiteColor];
    self.fontNames = [[NSArray alloc] initWithObjects:
                      @"STXingkai-SC-Light",
                      @"DFWaWaSC-W5",
                      @"FZLTXHK--GBK1-0",
                      @"STLibian-SC-Regular",
                      @"LiHeiPro",
                      @"HiraginoSansGB-W3",
                      @"PingFangSC-Medium",
                      nil];
    
    CGRect rect             = self.view.bounds;
    rect.size.height        = (CGRectGetHeight(self.view.bounds)-rect.origin.y) / 3.0;
    [self.table setFrame:rect];
    
    rect.origin.y           = CGRectGetMaxY(rect);
    [self.cntLabel setFrame:rect];
    
    rect.origin.y           = CGRectGetMaxY(rect);
    [self.cntTextView setFrame:rect];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_fontNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    // Try to retrieve from the table view a now-unused cell with the given identifier.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    // If no cell is available, create a new one using the given identifier.
    if (cell == nil) {
        // Use the default cell style.
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    // Set up the cell.
    cell.textLabel.text = _fontNames[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    [UIFont asynchronouslySetFontName:self.fontNames[indexPath.row] fontSize:13.0 fontBlock:^(UIFont *font) {
        NSLog(@" ====== > Block ");
        weakSelf.cntLabel.font          = font;
        weakSelf.cntTextView.font       = font;
    }];
}



-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate                 = (id)self;
        _table.dataSource               = (id)self;
        [self.view addSubview:_table];
    }
    return _table;
}

-(UILabel *)cntLabel{
    if (!_cntLabel) {
        _cntLabel                   = [[UILabel alloc] initWithFrame:CGRectZero];
        _cntLabel.numberOfLines     = 0;
        _cntLabel.text              = cntText;
        _cntLabel.backgroundColor   = [UIColor orangeColor];
        [self.view addSubview:_cntLabel];
    }
    return _cntLabel;
}

-(UITextView *)cntTextView{
    if (!_cntTextView) {
        _cntTextView                = [[UITextView alloc] initWithFrame:CGRectZero];
        _cntTextView.text           = cntText;
        _cntTextView.backgroundColor= [UIColor cyanColor];
        [self.view addSubview:_cntTextView];
    }
    return _cntTextView;
}

@end
