//
//  BlockTestVC.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/11/28.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "BlockTestVC.h"

@interface BlockTestVC ()

@property (nonatomic,strong) UILabel *label;

@end

@implementation BlockTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *l = [UILabel new];
    [l setFrame:CGRectMake(100, 100, 200, 80)];
    l.textColor = [UIColor redColor];
    l.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:l];
    self.label = l;
    self.label.text = @"原始数据000";
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self test5];
}

// 情景一 : 外部变量无 __block 修饰
/**
 此情景下：
 block 截获tmpCnt值之后，将生成一个新的指针指向该值所在的内存区域
 */
- (void)test1 {
    __weak typeof(self) weakSelf = self;
    NSString *tmpCnt = @"待测定数据111";
    NSLog(@"\n\n =========== 111-1 \n\n 内存地址 %p \n 指针地址 %x \n\n",tmpCnt,&tmpCnt);
    void (^btFunc)(NSString *txt) = ^void(NSString *msg) {
        NSLog(@"\n\n =========== 111-2 \n\n 内存地址 %p \n 指针地址 %x \n\n",tmpCnt,&tmpCnt);
        weakSelf.label.text = tmpCnt;
    };
    tmpCnt = @"已被修改的待测定数据111";
    NSLog(@"\n\n =========== 111-3 \n\n 内存地址 %p \n 指针地址 %x \n\n",tmpCnt,&tmpCnt);
    btFunc(tmpCnt);
}

// 情景二 : 外部变量有 __block 修饰
/**
此情景下：
block 将截获 变量
*/
- (void)test2 {
    __weak typeof(self) weakSelf = self;
    __block NSString *tmpCnt = @"待测定数据222";
    NSLog(@"\n\n =========== 222-1 \n\n 内存地址 %p \n 指针地址 %x \n\n",tmpCnt,&tmpCnt);
    void (^btFunc)(NSString *txt) = ^void(NSString *msg) {
        NSLog(@"\n\n =========== 222-2 \n\n 内存地址 %p \n 指针地址 %x \n\n",tmpCnt,&tmpCnt);
        weakSelf.label.text = tmpCnt;
    };
    tmpCnt = @"已被修改的待测定数据222";
    NSLog(@"\n\n =========== 333-3 \n\n 内存地址 %p \n 指针地址 %x \n\n",tmpCnt,&tmpCnt);
    btFunc(tmpCnt);
}

// 情景三 : 直接赋值
- (void)test3 {
    __weak typeof(self) weakSelf = self;
    void (^btFunc)(NSString *txt) = ^void(NSString *msg) {
        weakSelf.label.text = msg;
    };
    btFunc(@"已被修改的待测定数据333");
}

// 情景四 : 局部变量
/**
此情景下：
block 将截获 局部变量的z瞬时值
*/
- (void)test4 {
    int val_1 = 3;
    int (^bf) (int) = ^ int (int para){
        return val_1 * para;
    };
    val_1 = 5;
    int rlt = bf(2);
    printf("\n\n test4 :%d \n\n",rlt);
}

// 情景五 : 静态全局变量
/**
此情景下：
block 将截获 指向静态变量的指针
*/
- (void)test5 {
    static int val_1 = 3;
    int (^bf) (int) = ^ int (int para){
        return val_1 * para;
    };
    val_1 = 5;
    int rlt = bf(2);
    printf("\n\n test5 :%d \n\n",rlt);
}

@end
