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
static NSString *kUIFont        = @"kUIFont";


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
        
        // kUIFont
        if ([titles[cou] isEqualToString:kUIFont]) {
            for(NSInteger k = 0; k < [self cntDataForFont].count;k ++){
                Data1Model *f = [Data1Model new];
                f.cntDetail   = [self cntDataForFont][k];
                f.cellHeight  = [self caculateAutoHeightWithCnt:f.cntDetail defaultValue:30.0];
                [cntsData addObject:f];
            }
        }
        
        [rlt addObject:cntsData];
    }
    return rlt;
}

// section 对应 VC - 与 标题对应
-(NSMutableArray *)loadShowVCS{
    NSMutableArray *rlt = [NSMutableArray new];
    [rlt addObjectsFromArray:@[@"JXViewVC",@"JXColorVC",@"JXImageVC",@"JXFontVC"]];
    return rlt;
}

#pragma mark ------ private method

// section
- (NSMutableArray *)titlesData{
    NSMutableArray *ts = [NSMutableArray new];
    [ts addObjectsFromArray:@[kUIView,kColor,kUIImage,kUIFont,kButton]];
    return ts;
}

// section - cell
- (NSMutableArray *)cntDataForView{
    NSMutableArray *cnt = [NSMutableArray new];
    [cnt addObjectsFromArray:@[@"卡片样式、颜色单方向渐变"]];
    return cnt;
}

- (NSMutableArray *)cntDataForColor{
    NSMutableArray *cnt = [NSMutableArray new];
    [cnt addObjectsFromArray:@[@"RGB 样式 或 16 进制方式设置颜色",@"依据图片获取颜色",@"依据图片上的位置获取颜色"]];
    return cnt;
}

- (NSMutableArray *)cntDataForImage{
    NSMutableArray *cnt = [NSMutableArray new];
    [cnt addObjectsFromArray:@[@"将给定的图片处理为自定义大小的图片",@"依据给定的颜色生产图片"]];
    return cnt;
}


- (NSMutableArray *)cntDataForButton{
    NSMutableArray *cnt = [NSMutableArray new];
    [cnt addObjectsFromArray:@[@"防连击属性"]];
    return cnt;
}

- (NSMutableArray *)cntDataForFont{
    NSMutableArray *cnt = [NSMutableArray new];
    [cnt addObjectsFromArray:@[@"动态下载字体"]];
    return cnt;
}

// 计算自适应高度
-(CGFloat)caculateAutoHeightWithCnt:(NSString *)cnt defaultValue:(CGFloat)defaultValue{
    CGFloat rlt = defaultValue;
    CGRect tmpRect = [cnt boundingRectWithSize:CGSizeMake(100, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16.0]} context:nil];
    rlt = tmpRect.size.height > defaultValue ? tmpRect.size.height : defaultValue;
    return rlt;
}

@end
