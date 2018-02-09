//
//  DropListMenu.m
//  YHDropListMenu
//
//  Created by wyh on 15/12/14.
//  Copyright © 2015年 lachesismh. All rights reserved.
//

#import "DropListMenu.h"

#define TAG_OF_BTN_INSECTION 1000
#define TAG_OF_IMAGEVIEW_MARK 2000

@interface DropListMenu () <UITableViewDataSource,UITableViewDelegate>
{
    NSInteger currentExtensionMenu;
    CGFloat sectionWidth;
    NSArray *listData;
    NSArray *titles;
    BOOL isExtension;  // 纪录是否展开
    
    BOOL isEnd;
}
@property (nonatomic,retain) UITableView *listTableView;

@property (nonatomic,retain) UIView *listBaseView;

@property (nonatomic,retain) UIView *listSuperView;

@property (nonatomic,assign) id<DropListMenuDelegate> delegate;

@end

@implementation DropListMenu

#pragma mark - 懒加载

-(UIView *)listBaseView{
    if (_listBaseView == nil) {
        _listBaseView = [[UIView alloc] init];
        _listBaseView.backgroundColor = [UIColor grayColor];
        _listBaseView.alpha = 0.8;
    }
    return _listBaseView;
}

-(UITableView *)listTableView{
    if (_listTableView == nil) {
        
        _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _listTableView.scrollEnabled = NO;
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        
    }
    return _listTableView;
}

#pragma mark - initWithFrame:superView:delegate:

- (id)initWithFrame:(CGRect)frame superView:(UIView *)view delegate:(id<DropListMenuDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = delegate;
        self.listSuperView = view;
        
        currentExtensionMenu = -1;
        [self.listSuperView addSubview:self];

        if ([self.delegate respondsToSelector:@selector(dropListMenu:titlesForSection:)]) {
            titles = [self.delegate dropListMenu:self titlesForSection:0];
        }
        
        if ([titles count] == 0) {
            self = nil;
        }
        
        sectionWidth = 1.0 * self.frame.size.width / [titles count];
        CGFloat sectionHeight = self.frame.size.height;
        for (NSInteger cou = 0; cou < [titles count]; cou ++) {
            CGRect rect = CGRectZero;
            rect.size = CGSizeMake(sectionWidth-16, sectionHeight - 2);
            
            rect.origin.x = sectionWidth * cou;
            rect.origin.y = 1;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:rect];
            [btn setTitle:titles[cou] forState:UIControlStateNormal];
            btn.tag = TAG_OF_BTN_INSECTION + cou;
            [btn addTarget:self action:@selector(clickEventOnSection:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            
            rect.origin.x = CGRectGetMaxX(btn.frame);
            rect.size.width = 15;
            rect.size.height = rect.size.width;
            rect.origin.y = sectionHeight/2.0 - rect.size.height / 2.0;
            UIImageView *img_mark = [[UIImageView alloc] initWithFrame:rect];
            img_mark.image = [UIImage imageNamed:@"down_mark"];
            img_mark.tag = TAG_OF_IMAGEVIEW_MARK + cou;
            [self addSubview:img_mark];
            
            rect.origin.x = CGRectGetMaxX(img_mark.frame);
            rect.origin.y = 0;
            rect.size.width = 1;
            rect.size.height = sectionHeight;
            UIView *lineView = [[UIView alloc] initWithFrame:rect];
            lineView.backgroundColor = [UIColor grayColor];
            [self addSubview:lineView];
            
        }

    }
    return self;
}

#pragma mark - clickEventOnSection

