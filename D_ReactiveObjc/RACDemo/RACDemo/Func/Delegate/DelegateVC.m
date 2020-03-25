//
//  DelegateVC.m
//  RACDemo
//
//  Created by hnbwyh on 2019/5/5.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "DelegateVC.h"
#import "DTestView.h"

@interface DelegateVC ()

@property (nonatomic,strong) DTestView *dtv;

@end

@implementation DelegateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title                = NSStringFromClass(self.class);
    self.dtv.backgroundColor = [UIColor cyanColor];
    self.dtv.delegateSignal = [RACSubject subject];
    [self.dtv.delegateSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"\n %@ \n",x);
    }];
}

-(DTestView *)dtv{
    if (!_dtv) {
        _dtv = [[DTestView alloc] init];
        [self.view addSubview:_dtv];
        _dtv.sd_layout
        .leftSpaceToView(self.view, 10)
        .rightSpaceToView(self.view, 10)
        .topSpaceToView(self.view, 100)
        .bottomSpaceToView(self.view, 10);
    }
    return _dtv;
}

@end
