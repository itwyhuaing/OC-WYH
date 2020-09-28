//
//  XpathParser.h
//  RuntimeProDemo
//
//  Created by hnbwyh on 2020/8/17.
//  Copyright © 2020 ZhiXingJY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    AnalyzationUIControlType                = 999,
    AnalyzationUIViewType,
    AnalyzationUITableViewType,
    AnalyzationUICollectionViewType,
    AnalyzationUIGestureType,
} AnalyzationType;

static void Hook_Method(Class originalClass, SEL originalSel, Class replacedClass, SEL replacedSel, SEL noneSel) {
    Method originalMethod = class_getInstanceMethod(originalClass, originalSel);
    Method replacedMethod = class_getInstanceMethod(replacedClass, replacedSel);
    if (!originalMethod) {
        Method noneMethod = class_getInstanceMethod(replacedClass, noneSel);
        BOOL addNoneMethod = class_addMethod(originalClass, originalSel, method_getImplementation(noneMethod), method_getTypeEncoding(noneMethod));
        if (addNoneMethod) {
            //NSLog(@"******** HookUITableView 没有实现 (%@) 方法，手动添加成功！！", NSStringFromSelector(originalSel));
        }else {
            //NSLog(@"******** HookUITableView - else ");
        }
        return;
    }else {
        //NSLog(@"******** HookUITableView - else ");
    }

    BOOL addMethod = class_addMethod(originalClass, replacedSel, method_getImplementation(replacedMethod), method_getTypeEncoding(replacedMethod));
    if (addMethod) {
        //NSLog(@"******** HookUITableView 实现了 (%@) 方法并成功 Hook 为 --> (%@)", NSStringFromSelector(originalSel), NSStringFromSelector(replacedSel));
        Method newMethod = class_getInstanceMethod(originalClass, replacedSel);
        method_exchangeImplementations(originalMethod, newMethod);
    } else {
        //NSLog(@"******** HookUITableView 已替换过，避免多次替换 --> (%@)",NSStringFromClass(originalClass));
    }
}


@interface XpathParser : NSObject

+ (instancetype)currentXpathParser;

+ (NSString *)xpathForObj:(id)obj analyzationType:(AnalyzationType)type;

+ (NSString *)xpathForObj:(id)obj analyzationType:(AnalyzationType)type gesture:(UIGestureRecognizer *)gesture;

@end

NS_ASSUME_NONNULL_END
