//
//  UICollectionView+Analyzation.m
//  RuntimeProDemo
//
//  Created by hnbwyh on 2020/8/18.
//  Copyright © 2020 ZhiXingJY. All rights reserved.
//

#import "UICollectionView+Analyzation.h"

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


@implementation UICollectionView (Analyzation)

+(void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originMethod = class_getInstanceMethod([self class], @selector(setDelegate:));
        Method newMethod = class_getInstanceMethod([self class], @selector(analyzation_setDelegate:));
        method_exchangeImplementations(originMethod, newMethod);
    });
}

-(void)analyzation_setDelegate:(id<UICollectionViewDelegate>)delegate {
    SEL originalSEL = @selector(collectionView:didSelectItemAtIndexPath:);
    SEL newSEL = @selector(analyzation_collectionView:didSelectItemAtIndexPath:);
    Hook_Method([delegate class], originalSEL, [self class], newSEL, originalSEL);
    
    [self analyzation_setDelegate:delegate];
}

- (void)analyzation_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"\n\n 拦截analyzation_collectionView:%@ \n\n",self);
    [self analyzation_collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    [XpathParser xpathForView:cell];
}

@end
