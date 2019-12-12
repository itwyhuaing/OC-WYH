//
//  JSEditorToolBar.m
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2019/12/10.
//  Copyright © 2019 hainbwyh. All rights reserved.
//

#import "JSEditorToolBar.h"
#import "JSEditorBarCommonCell.h"

@interface JSEditorToolBar () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
/**<view>*/
@property (nonatomic,strong) UICollectionViewFlowLayout     *layout;
@property (nonatomic,strong) UICollectionView               *collectV;
@property (nonatomic,strong) NSMutableArray                 *items;
/**<样式>*/
@property (nonatomic,assign) CGFloat                        itemLineSpace;
@property (nonatomic,assign) CGSize                         itemSize;
@property (nonatomic,assign) UIEdgeInsets                   barInset;

@end

@implementation JSEditorToolBar

#pragma mark ------ init

- (instancetype)initWithFrame:(CGRect)frame items:(nonnull NSArray *)items {
    self = [super initWithFrame:frame];
    if (self) {
        _items = [[NSMutableArray alloc] initWithArray:items];
        [self initData];
        [self initUI];
    }
    return self;
}

- (void)initData{
    _itemLineSpace = 0.0;
    _barInset = UIEdgeInsetsZero;
    _itemSize = CGSizeMake(CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
}

- (void)initUI{
    self.collectV.bounces = FALSE;
    self.collectV.showsHorizontalScrollIndicator = FALSE;
    [self.collectV registerClass:[JSEditorBarCommonCell class] forCellWithReuseIdentifier:NSStringFromClass(JSEditorBarCommonCell.class)];
    self.collectV.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.collectV];
    
    // top - bottom : line
    [self createLayerWithOriginY:0];
    [self createLayerWithOriginY:CGRectGetHeight(self.frame)-LAYER_LINE_HEIGHT];
}

- (void)createLayerWithOriginY:(CGFloat)y{
    CGRect rect = self.frame;
    rect.origin.y = y;
    rect.size.height = LAYER_LINE_HEIGHT;
    CALayer *l = [CALayer layer];
    [l setFrame:rect];
    [self.layer addSublayer:l];
    l.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8].CGColor;
}

- (UICollectionView *)collectV{
    if (!_collectV) {
        CGRect rect = self.frame;
        rect.origin = CGPointZero;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectV = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
        _collectV.delegate = self;
        _collectV.dataSource = self;
    }
    return _collectV;
}

- (void)dealloc {
    [self logMessage:[NSString stringWithFormat:@"\n%s\n",__FUNCTION__]];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    JSEditorBarCommonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(JSEditorBarCommonCell.class)
                                                                            forIndexPath:indexPath];
    cell.data = self.items[indexPath.row];
    return cell;
    
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    ToolBarItem *item = self.items[indexPath.row];
    [self intendToActWithData:item];
    [self.collectV reloadData];
}

- (void)intendToActWithData:(ToolBarItem *)data {
    data.isOn = !data.isOn;
    switch (data.funcType) {
            case JSEditorToolBarKeyBaord:
            {
                OperateIntention intention = data.isOn ? OperateIntentionON : OperateIntentionOFF;
                [self logMessage:[NSString stringWithFormat:@"点击位置:JSEditorToolBarKeyBaord,操作意向：%lu",intention]];
                self.toolBarBlk ? self.toolBarBlk(JSEditorToolBarKeyBaord, intention) : nil;
            }
            break;
            case JSEditorToolBarInsertImage:
            {
                OperateIntention intention = data.isOn ? OperateIntentionON : OperateIntentionOFF;
                [self logMessage:[NSString stringWithFormat:@"点击位置:JSEditorToolBarInsertImage,操作意向：%lu",intention]];
                self.toolBarBlk ? self.toolBarBlk(JSEditorToolBarInsertImage, intention) : nil;
            }
                break;
            case JSEditorToolBarBold:
            {
                OperateIntention intention = data.isOn ? OperateIntentionON : OperateIntentionOFF;
                [self logMessage:[NSString stringWithFormat:@"点击位置:JSEditorToolBarBold,操作意向：%lu",intention]];
                self.toolBarBlk ? self.toolBarBlk(JSEditorToolBarBold, intention) : nil;
            }
                break;
            case JSEditorToolBarItalic:
            {
                OperateIntention intention = data.isOn ? OperateIntentionON : OperateIntentionOFF;
                [self logMessage:[NSString stringWithFormat:@"点击位置:JSEditorToolBarItalic,操作意向：%lu",intention]];
                self.toolBarBlk ? self.toolBarBlk(JSEditorToolBarItalic, intention) : nil;
            }
                break;
            case JSEditorToolBarStrikethrough:
            {
                OperateIntention intention = data.isOn ? OperateIntentionON : OperateIntentionOFF;
                [self logMessage:[NSString stringWithFormat:@"点击位置:JSEditorToolBarStrikethrough,操作意向：%lu",intention]];
                self.toolBarBlk ? self.toolBarBlk(JSEditorToolBarStrikethrough, intention) : nil;
            }
                break;
            case JSEditorToolBarH1:
            {
                OperateIntention intention = data.isOn ? OperateIntentionON : OperateIntentionOFF;
                [self logMessage:[NSString stringWithFormat:@"点击位置:JSEditorToolBarH1,操作意向：%lu",intention]];
                self.toolBarBlk ? self.toolBarBlk(JSEditorToolBarH1, intention) : nil;
            }
                break;
            case JSEditorToolBarH2:
            {
                OperateIntention intention = data.isOn ? OperateIntentionON : OperateIntentionOFF;
                [self logMessage:[NSString stringWithFormat:@"点击位置:JSEditorToolBarH2,操作意向：%lu",intention]];
                self.toolBarBlk ? self.toolBarBlk(JSEditorToolBarH2, intention) : nil;
            }
                break;
            case JSEditorToolBarH3:
            {
                OperateIntention intention = data.isOn ? OperateIntentionON : OperateIntentionOFF;
                [self logMessage:[NSString stringWithFormat:@"点击位置:JSEditorToolBarH3,操作意向：%lu",intention]];
                self.toolBarBlk ? self.toolBarBlk(JSEditorToolBarH3, intention) : nil;
            }
                break;
            case JSEditorToolBarH4:
            {
                OperateIntention intention = data.isOn ? OperateIntentionON : OperateIntentionOFF;
                [self logMessage:[NSString stringWithFormat:@"点击位置:JSEditorToolBarH4,操作意向：%lu",intention]];
                self.toolBarBlk ? self.toolBarBlk(JSEditorToolBarH4, intention) : nil;
            }
                break;
            
        default:
            break;
    }
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.itemSize;
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    // Top - Left - Bottom - Right
    return self.barInset;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.itemLineSpace;
}

