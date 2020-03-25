//
//  NTEditController.m
//  RichTextPro
//
//  Created by hnbwyh on 2019/12/24.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "NTEditController.h"
#import "NTEditorMainView.h"
#import "NTEditorConfig.h"

@interface NTEditController ()

@property (nonatomic,strong) NTEditorMainView *editorView;

@end

@implementation NTEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.editorView setFrame:CGRectMake(0, STATUBAR_HEIGHT + NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:self.editorView];
}

-(NTEditorMainView *)editorView {
    if (!_editorView) {
        _editorView = [[NTEditorMainView alloc] init];
    }
    return _editorView;
}

@end
