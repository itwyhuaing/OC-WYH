//
//  NTEditorTitleView.h
//  RichTextPro
//
//  Created by hnbwyh on 2019/12/23.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^UpdateTitleViewHeight)(CGFloat offset_h);
@interface NTEditorTitleView : UIView

@property (nonatomic, strong,readonly) UITextView *titleTextView;

@property (nonatomic,copy) UpdateTitleViewHeight updateHight;

@end

NS_ASSUME_NONNULL_END
