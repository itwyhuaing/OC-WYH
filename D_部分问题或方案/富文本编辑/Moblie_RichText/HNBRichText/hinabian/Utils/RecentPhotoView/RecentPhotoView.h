//
//  RecentPhotoView.h
//  hinabian
//
//  Created by 何松泽 on 2017/8/2.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HNBAssetModel;

@interface RecentPhotoView : UIView

@property (nonatomic, copy)void (^didFinishPickingPhoto)(NSArray<HNBAssetModel *> *modelArr);

-(instancetype)initWithFrame:(CGRect)frame
         superViewController:(UIViewController *)superViewController;

-(void)showRecentPhoto;
-(void)hideRecentPhoto;
//限制选图数
-(void)setLimitedChose:(NSUInteger)limitedCount;

@end
