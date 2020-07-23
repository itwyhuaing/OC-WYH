//
//  ShowWebVC.h
//  JXRichTextDemo
//
//  Created by hnbwyh on 2019/4/19.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShowWebVC : UIViewController

- (void)showWebWithHTMLBody:(NSString *)bodyContent isWkWeb:(BOOL)isWkWeb;

@end

NS_ASSUME_NONNULL_END
