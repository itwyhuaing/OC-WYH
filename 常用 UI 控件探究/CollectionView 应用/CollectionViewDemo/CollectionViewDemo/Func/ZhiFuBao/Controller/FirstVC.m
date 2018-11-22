//
//  FirstVC.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/9/28.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "FirstVC.h"
#import "CommonReusableHeader.h"
#import "CommonItem.h"
#import "ZFBItemModel.h"

#define kMAX_COUNT              12

@interface FirstVC () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView                           *collectionV;
@property (nonatomic,strong) NSMutableArray<ZFBItemModel *>             *listData;

@end

@implementation FirstVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor           = [UIColor whiteColor];
    self.title                          = NSStringFromClass(self.class);
    [self.collectionV registerClass:[CommonItem class] forCellWithReuseIdentifier:NSStringFromClass(CommonItem.class)];
    [self.collectionV registerClass:[CommonReusableHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(CommonReusableHeader.class)];
    [self.collectionV registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CFOOTERID"];
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

#pragma mark ------ UICollectionViewDelegate,UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.listData.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    ZFBItemModel *zfb = self.listData[section];
    return zfb.items.count;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *rltView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
       CommonReusableHeader *header     = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(CommonReusableHeader.class) forIndexPath:indexPath];
        header.them                     = self.listData[indexPath.section].themText;
        rltView = header;
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        rltView     = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CFOOTERID" forIndexPath:indexPath];
        //rltView.backgroundColor     = [UIColor purpleColor];
    }
    return rltView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CommonItem    *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(CommonItem.class) forIndexPath:indexPath];
    cell.contentView.backgroundColor                = [UIColor orangeColor];
    cell.data           = self.listData[indexPath.section].items[indexPath.row];
    return cell;
}

#pragma mark ------ 数据

- (void)loadData{
    [self.listData removeAllObjects];
    NSArray *thems              = @[@"最近使用",@"我的应用",@"智慧城市",@"我的金融",@"我的生活"];
    for (NSInteger sectionCount = 0; sectionCount < thems.count; sectionCount ++) {
        ZFBItemModel    *m      = [ZFBItemModel new];
        m.themText              = thems[sectionCount];
        NSMutableArray *tmpData = [NSMutableArray new];
        for (NSInteger cou = 0; cou < kMAX_COUNT; cou ++) {
            ItemModel *f         = [ItemModel new];
            f.name               = [NSString stringWithFormat:@"name%ld",cou];
            f.itemid             = [NSString stringWithFormat:@"%ld",cou];
            f.icon               = @"search_icon";
            [tmpData addObject:f];
        }
        m.items                  = tmpData;
        [self.listData addObject:m];
    }
    [self.collectionV reloadData];
}

#pragma mark ------ lazy load

-(UICollectionView *)collectionV{
    if (!_collectionV) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumLineSpacing          = 10.0 * SCREEN_WIDTHRATE_6;
        flowLayout.minimumInteritemSpacing     = 10.0 * SCREEN_WIDTHRATE_6;
        flowLayout.itemSize                    = CGSizeMake(56.0 * SCREEN_WIDTHRATE_6, 56.0 * SCREEN_WIDTHRATE_6);
        flowLayout.headerReferenceSize         = CGSizeMake(SCREEN_WIDTH, 30);
        flowLayout.footerReferenceSize         = CGSizeMake(SCREEN_WIDTH, 5);
        flowLayout.sectionHeadersPinToVisibleBounds = TRUE; 
        _collectionV                           = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        _collectionV.backgroundColor           = [UIColor whiteColor];
        _collectionV.delegate                  = (id)self;
        _collectionV.dataSource                = (id)self;
        [self.view addSubview:_collectionV];
    }
    return _collectionV;
}


-(NSMutableArray *)listData{
    if (!_listData) {
        _listData               = [NSMutableArray new];
    }
    return _listData;
}


@end
