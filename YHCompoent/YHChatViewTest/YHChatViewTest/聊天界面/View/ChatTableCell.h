//
//  ChatTableCell.h
//  LXYHOCFunctionsDemo
//
//  Created by wyh on 15/11/27.
//  Copyright © 2015年 lachesismh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MessageManager.h"

@interface ChatTableCell : UITableViewCell

@property (nonatomic,retain) MessageManager *msgManager;

@end
