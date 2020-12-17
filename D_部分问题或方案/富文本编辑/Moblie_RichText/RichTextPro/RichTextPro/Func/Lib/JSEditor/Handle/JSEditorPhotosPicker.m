//
//  JSEditorPhotosPicker.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/12/13.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "JSEditorPhotosPicker.h"
#import <Photos/Photos.h>

@interface PhotosPickerManager ()

@end

@implementation PhotosPickerManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSString *)generateTheBasicCount {
    NSString *rlt = @"0";
    NSDate *dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeInterval = [dat timeIntervalSince1970];
    NSString *tmpString = [NSString stringWithFormat:@"%.0f",timeInterval];
    NSInteger tmpCount = [tmpString integerValue];
    NSString *timeStamp = [NSString stringWithFormat:@"%ld",(long)tmpCount];
    int randNum1 = arc4random() % (timeStamp.intValue) + 1;
    int randNum2 = arc4random() % randNum1;
    rlt = [NSString stringWithFormat:@"%@%d%d",timeStamp,randNum1,randNum2];
    return rlt;
}

- (CGFloat)generateSideGap {
    return 10.0f;
}

- (NSString *)pathForCacheImageWithKey:(NSString *)key {
    NSString *rlt   = @"";
    NSString *cache = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, TRUE) firstObject];
    rlt = [cache stringByAppendingPathComponent:key];
    return rlt;
}

- (BOOL)writeImage:(UIImage *)img cachePath:(NSString *)cPath {
    BOOL rlt = FALSE;
    NSData *data = UIImageJPEGRepresentation(img, 0.5);
    rlt = [data writeToFile:cPath atomically:TRUE];
    return rlt;
}

- (NSString *)base64WithImage:(UIImage *)img {
    NSData *imgData = UIImageJPEGRepresentation(img, 0.5);
    return [imgData base64EncodedStringWithOptions:0];
}

-(NSString *)generateLoadingPath {
    NSBundle *mainBundle = [NSBundle mainBundle];
    return [mainBundle pathForResource:@"uploadimageloading" ofType:@"gif"];
}

-(NSString *)generateReloadingPath {
    NSBundle *mainBundle = [NSBundle mainBundle];
    return [mainBundle pathForResource:@"reload@2x" ofType:@"png"];
}

-(NSString *)generateDeletePath {
    NSBundle *mainBundle = [NSBundle mainBundle];
    return [mainBundle pathForResource:@"66" ofType:@"png"];//[mainBundle pathForResource:@"delete@2x" ofType:@"png"];
}

- (CGSize)compatibleSizeForImage:(UIImage *)img{
    CGSize rlt = img.size;
    CGFloat lr_Gap = [self generateSideGap] * 2.0;
    CGFloat screen_w = [UIScreen mainScreen].bounds.size.width;
    if (rlt.width > (screen_w - lr_Gap)) {
        rlt.width = screen_w - lr_Gap;
        rlt.height = (img.size.height/img.size.width) * rlt.width;
    }
    return rlt;
}

@end


@interface JSEditorPhotosPicker () <UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,strong) UIViewController       *preVC;

@property (nonatomic,strong) PhotosPickerManager    *manager;

@end

@implementation JSEditorPhotosPicker


- (instancetype)initWithPreVC:(UIViewController *)vc {
    self = [super init];
    if (self) {
        _preVC = vc;
    }
    return self;
}


- (void)pickPhotos {
    WSelf
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"照片来源" message:@"请做出选择" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction     *action1 = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf takePhotoes];
        //[weakSelf authorization];
    }];
    UIAlertAction     *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf operatePhotosFromLib];
        //[weakSelf authorization];
    }];
    UIAlertAction     *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:action1];
    [alertVC addAction:action2];
    [alertVC addAction:action3];
    [self.preVC presentViewController:alertVC animated:TRUE completion:nil];
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
        [self.preVC presentViewController:imagePickerVC animated:TRUE completion:^{
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
      [self.preVC presentViewController:imagePicker animated:TRUE completion:^{
          NSLog(@"\n\n 进入相册 \n\n");
      }];
  }
}

#pragma mark ------

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"\n\n 取消 \n");
    [self.preVC dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    NSLog(@"\n\n 已完成照片选取，处理信息提取照片 \n");
    PhotoModel *f = [PhotoModel new];
    f.editedImage       = [info objectForKey:UIImagePickerControllerEditedImage];
    f.originalImage     = [info objectForKey:UIImagePickerControllerOriginalImage];
    f.originalPath      = [info objectForKey:UIImagePickerControllerReferenceURL];
    f.loadingPath       = [self.manager generateLoadingPath];
    f.reloadingPath     = [self.manager generateReloadingPath];
    f.deletePath        = [self.manager generateDeletePath];
    f.compatibleSize    = [self.manager compatibleSizeForImage:f.originalImage];
    f.lrGap             = [self.manager generateSideGap];
     [self.manager writeImage:f.originalImage cachePath:f.writedPath];
    // 照片写入本应用内缓存
    f.uniqueSign        = [self.manager generateTheBasicCount];
    NSString *targetPath= [self.manager pathForCacheImageWithKey:[NSString stringWithFormat:@"%@.png",f.uniqueSign]];
    BOOL write = [self.manager writeImage:f.originalImage cachePath:targetPath];
    if (write) {
        f.writedPath = targetPath;
    }
    // 图片 ，base64String
    f.orgImgBase64Str = [self.manager base64WithImage:f.originalImage];
    f.editedImgBase64Str = [self.manager base64WithImage:f.editedImage];
    
    // 回调
    self.pickerBlock ? self.pickerBlock(@[f]) : nil;
}

-(PhotosPickerManager *)manager {
    if (!_manager) {
        _manager = [[PhotosPickerManager alloc] init];
    }
    return _manager;
}

@end
