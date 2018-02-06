//
//  HNBRichTextPostingVC.m
//  hinabian
//
//  Created by hnbwyh on 2017/8/14.
//  Copyright © 2017年 &#20313;&#22362;. All rights reserved.
//

#import "HNBRichTextPostingVC.h"
#import "DataFetcher.h"
//#import "TribeDetailInfoViewController.h"
//#import "SWKTribeShowViewController.h"
#import "DownSheet.h"
#import "DownSheetModel.h"
#import "HNBFileManager.h"
#import "UpLoadImageProgressTip.h"
//#import "HotTopicListVC.h"

@interface HNBRichTextPostingVC () <DownSheetDelegate>

@property (nonatomic,assign) BOOL isSucPost; // 帖子发表是否成功
@property (nonatomic,strong) DownSheet *ds;

@end

@implementation HNBRichTextPostingVC

#pragma mark ------ init - dealloc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.placeholder = @"写点什么吧";
    _isSucPost = FALSE;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUpNav];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
/*<草稿箱内容发布成功之后需要移除存储>*/
    if (_isSucPost && self.entryOrigin == PostingEntryOriginLookOverDraft) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [HNBFileManager clearFileDataWithCacheKey:LOCAL_DRAFT_TRIBE_BASEINFO];
            [HNBFileManager clearFileDataWithCacheKey:LOCAL_DRAFT_FAILRE_IMAGEMODEL];
        });
    }
}

#pragma mark ------ private method

- (void)setUpNav{

    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    UIButton *postBtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    postBtn.titleLabel.font = [UIFont systemFontOfSize:FONT_UI36PX];
    [postBtn setTitle:@"发布" forState:UIControlStateNormal];
    [postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [postBtn addTarget:self action:@selector(postSubmit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:postBtn];
    self.navigationItem.rightBarButtonItem = barButton;
    
    UIBarButtonItem *temporaryBarButtonItem = [[UIBarButtonItem alloc] init];
    temporaryBarButtonItem.image = [UIImage imageNamed:@"btn_fanhui"];
    temporaryBarButtonItem.target = self;
    temporaryBarButtonItem.action = @selector(back_main);
    self.navigationItem.leftBarButtonItem = temporaryBarButtonItem;

    
}

- (void)back_main{
    //[HNBClick event:@"190012" Content:nil];
    
    //NSLog(@" %s \n %@ \n",__FUNCTION__,[self getHTML]);
    NSString *postTitle = [self getHTMLTitle];
    NSString *content = [self getHTML];
    [self blurTextEditor];
/*<除了旧帖再编辑或者发布成功不需要保存其他情况均需保存数据>*/
    if (!_isSucPost && self.entryOrigin != PostingEntryOriginEditingOldTribeThem) {
        if (postTitle.length > 0 || content.length > 0) {
            _ds = [self createDownSheet];
            [_ds showDownSheetOnWindow];
            return;
        }
    }
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)postSubmit{
    [super postSubmit];
    
    BOOL isMask = [self queryImageMaskTagForCurrentDOM];
    // 蒙版
    if (isMask) {
        [[HNBToast shareManager] toastWithOnView:nil msg:@"有图片尚未成功上传" afterDelay:DELAY_TIME style:HNBToastHudFailure];
        return;
    }else{
        [self.failureModels removeAllObjects];
    }
    
    NSString *postTitle = [self getHTMLTitle];
    NSString *content = [self getOriginalDOM];
    // 没有标题
    if (postTitle.length <= 0) {
        [[HNBToast shareManager] toastWithOnView:nil msg:@"请输入标题" afterDelay:1.0 style:HNBToastHudFailure];
        return;
    }
    // 没有内容
    if (content.length <= 0) {
        [[HNBToast shareManager] toastWithOnView:nil msg:@"请输入内容" afterDelay:1.0 style:HNBToastHudFailure];
        return;
    }
    // 未选择标题
    if (self.choseTribeCode.length <= 0) {
        [self blurTextEditor]; // 收起键盘方便用户查看圈子选择器
        [[HNBToast shareManager] toastWithOnView:nil msg:@"请选择圈子" afterDelay:DELAY_TIME style:HNBToastHudOnlyText];
        return;
    }
    
    
    // 所有判断之后 - 准许发布
    content = [self getTidyedDOMAfterDelateHiddedHTML];
    NSLog(@" \n \n 发布 DOM 树 :%@",content);
    NSLog(@" \n \n ");
    [DataFetcher hnbRichTextPostTribeID:self.choseTribeCode
                                 themID:self.tribeThemCode
                                  title:postTitle
                                content:content
                                topicID:self.topicID
                     withSucceedHandler:^(id JSON) {
                         int errCode = [[JSON valueForKey:@"state"] intValue];
                         if (errCode == 0) {
                             _isSucPost = TRUE;
                             
                             if (self.entryOrigin == PostingEntryOriginJoinTopicDiscuss) {
                                 
                                 //[self backHotTopicListVC];
                                 
                             } else {
                                 
                                 /* 发布帖子 */
                                 id josnMain = [JSON valueForKey:@"data"];
                                 NSString *url = [NSString  stringWithFormat:@"%@/theme/detail/%@",H5URL,[josnMain valueForKey:@"id"]];
                                 NSString *isNativeString = [HNBUtils sandBoxGetInfo:[NSString class] forKey:TRIBEDETAILTHEME_NATIVEUI_WEB];
                                 NSLog(@" 发帖成功 ");
                                 
                             }
                         }
                     } withFailHandler:^(id error) {
                         
                     }];
    
    /** 数据上报 */
    //[HNBClick event:@"190011" Content:nil];
    
}


- (BOOL)saveLocalDraft{
/**
 草稿需要保存信息
 title
 content
 tribeID
 tribeName
 failureModels
**/
    if ([self queryImageUploadingTagForCurrentDOM]) {
        [[HNBToast shareManager] toastWithOnView:nil msg:@"有图片正在上传" afterDelay:DELAY_TIME style:HNBToastHudFailure];
        return FALSE;
    }
    BOOL isImagesSuc = TRUE;
    BOOL isBaseInfoSuc = TRUE;
    BOOL isSuc = TRUE;
    NSString *content = [self getHTML];
    NSString *postTitle = [self getHTMLTitle];
    NSString *tribeID = self.choseTribeCode;
    NSString *tribeName = self.chosedTribeName;
    NSMutableDictionary *draftDic = [[NSMutableDictionary alloc] init];
    [self createDicInfo:draftDic key:@"title" value:postTitle];
    [self createDicInfo:draftDic key:@"content" value:content];
    [self createDicInfo:draftDic key:@"tribeID" value:tribeID];
    [self createDicInfo:draftDic key:@"tribeName" value:tribeName];
    
    if (self.failureModels != nil && self.failureModels.count > 0) {
        NSMutableArray *tmpArr = [[NSMutableArray alloc] init];
        for (NSInteger cou = 0; cou < self.failureModels.count; cou ++) {
            HNBAssetModel *f = self.failureModels[cou];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithInteger:f.basicTag],@"basicTag",
                                  f.localURL,@"imagePath",
                                  nil];
            
            [tmpArr addObject:dict];
        }
        isImagesSuc = [HNBFileManager writeArrAPPNetInterfaceData:tmpArr cacheKey:LOCAL_DRAFT_FAILRE_IMAGEMODEL];
    }
    isBaseInfoSuc = [HNBFileManager writeDicAPPNetInterfaceData:draftDic cacheKey:LOCAL_DRAFT_TRIBE_BASEINFO];
    isSuc = isImagesSuc && isBaseInfoSuc;
    //NSLog(@" 是否成功 ====== > \n \n isImagesSuc : %d \n \n  isBaseInfoSuc :%d \n \n",isImagesSuc,isBaseInfoSuc);
    if (!isSuc) {
        [[HNBToast shareManager] toastWithOnView:nil msg:@"草稿保存失败" afterDelay:DELAY_TIME style:HNBToastHudFailure];
    }
    return isSuc;
}

