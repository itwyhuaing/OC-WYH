//
//  HNBTribePickerView.h
//  hinabian
//
//  Created by hnbwyh on 2017/8/15.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNBTribePickerView;
@protocol HNBTribePickerViewDelegate <NSObject>
@optional
- (void)didSelectedHNBTribePickerView:(id)origin;

@end

@interface HNBTribePickerView : UIView

@property (nonatomic,weak) id<HNBTribePickerViewDelegate> delegate;

- (void)updateDisplayTribeName:(NSString *)displayTribeName;

@end
