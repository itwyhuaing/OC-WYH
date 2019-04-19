//
//  RichTextEditorVC.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/4/9.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "RichTextEditorVC.h"
#import "ShowWebVC.h"
#import "HTMLFactory.h"
#import "NSTextAttachment+RichText.h"
#import "HppleVC.h"

@interface RichTextEditorVC ()<UIImagePickerControllerDelegate,UITextViewDelegate>
{
    UIFontWeight currentWeight;
    NSDictionary *oldTypesDic;
}
@property (nonatomic,strong)    UITextView *editor;

@end

@implementation RichTextEditorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
}

#pragma mark ------ 功能实现

- (void)imageFunction{
    oldTypesDic = self.editor.typingAttributes;
    UIAlertController *alrtVC   = [[UIAlertController alloc] init];
    __weak typeof(self)weakSelf = self;
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf dismissViewControllerAnimated:FALSE completion:nil];
    }];
    UIAlertAction *xj = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf openCamera];
    }];
    UIAlertAction *xc = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf openPhotoLibrary];
    }];
    [alrtVC addAction:xj];
    [alrtVC addAction:xc];
    [alrtVC addAction:cancel];
    [self presentViewController:alrtVC animated:FALSE completion:nil];
}

- (void)boldFunction{
    NSMutableDictionary *typeingAttributes = [self.editor.typingAttributes mutableCopy];
    typeingAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:18.0 weight:UIFontWeightBold];
    self.editor.typingAttributes = typeingAttributes;
    currentWeight = UIFontWeightBold;
}

- (void)fontFunction{
    NSMutableDictionary *typeingAttributes = [self.editor.typingAttributes mutableCopy];
    typeingAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:28.0 weight:currentWeight];
    self.editor.typingAttributes = typeingAttributes;
}

- (void)fontIFunction{
    NSMutableDictionary *typeingAttributes = [self.editor.typingAttributes mutableCopy];
    typeingAttributes[NSObliquenessAttributeName] = @(0.5);
    self.editor.typingAttributes = typeingAttributes;
}

- (void)fontUFunction{
    NSMutableDictionary *typeingAttributes = [self.editor.typingAttributes mutableCopy];
    typeingAttributes[NSUnderlineStyleAttributeName] = @(NSUnderlineStyleSingle);
    typeingAttributes[NSUnderlineColorAttributeName] = [UIColor blackColor];
    self.editor.typingAttributes = typeingAttributes;
}

- (void)fontSFunction{
    NSMutableDictionary *typeingAttributes = [self.editor.typingAttributes mutableCopy];
    typeingAttributes[NSStrikethroughStyleAttributeName] = @(NSUnderlineStylePatternDot);
    self.editor.typingAttributes = typeingAttributes;
}


- (void)colorFunction{
    NSMutableDictionary *typeingAttributes = [self.editor.typingAttributes mutableCopy];
    typeingAttributes[NSForegroundColorAttributeName] = [UIColor redColor];
    self.editor.typingAttributes = typeingAttributes;
}

- (void)colorFunction2{
    NSMutableDictionary *typeingAttributes = [self.editor.typingAttributes mutableCopy];
    typeingAttributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.editor.typingAttributes = typeingAttributes;
}

- (void)initStatus{
    NSMutableDictionary *typeingAttributes = [self.editor.typingAttributes mutableCopy];
    // 黑色 - 常规 - 18
    typeingAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:18.0 weight:UIFontWeightLight];
    typeingAttributes[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // 首行无缩进 - 行间距 10 - j左对齐 - 字间距 10
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.firstLineHeadIndent      = 0.f;
    paragraphStyle.lineSpacing              = 0.0f;
    paragraphStyle.alignment                = NSTextAlignmentLeft;
    typeingAttributes[NSParagraphStyleAttributeName] = paragraphStyle;
    typeingAttributes[NSKernAttributeName]  = @(0);
    self.editor.typingAttributes            = typeingAttributes;
    
    currentWeight = UIFontWeightLight;
}

