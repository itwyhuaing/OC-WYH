//
//  JSEditorView.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/12/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JSEditorView;
@protocol JSEditorViewDelegate <NSObject>
@optional
- (void)jsEditorView:(JSEditorView *)jsEditor willShowKeyboardWithHeight:(CGFloat)height;

- (void)jsEditorView:(JSEditorView *)jsEditor willHideKeyboardWithHeight:(CGFloat)height;

- (void)jsEditorView:(JSEditorView *)jsEditor navigationActionWithFuncs:(NSString *)funcs;

@end


@interface JSEditorView : UIView

@property (nonatomic,weak) id<JSEditorViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