- (void)clickEventOnSection:(UIButton *)sendBtn{

     NSInteger selectedSection = sendBtn.tag - TAG_OF_BTN_INSECTION;
    
    if (currentExtensionMenu < 0) {
        
        // 当前的一定是展开
        UIImageView *selectedImgView = (UIImageView *)[self viewWithTag:selectedSection+TAG_OF_IMAGEVIEW_MARK];
        [UIView animateWithDuration:0.3 animations:^{
            selectedImgView.transform = CGAffineTransformRotate(selectedImgView.transform, M_PI);
        }];
        [self showTableViewOnSection:selectedSection];
        isExtension = YES; // 现在为展开状态
        
    } else {
        
        if (currentExtensionMenu == selectedSection) { // 当前与上一次 相同
            
            UIImageView *selectedImgView = (UIImageView *)[self viewWithTag:selectedSection+TAG_OF_IMAGEVIEW_MARK];
            [UIView animateWithDuration:0.3 animations:^{
                selectedImgView.transform = CGAffineTransformRotate(selectedImgView.transform, M_PI);
            }];
            
            
            if (!isExtension) { // 展开
                
                [self showTableViewOnSection:selectedSection];
                
            } else { // 折叠
                
                [self hiddenTableViewOnSection];
                
            }
            
            isExtension = ! isExtension;
            
        } else { // 两次不同
            
            // 上一次的一定折叠
            if (isExtension) {
                UIImageView *currentImgView = (UIImageView *)[self viewWithTag:currentExtensionMenu + TAG_OF_IMAGEVIEW_MARK];
                [self hiddenTableViewOnSection];
                [UIView animateWithDuration:0.2 animations:^{
                    currentImgView.transform = CGAffineTransformRotate(currentImgView.transform, M_PI);
                }];
            }
            
            // 当前的一定是展开
            UIImageView *selectedImgView = (UIImageView *)[self viewWithTag:selectedSection+TAG_OF_IMAGEVIEW_MARK];
            [UIView animateWithDuration:0.2 animations:^{
                
                selectedImgView.transform = CGAffineTransformRotate(selectedImgView.transform, M_PI);
                
            } completion:^(BOOL finished) {

                [self showTableViewOnSection:selectedSection];
                
            }];

            isExtension = YES;
        }
        
    }
    
    currentExtensionMenu = selectedSection;
}

#pragma mark - showTableViewOnSection

- (void)showTableViewOnSection:(NSInteger)section{
    
    [self.listSuperView addSubview:self.listBaseView];
    [self.listSuperView addSubview:self.listTableView];
    
    CGRect rect = self.listSuperView.frame;
    rect.origin.y = CGRectGetMaxY(self.frame);
    rect.size.height -= rect.origin.y;
    [self.listBaseView setFrame:rect];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapONListBaseView:)];
    [self.listBaseView addGestureRecognizer:tap];
    
    if ([self.delegate respondsToSelector:@selector(dropListMenu:section:)]) {
        listData = [self.delegate dropListMenu:self section:section];
    }
    [self.listTableView reloadData];
    rect.origin.x = sectionWidth * section;
    rect.origin.y = CGRectGetMaxY(self.frame);
    rect.size.width = sectionWidth;
    rect.size.height = 0;
    self.listTableView.alpha = 1;
    [self.listTableView setFrame:rect];
    
    rect.size.height = 40 * listData.count;
    [UIView animateWithDuration:0.2 animations:^{

        self.listBaseView.alpha = 0.8;
        [self.listTableView setFrame:rect];
        
    }];

}

#pragma mark - hiddenTableViewOnSection

- (void)hiddenTableViewOnSection{

    CGRect rect = self.listTableView.frame;
    rect.size.height = 0;
    [UIView animateWithDuration:0.2 animations:^{
        
        self.listBaseView.alpha = 0.3;
        self.listTableView.alpha = 0.3;
        [self.listTableView setFrame:rect];
        
    } completion:^(BOOL finished) {
        
        [self.listBaseView removeFromSuperview];
        [self.listTableView removeFromSuperview];

    }];
    
    
}

#pragma mark - tapONListBaseView

- (void)tapONListBaseView:(UITapGestureRecognizer *)sendTap{
    
    UIImageView *currentImgView = (UIImageView *)[self viewWithTag:currentExtensionMenu + TAG_OF_IMAGEVIEW_MARK];
    [UIView animateWithDuration:0.3 animations:^{
        currentImgView.transform = CGAffineTransformRotate(currentImgView.transform, M_PI);
    }];
    [self hiddenTableViewOnSection];
    isExtension = ! isExtension;

}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identifier = @"ListTableViewCell";
    UITableViewCell *cell = [self.listTableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = listData[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{

    NSLog(@" --- ");
    
    if ([self.delegate respondsToSelector:@selector(dropListMenu:section:didSelectRowAtIndexPath:)]) {
        
        [self.delegate dropListMenu:self section:currentExtensionMenu didSelectRowAtIndexPath:indexPath];
        
        UIImageView *currentImgView = (UIImageView *)[self viewWithTag:currentExtensionMenu + TAG_OF_IMAGEVIEW_MARK];
        [UIView animateWithDuration:0.3 animations:^{
            currentImgView.transform = CGAffineTransformRotate(currentImgView.transform, M_PI);
        }];
        [self hiddenTableViewOnSection];
        isExtension = ! isExtension;
    }

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    
    
}

@end