//
//  JSEditorToolBar.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/12/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSEditorConfig.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^EditerToolBarBlk)(JSEditorToolBarFuncLocation location,OperateIntention status);
@interface JSEditorToolBar : UIView

// outward-向外传递信号,用户点击
@property (nonatomic,copy) EditerToolBarBlk toolBarBlk;

// into-向内传递信号，更新 UI
- (void)updateToolBarWithButtonName:(NSString *)name;

// 是否打印
@property (nonatomic,assign) BOOL isLog;

@end

NS_ASSUME_NONNULL_END
