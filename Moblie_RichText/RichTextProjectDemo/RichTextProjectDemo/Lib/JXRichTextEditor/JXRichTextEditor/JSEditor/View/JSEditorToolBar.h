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

@property (nonatomic,copy) EditerToolBarBlk toolBarBlk;

- (void)updateToolBarWithButtonName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
