//
//  TupleVC.m
//  RACDemo
//
//  Created by hnbwyh on 2019/5/7.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "TupleVC.h"

@interface TupleVC ()

@end

@implementation TupleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass(self.class);
    [self test];
}

- (void)test {
    RACTuple *tp1 = [RACTuple tupleWithObjectsFromArray:@[@"t1",@"t2",@"t3",@"t4",@"t5"]];
    RACTuple *tp2 = [RACTuple tupleWithObjects:@"t1",@"t2",@"t3",@"t4",@"t5", nil];
    RACTuple *tp3 = RACTuplePack(@"t1",@"t2",@"t3",@"t4",@"t5");
    NSLog(@"\n tp1 \n %@ \n",tp1.first);
    NSLog(@"\n tp2 \n %@ \n",tp2[2]);
    NSLog(@"\n tp3 \n %@ \n",tp3.last);
}

@end
