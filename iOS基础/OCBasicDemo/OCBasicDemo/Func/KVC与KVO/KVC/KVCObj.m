//
//  KVCObj.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/10/24.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "KVCObj.h"

@interface KVCObj ()
{
    NSString *_name;
}

@property (nonatomic,copy) NSString *address;

@end



@implementation KVCObj

-(void)setTestString:(NSString *)testString {
    _testString = testString;
    NSLog(@"\n %s \n",__FUNCTION__);
}

-(void)setTestArr:(NSArray *)testArr {
    _testArr = testArr;
    NSLog(@"\n %s \n",__FUNCTION__);
}

-(void)setTestInteger:(NSInteger)testInteger {
    _testInteger = testInteger;
    NSLog(@"\n %s \n",__FUNCTION__);
}

-(void)setDt:(NSDate *)dt {
    _dt = dt;
    NSLog(@"\n %s \n",__FUNCTION__);
}



-(id)valueForUndefinedKey:(NSString *)key {
    NSLog(@"\n %s \n %@ \n",__FUNCTION__,key);
    return @"undefine";
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"\n %s \n %@ \n",__FUNCTION__,key);
}

- (void)printPrivateInfo {
    NSLog(@"\n\n _name :%@ \n self.address :%@ \n\n",_name,self.address);
}

@end