- (void)createDicInfo:(NSMutableDictionary *)dict key:(NSString *)key value:(NSString *)value{
    if (value != nil || value.length > 0) {
        [dict setObject:value forKey:key];
    }
}

// 发帖成功之后需要移除 控制器堆栈中的栈顶元素(编辑控制器 - HNBRichTextPostingVC)
- (void)removeTopAndPushViewController:(UIViewController *)viewController {
    NSMutableArray *viewControllers = self.navigationController.viewControllers.mutableCopy;
    [viewControllers removeObject:self.navigationController.topViewController];
    [viewControllers addObject:viewController];
    [self.navigationController setViewControllers:viewControllers.copy animated:YES];
}


// 重新编辑的帖子发不成功之后需要重新整理控制器堆栈 - 旧帖展示控制器及当前的编辑控制器均需从堆栈中移除
- (void)removeOldTribeThemVCAndEditorVCThenPushNewVC:(UIViewController *)vc{
    NSMutableArray *cur_vcs = [[NSMutableArray alloc] init];
    [cur_vcs addObjectsFromArray:self.navigationController.viewControllers];
    if (cur_vcs.count >= 2) {
        [cur_vcs removeLastObject];
        [cur_vcs removeLastObject];
        [cur_vcs addObject:vc];
    }
    [self.navigationController setViewControllers:cur_vcs animated:FALSE];
}

// 参与话题发不成功之后回到话题列表页
- (void)backHotTopicListVC{
    
//    NSMutableArray *tmpvcs = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
//    UIViewController *vc = [[UIViewController alloc] init];
//    if (tmpvcs != nil && tmpvcs.count >= 2) {
//        vc = tmpvcs[tmpvcs.count - 2];
//    }
//    if([vc isKindOfClass:[HotTopicListVC class]]){
//        HotTopicListVC *hotVC = (HotTopicListVC *)vc;
//        hotVC.isRefreshWhenPop = TRUE;
//    }
//    [self.navigationController popViewControllerAnimated:TRUE];
    
}

-(void)touchTitleSection{
    [super touchTitleSection];
/*<话题讨论不准许编辑标题>*/
    if (self.entryOrigin == PostingEntryOriginJoinTopicDiscuss) {
        [self titleContentEditable:@"false"];
    }
}

#pragma mark ------ DownSheetDelegate

- (DownSheet *)createDownSheet{

    NSArray *titles = @[@"保存本次编辑",@"放弃本次编辑",@"取消"];
    NSMutableArray *list = [[NSMutableArray alloc] init];
    for (NSInteger cou = 0; cou < 3; cou ++) {
        DownSheetModel *f = [[DownSheetModel alloc] init];
        f.title = titles[cou];
        f.cellStyleType = DownSheetCellStyleTypeRichText;
        [list addObject:f];
    }
    DownSheet *ds = [[DownSheet alloc] initWithlist:list height:0];
    ds.delegate = self;
    return ds;
}


- (void)didSelectIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            if ([self saveLocalDraft]) {
                [self.navigationController popViewControllerAnimated:NO];
            }
        }
            break;
        case 1:
        {
            [self.navigationController popViewControllerAnimated:NO];
        }
            break;
        case 2:
        {
            [_ds removeDownSheet:_ds animation:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark ------ didReceiveMemoryWarning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@" %s ",__FUNCTION__);
}

@end
