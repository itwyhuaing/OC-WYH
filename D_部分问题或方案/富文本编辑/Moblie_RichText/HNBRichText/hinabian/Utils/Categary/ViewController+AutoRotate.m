//
//  ViewController+AutoRotate.m
//  hinabian
//
//  Created by 何松泽 on 16/10/25.
//  Copyright © 2016年 &#20313;&#22362;. All rights reserved.
//

#import "ViewController+AutoRotate.h"

@implementation UIViewController (AutoRotate)

/*设置不可翻转*/
- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
