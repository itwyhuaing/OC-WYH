//
//  MovieCell.h
//  数据库Demo
//
//  Created by vera on 15-4-3.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

//赋值
- (void)setModel:(Movie *)movie;

- (void)setTitle:(NSString *)title;

@end
