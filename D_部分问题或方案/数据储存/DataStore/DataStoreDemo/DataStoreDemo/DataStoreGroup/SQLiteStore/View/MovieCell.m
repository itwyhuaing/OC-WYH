//
//  MovieCell.m
//  数据库Demo
//
//  Created by vera on 15-4-3.
//  Copyright (c) 2015年 vera. All rights reserved.
//

#import "MovieCell.h"
#import "UIImageView+WebCache.h"

@implementation MovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

//赋值
- (void)setModel:(Movie *)movie
{
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:movie.imageUrlString] placeholderImage:[UIImage imageNamed:@"photo"]];
    self.titleLabel.text = movie.name;
}

-(void)setTitle:(NSString *)title{
    self.titleLabel.text = title;
    self.iconImageView.image = nil;
}

@end
