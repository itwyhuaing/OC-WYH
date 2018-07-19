
//
//  EncodeVC.m
//  LXYHOCFunctionsDemo
//
//  Created by hnbwyh on 17/6/8.
//  Copyright © 2017年 lachesismh. All rights reserved.
//

#import "EncodeVC.h"
#import "PersonInfo.h"

@interface EncodeVC ()

@end

@implementation EncodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.displayLabel.text = @" 1> 点击启动按钮 \n \n \n 2>观察沙盒路径文件变化 \n \n \n 3> 该部分需要了解 Runtime 相关知识";
}

-(void)rightNavBtnEvent:(UIButton *)btn{

    NSDictionary *math = @{
                           @"subName":@"Math",
                           @"subID":@"S_150"
                           };
    NSDictionary *english = @{
                           @"subName":@"English",
                           @"subID":@"E_150"
                           };
    PersonInfo *f = [PersonInfo new];
    f.name = @"wyh";
    f.age = 18;
    f.subs = @[math,english];
    f.classRoom = @{
                    @"grade1":@"room100",
                    @"grade2":@"room200",
                    @"grade3":@"room300"
                    };
    NSString *filePath = [YHFileOperator filePathForFileName:@"archeveFile.plist"];
    // 归档
    [NSKeyedArchiver archiveRootObject:f toFile:filePath];
    
    // 解档
    PersonInfo *rf = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"name:%@ - age:%ld - subs:%@ - classRoom:%@",rf.name,rf.age,rf.subs,rf.classRoom);
    
}


@end
