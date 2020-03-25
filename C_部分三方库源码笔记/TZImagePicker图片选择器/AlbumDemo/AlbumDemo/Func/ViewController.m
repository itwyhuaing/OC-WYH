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
   
}

- (void)choice {
    __weak typeof(self) weakSelf = self;
       UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"照片来源" message:@"请做出选择" preferredStyle:UIAlertControllerStyleActionSheet];
       UIAlertAction     *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           [weakSelf takePhotoes];
           [weakSelf authorization];
       }];
       UIAlertAction     *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"\n\n相册\n");
           [weakSelf operatePhotosFromLib];
           [weakSelf authorization];
       }];
       UIAlertAction     *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"\n\n取消\n");
       }];
       [alertVC addAction:action1];
       [alertVC addAction:action2];
       [alertVC addAction:action3];
       [self presentViewController:alertVC animated:TRUE completion:nil];
}

- (void)authorization {
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
}

- (void)takePhotoes {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
        imagePickerVC.delegate = (id)self;
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerVC.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        [self presentViewController:imagePickerVC animated:TRUE completion:^{
            NSLog(@"\n\n 进入相机 \n\n");
        }];
    }
}


- (void)operatePhotosFromLib {
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
      UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
      imagePicker.allowsEditing = TRUE;
      imagePicker.sourceType    = UIImagePickerControllerSourceTypePhotoLibrary;
      imagePicker.delegate      = (id)self;
      [self presentViewController:imagePicker animated:TRUE completion:^{
          NSLog(@"\n\n 进入相册 \n\n");
      }];
  }
}

#pragma mark ------

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"\n\n 取消 \n");
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    NSLog(@"\n\n 已完成照片选取，处理信息提取照片 \n");
}

@end
