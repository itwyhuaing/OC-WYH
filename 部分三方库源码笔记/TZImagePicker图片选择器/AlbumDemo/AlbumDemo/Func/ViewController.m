//
//  ViewController.m
//  AlbumDemo
//
//  Created by hnbwyh on 2019/11/15.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSStringFromClass([self class]);
}

//https://www.jianshu.com/p/40cc2a120551
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"照片来源" message:@"请做出选择" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction     *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"\n\n相机\n");
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            NSLog(@"\n\n相机不可用\n");
        }
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if (authStatus == AVAuthorizationStatusNotDetermined ||
            authStatus == AVAuthorizationStatusRestricted ||
            authStatus == AVAuthorizationStatusDenied) {
            NSLog(@"\n\n AVAuthorizationStatusDenied \n");
        }else if (authStatus == AVAuthorizationStatusAuthorized){
            NSLog(@"\n\n AVAuthorizationStatusAuthorized \n");
        }
    }];
    UIAlertAction     *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         NSLog(@"\n\n相册\n");
    }];
    UIAlertAction     *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
         NSLog(@"\n\n取消\n");
    }];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [alertVC addAction:action3];
    [self presentViewController:alertVC animated:TRUE completion:nil];
}

@end