#pragma mark ------ 内部接收到信号，更新 UI

- (void)updateToolBarWithButtonName:(NSString *)name {
    
    // Items that are enabled
    NSArray *itemNames = [name componentsSeparatedByString:@","];
    
    for (NSInteger cou = 0;cou < itemNames.count;cou ++) {
        if([itemNames containsObject:@"strikeThrough"]){
            [self updateDataSourceWithType:JSEditorToolBarStrikethrough status:TRUE];
        }else{
            [self updateDataSourceWithType:JSEditorToolBarStrikethrough status:FALSE];
        }

        if([itemNames containsObject:@"bold"]){
           [self updateDataSourceWithType:JSEditorToolBarBold status:TRUE];
        }else{
            [self updateDataSourceWithType:JSEditorToolBarBold status:FALSE];
        }

        if([itemNames containsObject:@"italic"]){
            [self updateDataSourceWithType:JSEditorToolBarItalic status:TRUE];
        }else{
            [self updateDataSourceWithType:JSEditorToolBarItalic status:FALSE];
        }

        if([itemNames containsObject:@"h1"]){
            [self updateDataSourceWithType:JSEditorToolBarH1 status:TRUE];
        }else{
            [self updateDataSourceWithType:JSEditorToolBarH1 status:FALSE];
        }

        if([itemNames containsObject:@"h2"]){
            [self updateDataSourceWithType:JSEditorToolBarH2 status:TRUE];
        }else{
            [self updateDataSourceWithType:JSEditorToolBarH2 status:FALSE];
        }

        if([itemNames containsObject:@"h3"]){
            [self updateDataSourceWithType:JSEditorToolBarH3 status:TRUE];
        }else{
            [self updateDataSourceWithType:JSEditorToolBarH3 status:FALSE];
        }

        if([itemNames containsObject:@"h4"]){
            [self updateDataSourceWithType:JSEditorToolBarH4 status:TRUE];
        }else{
            [self updateDataSourceWithType:JSEditorToolBarH4 status:FALSE];
        }
        
    }
    [self.collectV reloadData];
}

- (void)updateDataSourceWithType:(JSEditorToolBarFuncType)type status:(BOOL)status {
    ToolBarItem *item = [self itemForType:type];
    item.isOn = status;
}

- (ToolBarItem *)itemForType:(JSEditorToolBarFuncType)type {
    ToolBarItem *rlt;
    for (ToolBarItem *i in self.items) {
        if (type == i.funcType) {
            rlt = i;
        }
    }
    return rlt;
}

-(void)setYStatus:(JSEditorToolBarYStatus)yStatus {
    ToolBarItem *item = [self itemForType:JSEditorToolBarKeyBaord];
    BOOL status = (yStatus == JSEditorToolBarYHight) ? TRUE : FALSE;
    item.isOn = status;
    [self.collectV reloadData];
}

#pragma mark ------ isLog

-(void)setIsLog:(BOOL)isLog {
    _isLog = isLog;
}

- (void)logMessage:(NSString *)msg {
    _isLog ? NSLog(@"\n%s:%@\n\n",__FUNCTION__,msg) : nil;
}

@end
