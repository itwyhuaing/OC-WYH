//
//  UIScrollView+Analyzation.m
//  hinabian
//
//  Created by hnbwyh on 2020/8/14.
//  Copyright © 2020 深圳市海那边科技有限公司. All rights reserved.
//

#import "UIScrollView+Analyzation.h"

@implementation UIScrollView (Analyzation)

+(void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method originMethod = class_getInstanceMethod([self class], @selector(setDelegate:));
//        Method newMethod = class_getInstanceMethod([self class], @selector(analyzation_setDelegate:));
//        method_exchangeImplementations(originMethod, newMethod);
//    });
}


-(void)analyzation_setDelegate:(id<UIScrollViewDelegate>)delegate {
    SEL originalSEL = @selector(scrollViewDidEndDecelerating:);
    SEL newSEL = @selector(analyzation_scrollViewDidEndDecelerating:);
    Hook_Method([delegate class], originalSEL, [self class], newSEL, originalSEL);
    
    [self analyzation_setDelegate:delegate];
}


- (void)analyzation_scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self analyzation_scrollViewDidEndDecelerating:scrollView];
    NSLog(@"\n\n hooktest-analyzation_scrollViewDidEndDecelerating:%@ \n\n",self);
    //[XpathParser xpathForObj:scrollView];
}

@end
