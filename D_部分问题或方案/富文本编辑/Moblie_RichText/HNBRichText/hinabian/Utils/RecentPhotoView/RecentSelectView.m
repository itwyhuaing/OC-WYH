//
//  RecentSelectView.m
//  hinabian
//
//  Created by 何松泽 on 2017/8/14.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import "RecentSelectView.h"

@implementation RecentSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = frame.size.width/2;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        _numLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_numLabel setTextAlignment:NSTextAlignmentCenter];
        [_numLabel setFont:[UIFont systemFontOfSize:17.f]];
        [_numLabel setTextColor:[UIColor whiteColor]];
        [self addSubview:_numLabel];
        
    }
    return self;
}

- (void)cancelChoose {
    self.numLabel.hidden = YES;
    [self setBackgroundColor:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.3f]];
}

@end
