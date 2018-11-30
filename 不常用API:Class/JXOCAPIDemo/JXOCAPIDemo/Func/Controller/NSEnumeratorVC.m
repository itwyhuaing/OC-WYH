//
//  NSEnumeratorVC.m
//  JXOCAPIDemo
//
//  Created by hnbwyh on 2018/11/29.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "NSEnumeratorVC.h"

@interface NSEnumeratorVC ()

@end

@implementation NSEnumeratorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@" \n\n========================> NSArray\n\n");
    {
        NSArray *array = @[@"66",@"77",@"heih刚刚ei",@"方法",@"得当",@"分公司法规"];
        NSEnumerator *enumer = [array objectEnumerator];
        id obj = [enumer nextObject];
        NSLog(@"\n正序:");
        while (obj) {
            NSLog(@"%@,",obj);
            obj = [enumer nextObject];
        }
        
        NSEnumerator *reverseEnumer = [array reverseObjectEnumerator];
        id reverseObj = [reverseEnumer nextObject];
        NSLog(@"\n逆序:");
        while (reverseObj) {
            NSLog(@"%@,",reverseObj);
            reverseObj = [reverseEnumer nextObject];
        }
    }
    NSLog(@" \n\n========================> NSDictionary \n\n");
    {
        NSDictionary *dict = @{@"name":@"33",@"age":@(55),@"height":@(189.5),@"weight":@(60)};
        NSEnumerator *kenumer = [dict keyEnumerator];
        id obj = [kenumer nextObject];
        NSLog(@"key:\n");
        while (obj) {
            NSLog(@"%@,",obj);
            obj = [kenumer nextObject];
        }
        NSEnumerator *venumer = [dict objectEnumerator];
        id value = [venumer nextObject];
        NSLog(@" value :\n");
        while (value) {
            NSLog(@" %@,",value);
            value = [venumer nextObject];
        }
    }
    NSLog(@" \n\n========================> NSSet \n\n");
    {
        NSSet *set = [[NSSet alloc]initWithObjects:@"name",@"age",@"height",@"weight",@"class",nil];
        NSEnumerator *enmuer = [set objectEnumerator];
        id obj = [enmuer nextObject];
        NSLog(@"obj :\n");
        while (obj) {
            NSLog(@"%@,",obj);
            obj = [enmuer nextObject];
        }
    }
}

@end
