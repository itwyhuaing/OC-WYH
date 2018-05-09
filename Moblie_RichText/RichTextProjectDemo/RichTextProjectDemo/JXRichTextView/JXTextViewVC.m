//
//  JXTextViewVC.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/8.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "JXTextViewVC.h"
#import "NTEditorMainView.h"
#import "EditorToolBar.h"

@interface JXTextViewVC () <EditorToolBarDataSource>

@property (nonatomic,strong) NTEditorMainView *jxtv;
@property (nonatomic,strong) EditorToolBar *toolBar;

@end

@implementation JXTextViewVC

#pragma mark ------ life

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.jxtv];
    self.jxtv.backgroundColor = [UIColor redColor];
    
    CGRect rect = self.jxtv.frame;
    rect.origin.y = 200;
    rect.origin.x = 0;
    rect.size.height = 44.0;
    _toolBar = [[EditorToolBar alloc] initWithFrame:rect];
    _toolBar.dataSource = self;
    [self.jxtv addSubview:_toolBar];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = FALSE;
    self.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark ------
#pragma mark ------
#pragma mark ------

#pragma mark ------ delegate
#pragma mark - EditorToolBarDataSource
-(NSArray *)contentsForEditorToolBar:(EditorToolBar *)bar{
    return @[@"11",@"22",@"33",@"44",@"55",@"66"];
}


#pragma mark ------ lazy load

-(NTEditorMainView *)jxtv{
    if (!_jxtv) {
        CGRect rect = self.view.frame;
        rect.origin.x = 10.0;
        rect.size.width -= rect.origin.x * 2.0;
        rect.size.height -= 100.0;
        _jxtv = [[NTEditorMainView alloc] initWithFrame:rect];
    }
    return _jxtv;
}

@end
