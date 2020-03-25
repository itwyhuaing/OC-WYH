//
//  JSEditorView.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/12/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JSEditorView;
@protocol JSEditorViewKeyBoardDelegate <NSObject>
@optional
// keyBoard
- (void)jsEditorView:(JSEditorView *)jsEditor willShowWithKeyRectEnd:(CGRect)rect;
- (void)jsEditorView:(JSEditorView *)jsEditor willHideWithKeyRectEnd:(CGRect)rect;

@end

@protocol JSEditorViewNavigationDelegate <NSObject>
@optional
// web load
- (void)jsEditorView:(JSEditorView *)jsEditor navigationActionWithFuncs:(NSString *)funcs;

@end

@interface JSEditorView : UIView

@property (nonatomic,readonly,strong) WKWebView          *wkEditor;

// outward-内部不同信号向外传递
@property (nonatomic,weak) id<JSEditorViewKeyBoardDelegate> delegate;
@property (nonatomic,weak) id<JSEditorViewNavigationDelegate> navigationDelegate;


// 是否打印
@property (nonatomic,assign) BOOL isLog;

@end

NS_ASSUME_NONNULL_END
