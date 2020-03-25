//
//  KVOVC.m
//  RACDemo
//
//  Created by hnbwyh on 2019/5/5.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "KVOVC.h"
#import "Tobj.h"

@interface KVOVC ()

@property (nonatomic,strong) Tobj   *tojt;

@end

@implementation KVOVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title                = NSStringFromClass(self.class);
    [self test];
}

- (void)test {
    
    [[self.tojt rac_valuesForKeyPath:@"frame" observer:self] subscribeNext:^(id  _Nullable x) {
        NSLog(@" \n x = :\n%@ \n ",x);
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.tojt setFrame:CGRectMake(0, 0, 10, 10)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tojt setFrame:CGRectMake(0, 0, 100, 100)];
    });
}

-(Tobj *)tojt{
    if (!_tojt) {
        _tojt = [[Tobj alloc] init];
    }
    return _tojt;
}

@end
