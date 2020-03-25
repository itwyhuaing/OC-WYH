//
//  DataOperator.m
//  CoreDataPro
//
//  Created by hnbwyh on 2018/8/7.
//  Copyright © 2018年 TongXing. All rights reserved.
//

#import "DataOperator.h"
#import "PersonalInfo+CoreDataClass.h"

@implementation DataOperator


#pragma mark - 加载数据

- (void)loadDataSource{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"model" ofType:@"md"];
    NSData   *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers
                                                          error:nil];
    NSDictionary *dataDic = dic ? [dic valueForKey:@"data"] : [NSDictionary new];
    PersonalInfo *f = [PersonalInfo MR_createEntity];
    [f MR_importValuesForKeysWithObject:dataDic];
    NSLog(@"");
}


@end
