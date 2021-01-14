//
//  FirstVC.m
//  WKLocalImagesDemo
//
//  Created by hnbwyh on 2021/1/13.
//

#import "FirstVC.h"
#import <WebKit/WebKit.h>
#import <Photos/Photos.h>
#import "Util.h"

@interface FirstVC ()

@property (nonatomic,strong)    WKWebView   *wkweb;
@property (nonatomic,copy)      NSString    *localTmpPath;
@property (nonatomic,copy)      NSString    *localCachePath;

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.wkweb.backgroundColor = [UIColor orangeColor];
    self.title                = NSStringFromClass(self.class);
    [self.view addSubview:self.wkweb];
    [self loadWeb];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"选图" forState:UIControlStateNormal];
    rightBtn.backgroundColor = [UIColor redColor];
    [rightBtn addTarget:self action:@selector(pickImage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}


-(WKWebView *)wkweb {
    if (!_wkweb) {
        WKWebViewConfiguration *cfg = [[WKWebViewConfiguration alloc] init];
        _wkweb = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:cfg];
    }
    return _wkweb;
}


- (void)loadWeb {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"firtEditor" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self.wkweb loadHTMLString:html baseURL:[NSURL URLWithString:@"file://"]];
    //[self.wkweb loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
}

- (void)replacePath {
    // tmp url
    NSURL *tmpPathURL = [NSURL fileURLWithPath:self.localTmpPath];
    
    // cache url
    NSURL *cachePathURL = [NSURL fileURLWithPath:self.localCachePath];
    
    // bundle
    NSString *deletePath = [[NSBundle mainBundle] pathForResource:@"delete@2x" ofType:@"png"];
    NSURL *deletePathURL = [NSURL fileURLWithPath:deletePath];
    NSString *loadingPath= [[NSBundle mainBundle] pathForResource:@"uploadimageloading" ofType:@"gif"];
    NSURL *loadingPathURL= [NSURL fileURLWithPath:loadingPath];
    
    // DOM
    NSString *path = [[NSBundle mainBundle] pathForResource:@"firtEditor" ofType:@"html"];
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    html = [html stringByReplacingOccurrencesOfString:@"https://tmp"  withString:tmpPathURL.absoluteString];
    html = [html stringByReplacingOccurrencesOfString:@"https://cache"  withString:cachePathURL.absoluteString];
    html = [html stringByReplacingOccurrencesOfString:@"https://bundle/png"  withString:deletePathURL.absoluteString];
    html = [html stringByReplacingOccurrencesOfString:@"https://bundle/gif"  withString:loadingPathURL.absoluteString];
    
    NSLog(@"\n\n 最终加载 html ：\n %@ \n\n",html);
    [self.wkweb loadHTMLString:html baseURL:[NSURL URLWithString:@"file://"]];
}


- (void)dealloc {
    // 清空数据，保证测试效果
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:self.localTmpPath error:&error];
    [[NSFileManager defaultManager] removeItemAtPath:self.localCachePath error:&error];
    if (error) {
        NSLog(@"清空数据失败：%@", error);
    } else {
        NSLog(@"清空数据成功");
    }
}

#pragma mark - 选择图片

- (void)pickImage {
    __weak typeof(self)weakSelf = self;
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
    [self presentViewController:alertVC animated:TRUE completion:nil];
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

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"\n\n 取消 \n");
    [self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    NSLog(@"\n\n 已完成照片选取，处理信息提取照片 \n");
    //UIImage     *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    UIImage     *originalImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    //NSString    *referenceURL = [info objectForKey:UIImagePickerControllerReferenceURL];
    NSData      *imgData = UIImageJPEGRepresentation(originalImage, 0.5);
    
    // 图片存 tmp
    NSString *tmpPath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"666"];
    BOOL isWrite = [imgData writeToFile:tmpPath atomically:TRUE];
    if (isWrite) {
        NSLog(@"\n\n tmpPath：写入成功\n\n");
        self.localTmpPath = tmpPath;
    } else {
        NSLog(@"\n\n tmpPath：写入失败\n\n");
    }
    
    // 图片存 Cache
    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, TRUE) firstObject] stringByAppendingPathComponent:@"888"];
    BOOL iswriteCache   = [imgData writeToFile:cachePath atomically:TRUE];
    if (iswriteCache) {
        NSLog(@"\n\n cachePath：写入成功\n\n");
        self.localCachePath = cachePath;
    } else {
        NSLog(@"\n\n cachePath：写入失败\n\n");
    }
    
    [self dismissViewControllerAnimated:TRUE completion:nil];
    [self replacePath];
    
}


@end
