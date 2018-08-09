//
//  DataManager.m
//  JXObjCategary
//
//  Created by hnbwyh on 2018/7/16.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "DataManager.h"
#import "Data1Model.h"

static NSString *kButton        = @"UIButton";
static NSString *kUILabel       = @"UILabel";
static NSString *kUIImage       = @"UIImage";

@implementation DataManager

-(NSMutableArray *)loadTitles{
    NSMutableArray *rlt = [NSMutableArray array];
    [rlt addObjectsFromArray:@[kButton,kUILabel,kUIImage]];
    return rlt;
}

-(NSMutableArray *)loadCntDetails{
    NSMutableArray *rlt = [NSMutableArray array];
    NSMutableArray *titles = [self loadTitles];
    for (NSInteger cou = 0; cou < titles.count; cou ++) {
        NSMutableArray *cntsData = [NSMutableArray new];
        if ([titles[cou] isEqualToString:kButton]) {
            for(NSInteger k = 0; k < [self cntDataForButton].count;k ++){
                Data1Model *f = [Data1Model new];
                f.cntDetail   = [self cntDataForButton][k];
                f.cellHeight  = [self caculateAutoHeightWithCnt:f.cntDetail defaultValue:66.0];
                [cntsData addObject:f];
            }
        }
        [rlt addObject:cntsData];
    }
    return rlt;
}

-(CGFloat)caculateAutoHeightWithCnt:(NSString *)cnt defaultValue:(CGFloat)defaultValue{
    CGFloat rlt = defaultValue;
    CGRect tmpRect = [cnt boundingRectWithSize:CGSizeMake(100, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil];
    rlt = tmpRect.size.height > defaultValue ? tmpRect.size.height : defaultValue;
    return rlt;
}

#pragma mark ------ private method

- (NSMutableArray *)cntDataForButton{
    NSMutableArray *cnt = [NSMutableArray new];
    [cnt addObjectsFromArray:@[@"",
                               @"",
                               @""]];
    return cnt;
}

@end
