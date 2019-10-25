//
//  JXBaseVC.h
//  JXObjCategary
//
//  Created by hnbwyh on 2018/8/9.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXBaseVC : UIViewController

@property (nonatomic,assign) CGFloat sw;
@property (nonatomic,assign) CGFloat sh;

// 内容
@property (nonatomic,strong) UIScrollView *cntV;

@end
