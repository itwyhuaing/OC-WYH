//
//  FifthVC.m
//  GainRelativeInfoDemo
//
//  Created by hnbwyh on 17/7/5.
//  Copyright © 2017年 hainbwyh. All rights reserved.
//

#import "FifthVC.h"
#import "AppUntils.h"

@interface FifthVC ()

@end

@implementation FifthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)rightNavBtnClick:(UIButton *)btn{

    self.displayLabel.text = [AppUntils readUUIDFromKeyChain];
    
}

@end
