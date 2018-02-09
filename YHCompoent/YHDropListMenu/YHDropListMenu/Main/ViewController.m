//
//  ViewController.m
//  YHDropListMenu
//
//  Created by hnbwyh on 2018/2/9.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "ViewController.h"
#import "AnnimationTestController.h"
#import "DropListMenu.h"

@interface ViewController ()<DropListMenuDelegate>
{
    DropListMenu *dropMenu;
    
    NSArray *titles;
    
    NSArray *listData;
    
    UILabel *lable;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"下拉菜单";
    self.view.backgroundColor = [UIColor whiteColor];
    
    titles = @[@"热菜",@"凉菜1",@"汤1",@"凉菜2",@"汤2"];
    listData = @[
                 @[@"000",@"001",@"002",@"003",@"004"],
                 @[@"10",@"11",@"12"],
                 @[@"20",@"21",@"22"],
                 @[@"30",@"31",@"32"],
                 @[@"40"]
                 ];
    
    dropMenu = [[DropListMenu alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 40) superView:self.view delegate:self];
    dropMenu.backgroundColor = [UIColor greenColor];
    
    
    
    CGRect rect = self.view.bounds;
    rect.size = CGSizeMake(300, 60);
    rect.origin.x = ([UIScreen mainScreen].bounds.size.width - rect.size.width) / 2.0;
    rect.origin.y = 200;
    lable = [[UILabel alloc] initWithFrame:rect];
    lable.text = @"测试";
    lable.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:lable];
    
    
//    [self test];
}


#pragma mark - DropListMenuDelegate

- (NSArray *)dropListMenu:(DropListMenu *)dropListMenu section:(NSInteger)section{
    return listData[section];
}


- (NSArray *)dropListMenu:(DropListMenu *)dropListMenu titlesForSection:(NSInteger)section{
    return titles;
}


- (void)dropListMenu:(DropListMenu *)dropListMenu section:(NSInteger)section didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    lable.text = [NSString stringWithFormat:@"选中菜单项 %ld section %ld row",section,indexPath.item];
}

- (void)test{
    
    [self.navigationController pushViewController:[[AnnimationTestController alloc] init] animated:YES];
    
}



@end
