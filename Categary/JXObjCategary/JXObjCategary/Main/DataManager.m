//
//  DataManager.m
//  JXObjCategary
//
//  Created by hnbwyh on 2018/7/16.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "DataManager.h"
#import "Data1Model.h"

@implementation DataManager

-(NSMutableArray *)loadTitles{
    NSMutableArray *rlt = [NSMutableArray array];
    [rlt addObjectsFromArray:@[@"UIButton",@"UILabel",@"UIImage"]];
    return rlt;
}

-(NSMutableArray *)loadCntDetails{
    NSMutableArray *rlt = [NSMutableArray array];
    NSMutableArray *titles = [self loadTitles];
    for (NSInteger cou = 0; cou < titles.count; cou ++) {
        if ([titles[cou] isEqualToString:@"UIButton"]) {
            Data1Model *f = [Data1Model new];
            f.cntDetail   = @"防连击";
            f.cellHeight  = 66.0;
            [rlt addObject:f];
        }
    }
    return rlt;
}

-(NSMutableArray *)loadListDataSource{
    NSMutableArray *rlt = [NSMutableArray array];
    [rlt addObject:[self loadTitles]];
    [rlt addObject:[self loadCntDetails]];
    return rlt;
}

-(CGFloat)caculateAutoHeightWithCnt:(NSString *)cnt defaultValue:(CGFloat)defaultValue{
    CGFloat rlt = defaultValue;
    CGRect tmpRect = [cnt boundingRectWithSize:CGSizeMake(100, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil];
    rlt = tmpRect.size.height;
    return rlt;
}

@end
