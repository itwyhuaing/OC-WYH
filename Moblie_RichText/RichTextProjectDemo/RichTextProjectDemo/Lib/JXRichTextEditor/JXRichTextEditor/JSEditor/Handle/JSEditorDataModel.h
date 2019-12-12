//
//  JSEditorDataModel.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/12/12.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSEditorConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToolBarItem : NSObject

//  数据内容
@property (nonatomic,copy) NSString *them;
@property (nonatomic,copy) NSString *onIconName;
@property (nonatomic,copy) NSString *offIconName;

// 交互
@property (nonatomic,assign) BOOL                           isOn;
@property (nonatomic,assign) JSEditorToolBarFuncType        funcType;

@end

@interface JSEditorDataModel : NSObject

@end

NS_ASSUME_NONNULL_END
