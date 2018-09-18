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
        [self addConstraints];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addConstraints{
    UILabel *des            = self.desDetail;
    NSString *hVFL          = @"H:|-0-[des]-0-|";
    NSString *vVFL          = @"V:|-0-[des]-0-|";
    NSArray  *hCons         = [NSLayoutConstraint constraintsWithVisualFormat:hVFL options:0 metrics:nil views:@{@"des":des}];
    NSArray  *vCons         = [NSLayoutConstraint constraintsWithVisualFormat:vVFL options:0 metrics:nil views:@{@"des":des}];
    [self.contentView addConstraints:hCons];
    [self.contentView addConstraints:vCons];
}


-(UILabel *)desDetail{
    if (!_desDetail) {
        _desDetail = [[UILabel alloc] init];
        _desDetail.lineBreakMode                                    = NSLineBreakByCharWrapping;
        _desDetail.numberOfLines                                    = 0;
        _desDetail.font                                             = [UIFont systemFontOfSize:16.0];
        _desDetail.translatesAutoresizingMaskIntoConstraints        = FALSE;
        //_desDetail.backgroundColor                                  = [UIColor greenColor];
        [self.contentView addSubview:_desDetail];
    }
    return _desDetail;
}

@end
