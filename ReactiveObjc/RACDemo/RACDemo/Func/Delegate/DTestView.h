//
//  DTestView.h
//  RACDemo
//
//  Created by hnbwyh on 2019/5/5.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DTestView : UIView

@property (nonatomic,strong) RACSubject *delegateSignal;

@end

NS_ASSUME_NONNULL_END
