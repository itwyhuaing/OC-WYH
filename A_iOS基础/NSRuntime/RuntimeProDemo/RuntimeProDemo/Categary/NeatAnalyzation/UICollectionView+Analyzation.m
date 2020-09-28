//
//  UICollectionView+Analyzation.m
//  RuntimeProDemo
//
//  Created by hnbwyh on 2020/8/18.
//  Copyright © 2020 ZhiXingJY. All rights reserved.
//

#import "UICollectionView+Analyzation.h"

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
    [self analyzation_collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    NSLog(@"\n\nhooktest-analyzation_collectionView:%@ \n\n",self);
    [XpathParser xpathForObj:[collectionView cellForItemAtIndexPath:indexPath] analyzationType:AnalyzationUICollectionViewType];
}

@end
