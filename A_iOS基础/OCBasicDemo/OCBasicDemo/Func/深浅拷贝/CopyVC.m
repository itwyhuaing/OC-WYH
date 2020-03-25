//
//  CopyVC.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/10/23.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "CopyVC.h"

@interface CopyVC ()

// NSString 修饰
@property (nonatomic,strong) NSString               *stronString;
@property (nonatomic,copy)   NSString               *copString;

// NSArray 修饰
@property (nonatomic,strong) NSArray               *stronArr;
@property (nonatomic,copy)   NSArray               *copArr;

// NSDictionary 修饰
@property (nonatomic,strong) NSDictionary          *stronDic;
@property (nonatomic,copy)   NSDictionary          *copDic;

@end

@implementation CopyVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"=============== > NSString ");
    [self testNSStringProperty];
    NSLog(@"=============== > NSArray ");
    [self testNSArrayProperty];
    NSLog(@"=============== > NSDictionary ");
    [self testNSDictionaryProperty];
}

- (void)testNSStringProperty {
    /**
     NSString 类型属性使用 strong 修饰还是 copy 修饰 ？
     正解使用 copy 修饰。
     原因：strong 修饰情况下，普通赋值中默认为浅拷贝。如下代码 mutableString 赋值给 self.stronString 之后；倘若修改了 mutableString ，self.stronString 会被篡改。
     */
    NSString *testString = [NSString stringWithFormat:@"NSString%d",1];
    self.stronString = testString; // 浅拷贝
    self.copString   = testString; // 浅拷贝
    NSLog(@"\n\n 11 testString - %p \n\n",testString);
    NSLog(@"\n\n 11 self.stronString - %p \n\n",self.stronString);
    NSLog(@"\n\n 11 self.copString - %p \n\n",self.copString);
    // 修改之后发现 testString 存储地址也发生变化
    testString = @"testString";
    NSLog(@"\n修改testString\n %@:%p - %@:%p - %@:%p\n\n",testString,testString,self.stronString,self.stronString,self.copString,self.copString);
    
    
    NSMutableString *mutableString = [NSMutableString stringWithFormat:@"NSMutableString%d",2];
    self.stronString = mutableString; // 浅拷贝
    self.copString   = mutableString; // 深拷贝
    NSLog(@"\n\n 22 mutableString - %p \n\n",mutableString);
    NSLog(@"\n\n 22 self.stronString - %p \n\n",self.stronString);
    NSLog(@"\n\n 22 self.copString - %p \n\n",self.copString);
    // 修改方式1
    [mutableString appendString:@"appendString测试"];
    NSLog(@"\n修改mutableString方式1\n %@:%p - %@:%p - %@:%p\n\n",mutableString,mutableString,self.stronString,self.stronString,self.copString,self.copString);
    // 修改方式2
    NSMutableString *tst = [NSMutableString stringWithFormat:@"数据修改测试%d",00];
    mutableString = tst;
    NSLog(@"\n修改mutableString方式2\n %@:%p - %@:%p - %@:%p\n\n",mutableString,mutableString,self.stronString,self.stronString,self.copString,self.copString);
}

- (void)testNSArrayProperty {
    /**
    NSArray 类型属性使用 strong 修饰还是 copy 修饰 ？
    正解使用 copy 修饰 。
    原因：strong 修饰情况下，普通赋值中默认为浅拷贝。如下代码，mutableArr 作为原始数组内部元素修改以及新增元素之后，经 strong 修饰之后的属性也随之改变；然后经 copy 修饰的属性并不随之修改。
    */
    
    NSArray *arr = [NSArray arrayWithObjects:@"item0",@"item1",@"item2",@"item3", nil];
    self.stronArr = arr; // 浅拷贝
    self.copArr   = arr; // 浅拷贝
    NSLog(@"\n\n 11 arr - %p \n\n\n",arr);
    NSLog(@"\n\n 11 self.stronArr - %p \n\n\n",self.stronArr);
    NSLog(@"\n\n 11 self.copArr - %p \n\n\n",self.copArr);
    
    NSMutableArray *mutableArr = [NSMutableArray arrayWithObjects:@"mi0",@"mi1",@"mi2",@"mi3", nil];
    self.stronArr = mutableArr; // 浅拷贝
    self.copArr   = mutableArr; // 深拷贝
    NSLog(@"\n\n 22 mutableArr - %p \n\n\n",mutableArr);
    NSLog(@"\n\n 22 self.stronArr - %p \n\n\n",self.stronArr);
    NSLog(@"\n\n 22 self.copArr - %p \n\n\n",self.copArr);
    
    // 修改原始元素的第一个元素并在末尾添加一个元素
    mutableArr[0] = @"change";
    [mutableArr addObject:@"addObj"];
    NSLog(@"\n\n 原始数组 : %@ - %p \n\n",mutableArr,mutableArr[0]);
    NSLog(@"\n\n self.stronArr : %@ - %p  \n\n",self.stronArr,self.stronArr[0]);
    NSLog(@"\n\n  self.copArr : %@ - %p  \n\n",self.copArr,self.copArr[0]);
}

- (void)testNSDictionaryProperty {
    /**
     NSDictionary 类型属性使用 strong 修饰还是 copy 修饰 ？
     正解使用 copy 修饰 。
     */
    NSDictionary *dic = [NSDictionary dictionaryWithObject:@"obj" forKey:@"key"];
    self.stronDic = dic; // 浅拷贝
    self.copDic   = dic; // 浅拷贝
    
    NSLog(@"\n\n 11 dic - %p \n\n\n",dic);
    NSLog(@"\n\n 11 self.stronDic - %p \n\n\n",self.stronDic);
    NSLog(@"\n\n 11 self.copDic - %p \n\n\n",self.copDic);
    
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithObject:@"mutableObj" forKey:@"mutableKey"];
    self.stronDic = mutableDic; // 浅拷贝
    self.copDic   = mutableDic; // 深拷贝
    
    NSLog(@"\n\n 22 mutableDic - %p \n\n\n",mutableDic);
    NSLog(@"\n\n 22 self.stronDic - %p \n\n\n",self.stronDic);
    NSLog(@"\n\n 22 self.copDic - %p \n\n\n",self.copDic);
    
    [mutableDic removeObjectForKey:@"mutableKey"];
    
    NSLog(@"\n\n 33 mutableDic - %@ \n\n\n",mutableDic);
    NSLog(@"\n\n 33 self.stronDic - %@ \n\n\n",self.stronDic);
    NSLog(@"\n\n 33 self.copDic - %@ \n\n\n",self.copDic);
}

@end
