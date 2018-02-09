//
//  ChatViewController.m
//  LXYHOCFunctionsDemo
//
//  Created by wyh on 15/11/27.
//  Copyright © 2015年 lachesismh. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatTableCell.h"
#import "MessageObj.h"
#import "MessageManager.h"




@interface ChatViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,retain) UITableView *chatTableView;

@property (nonatomic,retain) UIView *bottomToolView;

@property (nonatomic,retain) UIButton *voiceBtn;

@property (nonatomic,retain) UITextField *inputField;

@property (nonatomic,retain) UIButton *speakBtn;

@property (nonatomic,retain) UIButton *expressionBtn;

@property (nonatomic,retain) UIButton *otherBtn;

@property (nonatomic,retain) NSMutableArray *listData;

@end

@implementation ChatViewController

#pragma mark - ================================ 懒加载

- (UITableView *)chatTableView{
    
    if (_chatTableView == nil) {
        
        CGRect rect = self.view.frame;
        rect.size.height -= (64 + 44);
        _chatTableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
        _chatTableView.delegate = self;
        _chatTableView.dataSource = self;
//        _chatTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _chatTableView.allowsSelection = NO;
        _chatTableView.backgroundColor = [UIColor clearColor];
    }
    return _chatTableView;
    
}

- (NSMutableArray *)listData{
    
    if (_listData == nil) {
        _listData = [[NSMutableArray alloc] init];
    }
    return _listData;
    
}

#pragma mark - ================================ 界面触发

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight;
    self.view.backgroundColor = [UIColor colorWithRed:226.0/255.0 green:225.0/255.0 blue:230.0/255.0 alpha:1.0];
    
    [self initData];
    
    [self setUpUI];
}

#pragma mark - initData

- (void)initData{

    NSArray *times = @[@"前天:10:30",@"昨天",@"上午",@"01:30"];
    NSArray *contents = @[@"000nisfsfladjklfjkdfghjklkjhghjkjhg000",
            @"111nisfsfladjklfjkdfghjklkjhghjkjhgnisfsfladjklfjkdfghjklkjhghjkjhgnisfsfladjklfjkdfghjklkjhghjkjhg111",
                          @"222nisfsfladjklfjkdfghjklkjhghjkjhgnisfsfladjklfjkdfghjklkjhghjkjhg222",
                          @"333nisfsfladjklfjkdfghjklkjhghjkjhgnisfsfladjklfjkdfghjklkjhghjkjhgnisfsfladjklfjkdfghjklkjhghjkjhgnisfsfladjklfjkdfghjklkjhghjkjhgnisfsfladjklfjkdfghjklkjhghjkjhgnisfsfladjklfjkdfghjklkjhghjkjhgnisfsfladjklfjkdfghjklkjhghjkjhgnisfsfladjklfjkdfghjklkjhghjkjhgnisfsfladjklfjkdfghjklkjhghjkjhg333",
                          @"你好！",
                          @"哦"
                          ];
    
    for (NSInteger cou = 0; cou < 9; cou ++) {
        
        MessageObj *msgObj = [[MessageObj alloc] init];
        msgObj.time = times[cou%4];
        msgObj.msgContent = contents[cou%6];
        if (cou%2) {
            msgObj.msgType = MsgTypeMe;
            msgObj.iconName = @"icon01";
        }else{
            msgObj.msgType = MsgTypeFrom;
            msgObj.iconName = @"icon02";
        }
        msgObj.showTime = YES;
        MessageManager *msgManager = [[MessageManager alloc] init];
//        msgManager.showTime = YES;
        msgManager.msgObj = msgObj;
        [self.listData addObject:msgManager];
    }
    
}


- (void)setUpUI{

    [self.view addSubview:self.chatTableView];
    
    CGSize size = CGSizeMake(30, 30);
    CGRect rect = CGRectZero;
    rect.origin.y = CGRectGetMaxY(self.chatTableView.frame);
    rect.size.height = 44;
    rect.size.width = [UIScreen mainScreen].bounds.size.width;
    self.bottomToolView = [[UIView alloc] initWithFrame:rect];
    self.bottomToolView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.bottomToolView];
    rect.origin.x = 15;
    rect.origin.y = 7;
    rect.size = size;
    self.voiceBtn = [self createBtnWithFrame:rect title:nil norImgName:@"chat_bottom_voice_nor" seleImgName:@"chat_bottom_voice_nor"];
    self.voiceBtn.tag = 100;
    [self.voiceBtn addTarget:self action:@selector(clickBtnOnBottomToolView:) forControlEvents:UIControlEventTouchUpInside];
    rect.origin.x = CGRectGetMaxX(self.voiceBtn.frame) + 10;
    rect.size.width = [UIScreen mainScreen].bounds.size.width - (30 * 3 + 15 * 2 + 10 * 3);
    self.inputField = [[UITextField alloc] initWithFrame:rect];
    self.inputField.placeholder = @"请输入......";
    self.inputField.backgroundColor = [UIColor whiteColor];
    self.inputField.layer.cornerRadius = 8.0f;
    self.inputField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
    self.inputField.leftViewMode = UITextFieldViewModeAlways;
    self.inputField.delegate = self;
    [self.bottomToolView addSubview:self.inputField];
    self.speakBtn = [self createBtnWithFrame:rect title:@"按住说话" norImgName:@"" seleImgName:@""];
    self.speakBtn.tag = 103;
    [self.speakBtn addTarget:self action:@selector(clickBtnOnBottomToolView:) forControlEvents:UIControlEventTouchUpInside];
    self.speakBtn.backgroundColor = [UIColor whiteColor];
    self.speakBtn.hidden = YES;
    self.speakBtn.layer.cornerRadius = 8.0f;
    rect.origin.x = CGRectGetMaxX(self.inputField.frame) + 10;
    rect.size.width = rect.size.height;
    self.expressionBtn = [self createBtnWithFrame:rect title:nil norImgName:@"chat_bottom_smile_nor" seleImgName:@"chat_bottom_smile_press"];
    self.expressionBtn.tag = 101;
    rect.origin.x = CGRectGetMaxX(self.expressionBtn.frame) + 10;
    self.otherBtn = [self createBtnWithFrame:rect title:nil norImgName:@"chat_bottom_up_nor" seleImgName:@"chat_bottom_up_press"];
    self.otherBtn.tag = 102;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 创建按钮

