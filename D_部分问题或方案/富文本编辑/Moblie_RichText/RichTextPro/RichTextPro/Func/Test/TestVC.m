//
//  TestVC.m
//  RichTextPro
//
//  Created by hnbwyh on 2020/12/3.
//  Copyright © 2020 JiXia. All rights reserved.
//

#import "TestVC.h"
#import "JSEditorDataModel.h"


@interface TestVC ()

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [NSMutableArray new];
    for (NSInteger cou = 0; cou < 9; cou ++) {
        PhotoModel *f = [PhotoModel new];
        [_dataSource addObject:f];
        f.originalImage = [UIImage imageNamed:@"ZSSimageFromDevice_selected"];
        f.uniqueSign    = [NSString stringWithFormat:@"%ld",cou+100];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    for (NSInteger cou = 0; cou < self.dataSource.count; cou ++) {
        BOOL b = (cou % 2 == 0);
        PhotoModel *f = self.dataSource[cou];
        [self upLoadImageWithModel:f isReload:b completion:^(BOOL status, id info) {
            NSLog(@"\n\n %@ - %d  <===>  %@ - %d \n\n",f.uniqueSign,b,info,status);
        }];
    }
}

- (void)upLoadImageWithModel:(PhotoModel *)model isReload:(BOOL)isReload completion:(void(^)(BOOL status , id info))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *uni = model.uniqueSign;
            completion ? completion(isReload,[NSString stringWithFormat:@"数据信息:%@",uni]) : nil;
        });
    });
}


@end
