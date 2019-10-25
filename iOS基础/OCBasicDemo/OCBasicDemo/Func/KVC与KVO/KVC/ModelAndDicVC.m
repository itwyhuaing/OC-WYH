//
//  ModelAndDicVC.m
//  OCBasicDemo
//
//  Created by hnbwyh on 2019/10/25.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "ModelAndDicVC.h"

@interface TstDicModel : NSObject

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSArray  *items;

@property (nonatomic,assign) NSInteger age;

@end

@implementation TstDicModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

@end



@interface ModelAndDicVC ()

@end

@implementation ModelAndDicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    TstDicModel *f = [TstDicModel new];
    f.name = @"名字";
    f.age  = 36;
    f.items= @[@"数学",@"英语",@"语文",@"自然科学",@"思想品德"];
    // 模型转字典
    NSDictionary *dic = [f dictionaryWithValuesForKeys:@[@"items",@"name",@"age"]];
    NSLog(@"\n\n 字典 : \n %@ \n\n",dic);
    
    NSDictionary *info = @{
        @"items":@[@"科目1",@"科目2",@"科目3"],
        @"name":@"秦皇汉武",
        @"age":@6688,
    };
    //字典转模型
    TstDicModel *t = [TstDicModel new];
    [t setValuesForKeysWithDictionary:info];
    NSLog(@"\n\n 字典 : \n %@ \n %ld , %@ , %@ \n\n",t,t.age,t.name,t.items);
}

@end
