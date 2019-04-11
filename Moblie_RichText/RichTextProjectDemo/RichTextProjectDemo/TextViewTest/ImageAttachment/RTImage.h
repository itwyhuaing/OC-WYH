//
//  RTImage.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/11.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RTImage : UIImage

@property (nonatomic,copy)      NSString    *uniqueID;

@property (nonatomic,strong)    NSURL       *loadedLink;

@end

NS_ASSUME_NONNULL_END
