//
//  ViewController.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2017/9/30.
//  Copyright © 2017年 hainbwyh. All rights reserved.
//

#import "ViewController.h"
#import "RichTextEditor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.navigationController pushViewController:[[RichTextEditor alloc] init] animated:TRUE];
}



@end
