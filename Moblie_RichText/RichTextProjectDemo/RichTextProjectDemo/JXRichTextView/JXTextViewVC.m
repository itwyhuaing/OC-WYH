//
//  JXTextViewVC.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/8.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import "JXTextViewVC.h"
#import "NTEditorMainView.h"

@interface JXTextViewVC ()

@property (nonatomic,strong) NTEditorMainView *jxtv;

@end

@implementation JXTextViewVC

#pragma mark ------ life

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.jxtv];
    //self.jxtv.backgroundColor = [UIColor greenColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = FALSE;
    self.view.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark ------
#pragma mark ------
#pragma mark ------
#pragma mark ------
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
