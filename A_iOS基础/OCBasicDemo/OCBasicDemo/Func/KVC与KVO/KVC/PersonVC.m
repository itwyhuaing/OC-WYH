//
//  PersonVC.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/10/25.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "PersonVC.h"

@interface Student : NSObject

@property (nonatomic,copy) NSString *name;

@property (nonatomic,assign) NSInteger age;

@end

@implementation Student

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end

@interface PersonVC ()

@end

@implementation PersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    Student *s1 = [Student new];
    s1.name = @"rs1";
    s1.age  = 30;
    
    Student *s2 = [Student new];
    s2.name = @"cs2";
    s2.age  = 36;
    
    Student *s3 = [Student new];
    s3.name = @"as3";
    s3.age  = 23;
    
    Student *s4 = [Student new];
    s4.name = @"bs4";
    s4.age  = 10;
    
    Student *s5 = [Student new];
    s5.name = @"ds5";
    s5.age  = 30;
    
    NSArray *ss = @[s1,s2,s3,s4,s5];
    NSArray *tmp_s = @[];//[ss valueForKeyPath:@"@distinctUnionOfObjects"];
    NSArray *tmp_age = [ss valueForKeyPath:@"@distinctUnionOfObjects.age"];
    NSArray *tmp_name = [ss valueForKeyPath:@"@distinctUnionOfObjects.name"];
    NSLog(@"\n\n distinctUnionOfObjects \n tmp_s :%@ \n  tmp_age :%@ \n  tmp_name :%@ \n\n",tmp_s,tmp_age,tmp_name);
    NSArray *_tmp_s = @[];//[ss valueForKeyPath:@"@unionOfObjects"];
    NSArray *_tmp_age = [ss valueForKeyPath:@"@unionOfObjects.age"];
    NSArray *_tmp_name = [ss valueForKeyPath:@"@unionOfObjects.name"];
    NSLog(@"\n\n unionOfObjects \n _tmp_s :%@ \n  _tmp_age :%@ \n  _tmp_name :%@ \n\n",_tmp_s,_tmp_age,_tmp_name);
    
    NSNumber *min = [ss valueForKeyPath:@"@min.age"];
    NSNumber *max = [ss valueForKeyPath:@"@max.age"];
    NSNumber *avg = [ss valueForKeyPath:@"@avg.age"];
    NSNumber *sum = [ss valueForKeyPath:@"@sum.age"];
    NSNumber *count = [ss valueForKeyPath:@"@count"];
    NSLog(@"\n\n min : %f \n max : %f \n avg : %f \n sum : %f \n count : %ld \n\n",min.floatValue,max.floatValue,avg.floatValue,sum.floatValue,count.integerValue);
    
}

@end