// @"NSPara-HeadIndent",@"NSPara-LineSpacing",@"NSPara-Kern"
- (void)paraHeadIndent {
    NSMutableDictionary *typeingAttributes  = [self.editor.typingAttributes mutableCopy];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.firstLineHeadIndent      = 20.f;
    paragraphStyle.lineSpacing              = 0.0f;
    paragraphStyle.alignment                = NSTextAlignmentLeft;
    typeingAttributes[NSParagraphStyleAttributeName] = paragraphStyle;
    typeingAttributes[NSKernAttributeName]  = @(0);
    self.editor.typingAttributes            = typeingAttributes;
}

- (void)paraLineSpacing {
    NSMutableDictionary *typeingAttributes  = [self.editor.typingAttributes mutableCopy];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.firstLineHeadIndent      = 0.f;
    paragraphStyle.lineSpacing              = 20.0f;
    paragraphStyle.alignment                = NSTextAlignmentLeft;
    typeingAttributes[NSParagraphStyleAttributeName] = paragraphStyle;
    typeingAttributes[NSKernAttributeName]  = @(0);
    self.editor.typingAttributes            = typeingAttributes;
}

- (void)paraKern {
    NSMutableDictionary *typeingAttributes  = [self.editor.typingAttributes mutableCopy];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.firstLineHeadIndent      = 0.f;
    paragraphStyle.lineSpacing              = 0.0f;
    paragraphStyle.alignment                = NSTextAlignmentLeft;
    typeingAttributes[NSParagraphStyleAttributeName] = paragraphStyle;
    typeingAttributes[NSKernAttributeName]  = @(20);
    self.editor.typingAttributes            = typeingAttributes;
}

- (void)contentString{
    NSString *bodyContent = [HTMLFactory htmlFactoryWithAttributedString:self.editor.attributedText];
    NSLog(@"\n %@ \n",self.editor.attributedText);
    ShowWebVC *vc = [[ShowWebVC alloc] init];
    [vc showWebWithHTMLBody:bodyContent isWkWeb:TRUE];
    [self.navigationController pushViewController:vc animated:TRUE];
}

- (void)htmlParser{
    NSString *html  = [HTMLFactory htmlFactoryWithAttributedString:self.editor.attributedText];
    NSLog(@"\n %@ \n",self.editor.attributedText);
    HppleVC *vc     = [[HppleVC alloc] init];
    vc.htmlContent  = html;
    [self.navigationController pushViewController:vc animated:TRUE];
}

#pragma mark --- lazy load

-(UITextView *)editor{

    if (!_editor) {
        CGFloat navMaxY            = CGRectGetMaxY(self.navigationController.navigationBar.frame);
        CGRect  screenFrame        = [UIScreen mainScreen].bounds;
        _editor = [[UITextView alloc] initWithFrame:CGRectMake(0, navMaxY + 66.0, screenFrame.size.width, 200.0)];
        _editor.delegate           = (id)self;
        oldTypesDic                = _editor.typingAttributes;
    }
    return _editor;
    
}

#pragma mark --- UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    /**< 解决插入图片前后编辑区属性变更问题 >*/
    //self.editor.typingAttributes = oldTypesDic;
    return TRUE;
}

#pragma mark --- 相机/相册操作

- (void)openCamera{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imgPikerVC = [[UIImagePickerController alloc] init];
        imgPikerVC.delegate = (id)self;
        imgPikerVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        imgPikerVC.allowsEditing = TRUE;
        imgPikerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imgPikerVC animated:FALSE completion:nil];
    }else{
        NSLog(@"\n 没有监控摄像头 \n");
    }
}

- (void)openPhotoLibrary{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        UIImagePickerController *imgPikerVC = [[UIImagePickerController alloc] init];
        imgPikerVC.delegate = (id)self;
        imgPikerVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        imgPikerVC.allowsEditing = TRUE;
        imgPikerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imgPikerVC animated:FALSE completion:nil];
    }else{
        NSLog(@"\n 不能打开相册 \n");
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage *img = (UIImage *)info[@"UIImagePickerControllerEditedImage"];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil);
    }
    [self dismissViewControllerAnimated:FALSE completion:nil];
    
    __block NSTextAttachment *rltMent = [self addToEditorWithImage:img];
    NSInteger cou = 6;//arc4random() % 100;
    // 图片先上传
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (cou % 2 == 0) { // 图片上传成功
            NSString *imgURLString = @"http://cache.hinabian.com/images/release/b/d/bb87ed887dbe7fff01a6a383895baa0d.png";
            NSDictionary *info = @{kImageAttachmentLoadedURL:imgURLString};
            rltMent.extendedInfo   = info;
            NSLog(@"\n %@ \n",rltMent.extendedInfo);
        } else { // 图片上传失败
            rltMent = nil;
        }
        
    });
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:FALSE completion:nil];
}

