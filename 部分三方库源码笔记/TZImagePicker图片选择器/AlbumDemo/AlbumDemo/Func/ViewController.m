//
//  ViewController.m
//  AlbumDemo
//
//  Created by hnbwyh on 2019/11/15.
//  Copyright © 2019 JiXia. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

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


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"照片来源" message:@"请做出选择" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction     *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"\n\n相机\n");
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            NSLog(@"\n\n相机不可用\n");
        }else {
            [self takePhotoes];
        }
        return;
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if (authStatus == AVAuthorizationStatusNotDetermined) {
            NSLog(@"\n\n AVAuthorizationStatusDenied \n");
        }else if (authStatus == AVAuthorizationStatusRestricted){
            NSLog(@"\n\n AVAuthorizationStatusRestricted \n");
        }else if (authStatus == AVAuthorizationStatusDenied){
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

- (void)takePhotoes {
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    imagePickerVC.delegate = (id)self;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePickerVC.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    [self presentViewController:imagePickerVC animated:TRUE completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"\n\n 取消 \n");
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    NSLog(@"\n\n 已完成照片选取，处理信息提取照片 \n");
}

@end