- (UIButton *)createBtnWithFrame:(CGRect)rect title:(NSString *)title norImgName:(NSString *)norName seleImgName:(NSString *)seleName{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:rect];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:norName] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:seleName] forState:UIControlStateSelected];
    [self.bottomToolView addSubview:btn];
   
    btn.backgroundColor = [UIColor redColor];
    
    return btn;
}

#pragma mark - ================================ 键盘处理

#pragma mark - 键盘即将显示

- (void)keyBoardWillShow:(NSNotification *)note{
    
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = - rect.size.height;
//    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
    
//    }];

    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        // 自动滚动到底部
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.listData.count - 1 inSection:0];
        [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    } completion:^(BOOL finished) {
        self.view.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
    
}
#pragma mark - 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        
        self.view.transform = CGAffineTransformIdentity;
        
    }];
}

#pragma mark - ================================ UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [self.listData[indexPath.row] cellHeight];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"ChatTableCell";
    ChatTableCell *chatCell = [self.chatTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (chatCell == nil) {
        chatCell = [[ChatTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        chatCell.selected = UITableViewCellSelectionStyleNone;
    }
    chatCell.msgManager = self.listData[indexPath.row];
    return chatCell;
    
}

#pragma mark - scrollViewWillBeginDragging

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self.inputField endEditing:YES];
    
}


#pragma mark - ================================ UITextFieldDelegate

//处理消息通讯
- (void)textFieldDidEndEditing:(UITextField *)textField{

    NSLog(@"---> %s",__FUNCTION__);
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    NSString *content = textField.text;
    textField.text = nil;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate date];
    fmt.dateFormat = @"yyyy-mm-dd hh:mm:ss";
    NSString *time = [fmt stringFromDate:date];
    [self addMsgToListData:content time:time];
    
    [self.chatTableView reloadData];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.listData.count - 1 inSection:0];
    [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    return YES;
}

#pragma mark - addMsgToListData

- (void)addMsgToListData:(NSString *)content time:(NSString *)time{

    MessageObj *msgObj = [[MessageObj alloc] init];
    msgObj.time = time;
    msgObj.iconName = @"icon01.png";
    msgObj.msgContent = content;
    msgObj.msgType = MsgTypeFrom;
    msgObj.showTime = YES;
    MessageManager *msgManager = [[MessageManager alloc] init];
//    msgManager.showTime = YES;
    msgManager.msgObj = msgObj;
    [self.listData addObject:msgManager];
}

#pragma mark - ================================ 输入工具栏上的点击事件

- (void)clickBtnOnBottomToolView:(UIButton *)sendBtn{
    switch (sendBtn.tag) {
        case 100:
        {
            if (self.inputField.hidden) {
                
                self.inputField.hidden = NO;
                self.speakBtn.hidden = YES;
                
                [self.voiceBtn setBackgroundImage:[UIImage imageNamed:@"chat_bottom_voice_nor"] forState:UIControlStateNormal];
                [self.voiceBtn setBackgroundImage:[UIImage imageNamed:@"chat_bottom_voice_press"] forState:UIControlStateSelected];
                
                [self.inputField becomeFirstResponder];
                
            } else { //
                
                self.inputField.hidden = YES;
                self.speakBtn.hidden = NO;
                
                [self.voiceBtn setBackgroundImage:[UIImage imageNamed:@"chat_bottom_keyboard_nor"] forState:UIControlStateNormal];
                [self.voiceBtn setBackgroundImage:[UIImage imageNamed:@"chat_bottom_keyboard_press"] forState:UIControlStateSelected];
                
                [self.inputField resignFirstResponder];
            }
        }
            break;
        case 101:
        {
            
        }
            break;
        case 102:
        {
            
        }
            break;
        case 103: // 语言消息处理
        {
            
        }
            break;
            
        default:
            break;
    }
}

@end