- (NSTextAttachment *)addToEditorWithImage:(UIImage *)img{
    NSTextAttachment *imgMent = [[NSTextAttachment alloc] init];
    imgMent.image  = img;
    imgMent.bounds = CGRectMake(0, 0, 100.0, 100 * img.size.height / img.size.width);
    NSLog(@"\n %@ \n",imgMent.extendedInfo);
    NSAttributedString *imageAttributedString = [NSAttributedString attributedStringWithAttachment:imgMent];
    NSMutableAttributedString *mutableAttribuedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.editor.attributedText];
    [mutableAttribuedString appendAttributedString:imageAttributedString];
    self.editor.attributedText = mutableAttribuedString;
    return imgMent;
}


#pragma mark ------ UI 组件

- (void)configUI{
    // 控制按钮
    UISegmentedControl *seg = [[UISegmentedControl alloc] initWithItems:@[@"样式调整",@"Web展示",@"HTML解析测试",@"复原点击"]];
    CGFloat maxY            = CGRectGetMaxY(self.navigationController.navigationBar.frame);
    CGRect  screenFrame     = [UIScreen mainScreen].bounds;
    [seg setFrame:CGRectMake(10, maxY, screenFrame.size.width-20.0, 56)];
    [self.view addSubview:seg];
    [seg addTarget:self action:@selector(clickSegControl:) forControlEvents:UIControlEventValueChanged];
    
    // 编辑区
    [self.view addSubview:self.editor];
    [self initStatus];
    self.editor.backgroundColor = [UIColor cyanColor];
    
}

- (void)clickSegControl:(UISegmentedControl *)segCtrl{
    switch (segCtrl.selectedSegmentIndex) {
        case 0:
        {
            [self functions];
        }
            break;
        case 1:
        {
            [self contentString];
        }
            break;
        case 2:
        {
            [self htmlParser];
        }
            break;
            
        default:
            break;
    }
}

- (void)functions{
    UIAlertController *alrtVC = [[UIAlertController alloc] init];
    __weak typeof(self)weakSelf = self;
    NSArray *thems = @[@"初始状态",@"图片",@"字体加粗大小28",@"红色",@"白色",@"斜体",@"删除线",@"下划线",@"NSPara-HeadIndent",@"NSPara-LineSpacing",@"NSPara-Kern"];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf dismissViewControllerAnimated:FALSE completion:nil];
    }];
    for (NSInteger cou = 0; cou < thems.count; cou ++) {
        UIAlertAction *func = [UIAlertAction actionWithTitle:thems[cou] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf functionOperateAtIndex:cou];
        }];
        [alrtVC addAction:func];
    }
    [alrtVC addAction:cancel];
    [self presentViewController:alrtVC animated:FALSE completion:nil];
}

- (void)functionOperateAtIndex:(NSInteger)index{
    
    switch (index) {
        case 0:
        {
            [self initStatus];
        }
            break;
        case 1:
        {
            [self imageFunction];
        }
            break;
        case 2:
        {
            [self fontFunction];
        }
            break;
        case 3:
        {
            [self colorFunction];
        }
            break;
        case 4:
        {
            [self colorFunction2];
        }
            break;
        case 5:
        {// 斜体
            [self fontIFunction];
        }
            break;
        case 6:
        {// 删除线
            [self fontSFunction];
        }
            break;
        case 7:
        {// 下划线
            [self fontUFunction];
        }
            break;
        case 8:
        {// NSParagraphStyle
            [self paraHeadIndent];
        }
            break;
        case 9:
        {// NSParagraphStyle
            [self paraLineSpacing];
        }
            break;
        case 10:
        {// NSParagraphStyle
            [self paraKern];
        }
            break;
            
        default:
            break;
    }
}

@end
