//
//  DataManager.m
//  JXObjCategary
//
//  Created by hnbwyh on 2018/7/16.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "DataManager.h"
#import "Data1Model.h"

static NSString *kUIView        = @"kUIView";
static NSString *kColor         = @"kColor";
static NSString *kUIImage       = @"kUIImage";
static NSString *kButton        = @"kButton";
static NSString *kUILabel       = @"kUILabel";


@implementation DataManager

#pragma mark ------ publick load data

-(NSMutableArray *)loadTitles{
    return [self titlesData];
}

-(NSMutableArray *)loadCntDetails{
    NSMutableArray *rlt = [NSMutableArray array];
    NSMutableArray *titles = [self loadTitles];
    for (NSInteger cou = 0; cou < titles.count; cou ++) {
        NSMutableArray *cntsData = [NSMutableArray new];
        // kUIView
        if ([titles[cou] isEqualToString:kUIView]) {
            for(NSInteger k = 0; k < [self cntDataForView].count;k ++){
                Data1Model *f = [Data1Model new];
                f.cntDetail   = [self cntDataForView][k];
                f.cellHeight  = [self caculateAutoHeightWithCnt:f.cntDetail defaultValue:30.0];
                [cntsData addObject:f];
            }
        }
        
        // kColor
        if ([titles[cou] isEqualToString:kColor]) {
            for(NSInteger k = 0; k < [self cntDataForColor].count;k ++){
                Data1Model *f = [Data1Model new];
                f.cntDetail   = [self cntDataForColor][k];
                f.cellHeight  = [self caculateAutoHeightWithCnt:f.cntDetail defaultValue:30.0];
                [cntsData addObject:f];
            }
        }
        
        // kUIImage
        if ([titles[cou] isEqualToString:kUIImage]) {
            for(NSInteger k = 0; k < [self cntDataForImage].count;k ++){
                Data1Model *f = [Data1Model new];
                f.cntDetail   = [self cntDataForImage][k];
                f.cellHeight  = [self caculateAutoHeightWithCnt:f.cntDetail defaultValue:30.0];
                [cntsData addObject:f];
            }
        }
        
        // kButton
        if ([titles[cou] isEqualToString:kButton]) {
            for(NSInteger k = 0; k < [self cntDataForButton].count;k ++){
                Data1Model *f = [Data1Model new];
                f.cntDetail   = [self cntDataForButton][k];
                f.cellHeight  = [self caculateAutoHeightWithCnt:f.cntDetail defaultValue:30.0];
                [cntsData addObject:f];
            }
        }
        
        // kUILabel
        
        // kUIImage
        
        [rlt addObject:cntsData];
    }
    return rlt;
}

-(NSMutableArray *)loadShowVCS{
    NSMutableArray *rlt = [NSMutableArray new];
    [rlt addObjectsFromArray:@[@"JXViewVC",@"JXColorVC",@"JXImageVC"]];
    return rlt;
}

#pragma mark ------ private method


- (NSMutableArray *)titlesData{
    NSMutableArray *ts = [NSMutableArray new];
    [ts addObjectsFromArray:@[kUIView,kColor,kUIImage,kButton,kUILabel]];
    return ts;
}

- (NSMutableArray *)cntDataForView{
    NSMutableArray *cnt = [NSMutableArray new];
    [cnt addObjectsFromArray:@[@"111",@"222"]];
    return cnt;
}

- (NSMutableArray *)cntDataForColor{
    NSMutableArray *cnt = [NSMutableArray new];
    [cnt addObjectsFromArray:@[@"111",@"222"]];
    return cnt;
}

- (NSMutableArray *)cntDataForImage{
    NSMutableArray *cnt = [NSMutableArray new];
    [cnt addObjectsFromArray:@[@"111",@"222"]];
    return cnt;
}


- (NSMutableArray *)cntDataForButton{
    NSMutableArray *cnt = [NSMutableArray new];
    [cnt addObjectsFromArray:@[@"111",@"222"]];
    return cnt;
}

-(CGFloat)caculateAutoHeightWithCnt:(NSString *)cnt defaultValue:(CGFloat)defaultValue{
    CGFloat rlt = defaultValue;
    CGRect tmpRect = [cnt boundingRectWithSize:CGSizeMake(100, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil];
    rlt = tmpRect.size.height > defaultValue ? tmpRect.size.height : defaultValue;
    return rlt;
}

@end
