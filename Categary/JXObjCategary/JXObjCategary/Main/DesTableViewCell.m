//
//  DesTableViewCell.m
//  JXObjCategary
//
//  Created by hnbwyh on 2018/7/16.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "DesTableViewCell.h"

@implementation DesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
//        _desDetail      = [[UILabel alloc] init];
//        CGRect rect     = CGRectZero;
//        rect.size       = self.frame.size;
//        [_desDetail setFrame:rect];
//        [self.contentView addSubview:_desDetail];
//        
//        _desDetail.backgroundColor = [UIColor greenColor];
//        _desDetail.numberOfLines = 0;
//        _desDetail.font = [UIFont systemFontOfSize:15.0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
