//
//  UINavigationController+Consistent.m
//  RuntimeProDemo
//
//  Created by hnbwyh on 2018/2/1.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "UINavigationController+Consistent.h"
#import <objc/runtime.h>

@implementation UINavigationController (Consistent)

#pragma mark ------------------ load

+ (void)load {
    //-- Exchange the original implementation with our custom one.
    // push - safePush
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(pushViewController:animated:)), class_getInstanceMethod(self, @selector(safePushViewController:animated:)));
    
    // popVC - safePop
    // popToRootVC - safePopToRoot
    // popToVC - safePopToVC
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(popViewControllerAnimated:)), class_getInstanceMethod(self, @selector(safePopViewControllerAnimated:)));
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(popToRootViewControllerAnimated:)), class_getInstanceMethod(self, @selector(safePopToRootViewControllerAnimated:)));
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(popToViewController:animated:)), class_getInstanceMethod(self, @selector(safePopToViewController:animated:)));
    
    // didShowVC - safeDidShowVC
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(didShowViewController:animated:)), class_getInstanceMethod(self, @selector(safeDidShowViewController:animated:)));
    
}

#pragma mark ------------------

- (void)setViewTransitionInProgress:(BOOL)property {
    NSNumber *number = [NSNumber numberWithBool:property];
    objc_setAssociatedObject(self, ObjectTagKey, number , OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)isViewTransitionInProgress {
    NSNumber *number = objc_getAssociatedObject(self, ObjectTagKey);
    return [number boolValue];
}

#pragma mark ------------------ Intercept Pop, Push, PopToRootVC
/// @name Intercept Pop, Push, PopToRootVC

- (UIViewController *)safePopViewControllerAnimated:(BOOL)animated {
    if (self.viewTransitionInProgress) return nil;
    if (animated) {
        self.viewTransitionInProgress = YES;
    }
    //-- This is not a recursion, due to method swizzling the call below calls the original  method.
    return [self safePopViewControllerAnimated:animated];
}

- (NSArray *)safePopToRootViewControllerAnimated:(BOOL)animated {
    if (self.viewTransitionInProgress) return nil;
    if (animated) {
        self.viewTransitionInProgress = YES;
    }
    //-- This is not a recursion, due to method swizzling the call below calls the original  method.
    return [self safePopToRootViewControllerAnimated:animated];
}

- (NSArray *)safePopToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewTransitionInProgress) return nil;
    if (animated) {
        self.viewTransitionInProgress = YES;
    }
    //-- This is not a recursion, due to method swizzling the call below calls the original  method.
    return [self safePopToViewController:viewController animated:animated];
}

#pragma mark ------------------ Push

- (void)safePushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.delegate = self;
    //-- If we are already pushing a view controller, we dont push another one.
    if (self.isViewTransitionInProgress == NO) {
        //-- This is not a recursion, due to method swizzling the call below calls the original  method.
        [self safePushViewController:viewController animated:animated];
        if (animated) {
            self.viewTransitionInProgress = YES;
        }
    }
}

#pragma mark ------------------

// This is confirmed to be App Store safe.
// If you feel uncomfortable to use Private API, you could also use the delegate method navigationController:didShowViewController:animated:.
- (void)safeDidShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //-- This is not a recursion. Due to method swizzling this is calling the original method.
    [self safeDidShowViewController:viewController animated:animated];
    self.viewTransitionInProgress = NO;
}


// If the user doesnt complete the swipe-to-go-back gesture, we need to intercept it and set the flag to NO again.
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    id<UIViewControllerTransitionCoordinator> tc = navigationController.topViewController.transitionCoordinator;
    [tc notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.viewTransitionInProgress = NO;
        //--Reenable swipe back gesture.
        self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)viewController;
        [self.interactivePopGestureRecognizer setEnabled:YES];
    }];
    //-- Method swizzling wont work in the case of a delegate so:
    //-- forward this method to the original delegate if there is one different than ourselves.
    if (navigationController.delegate != self) {
        [navigationController.delegate navigationController:navigationController
                                     willShowViewController:viewController
                                                   animated:animated];
    }
}

@end
