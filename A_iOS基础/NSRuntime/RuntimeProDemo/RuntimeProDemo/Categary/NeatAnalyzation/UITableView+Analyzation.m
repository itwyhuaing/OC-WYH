//
//  UITableView+Analyzation.m
//  hinabian
//
//  Created by hnbwyh on 2020/8/14.
//  Copyright © 2020 深圳市海那边科技有限公司. All rights reserved.
//

#import "UITableView+Analyzation.h"

@implementation UITableView (Analyzation)

+ (void)load {
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method originMethod = class_getInstanceMethod([self class], @selector(setDelegate:));
//        Method newMethod = class_getInstanceMethod([self class], @selector(analyzation_setDelegate:));
//        method_exchangeImplementations(originMethod, newMethod);
//    });
    
}

- (void)analyzation_setDelegate:(id<UITableViewDelegate>)delegate {

    //NSLog(@"******** HookUITableView -  analyzation_setDelegate: %@ ",delegate);
    SEL originalSEL = @selector(tableView:didSelectRowAtIndexPath:);
    SEL newSEL = @selector(analyzation_tableView:didSelectRowAtIndexPath:);

    Hook_Method([delegate class], originalSEL, [self class], newSEL, originalSEL);
    
    
    [self analyzation_setDelegate:delegate];
}

#pragma mark - exchangeMethod

// 代理实现了方法, 进行
- (void)analyzation_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self analyzation_tableView:tableView didSelectRowAtIndexPath:indexPath];
    NSLog(@"\n\nhooktest-analyzation_tableView:%@ \n\n",self);
    [XpathParser xpathForObj:[tableView cellForRowAtIndexPath:indexPath] analyzationType:AnalyzationUITableViewType];
    
}

@end
