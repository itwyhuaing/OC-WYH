//
//  A0ClvCell.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2020/6/24.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import "A0ClvCell.h"

@implementation A0ClvCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor cyanColor];
        self.themLabel.backgroundColor = [UIColor orangeColor];
        self.layer.borderColor = [UIColor blueColor].CGColor;
        self.layer.borderWidth = 1.0;
        [self.contentView addSubview:self.themLabel];
    }
    return self;
}

- (UILabel *)themLabel {
    if (!_themLabel) {
        CGRect rect = self.bounds;
        _themLabel = [[UILabel alloc] initWithFrame:rect];
        _themLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _themLabel;
}

@end
