//
//  UIView+Layout.h
//
//  Created by 谭真 on 15/2/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HNBOscillatoryAnimationToBigger,
    HNBOscillatoryAnimationToSmaller,
} HNBOscillatoryAnimationType;

@interface UIView (HNBLayout)

@property (nonatomic) CGFloat hnb_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat hnb_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat hnb_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat hnb_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat hnb_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat hnb_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat hnb_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat hnb_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint hnb_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  hnb_size;        ///< Shortcut for frame.size.

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(HNBOscillatoryAnimationType)type;

@end
