//
//  KVCController.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/10/24.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "KVCController.h"
#import "KVCObj.h"
#import "PageControlVC.h"

@interface KVCController ()

@end

@implementation KVCController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self test2];
}

- (void)test1 {
    KVCObj *obj = [KVCObj new];
    
    NSLog(@"\n ====== 常规设置 value ====== \n");
    // 常规设置 value
    [obj setValue:@"string" forKey:@"testString"];
    [obj setValue:@[@"item0",@"item1"] forKey:@"testArr"];
    [obj setValue:[NSDate date] forKey:@"dt"];
    NSLog(@"\n %@ \n %@ \n %@ \n %@ \n",obj.testString,obj.testArr,@"整型",obj.dt);
    NSLog(@"\n %@ \n %@ \n %@ \n %@ \n",[obj valueForKey:@"testString"],[obj valueForKey:@"testArr"],@"整型",[obj valueForKey:@"dt"]);
    
    NSLog(@"\n ====== value 不存在 ====== \n");
    // value 不存在
    [obj setValue:@"测试" forKey:@"key68"];
    NSLog(@"\n ===> %@ \n",[obj valueForKey:@"key68"]);
    
    NSLog(@"\n ====== value 类型变换 ====== \n");
    // value 类型变换
    [obj setValue:[NSNumber numberWithInt:1] forKey:@"testInteger"];
    NSLog(@"\n 类型变换 NSNumber : %@ - %@ \n",[obj valueForKey:@"testInteger"],[[obj valueForKey:@"testInteger"] class]);
    
    
    NSLog(@"\n ====== 给私有成员变量和私有属性赋值 ====== \n");
    // 给私有成员变量和私有属性赋值
    [obj setValue:@"王生" forKey:@"name"];
    [obj setValue:@"中国广东深圳" forKey:@"address"];
    [obj printPrivateInfo];
}

// 修改 UI
- (void)test2 {
    [self.navigationController pushViewController:[PageControlVC new] animated:TRUE];
}

@end
