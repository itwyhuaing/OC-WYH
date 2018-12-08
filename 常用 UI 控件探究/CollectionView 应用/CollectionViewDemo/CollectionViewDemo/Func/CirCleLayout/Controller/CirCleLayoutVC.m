//
//  CirCleLayoutVC.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/10/9.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "CirCleLayoutVC.h"
#import "CircleLayout.h"

@interface CirCleLayoutVC () <UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation CirCleLayoutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor           = [UIColor whiteColor];
    self.title                          = NSStringFromClass(self.class);
    [self configUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)configUI{
    CircleLayout * layout         = [[CircleLayout alloc] init];
    UICollectionView * collect              = [[UICollectionView alloc]initWithFrame:CGRectMake(50, 100, kScreenWidth-100, kScreenHeight-180) collectionViewLayout:layout];
    collect.delegate                        = self;
    collect.dataSource                      = self;
    collect.backgroundColor                 = [UIColor cyanColor];
    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellid"];
    [self.view addSubview:collect];
}


#pragma mark ------ UICollectionViewDelegate,UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *rltView;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *header     = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewHeader" forIndexPath:indexPath];
        rltView = header;
        rltView.backgroundColor     = [UIColor redColor];
    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        rltView     = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CFOOTERID" forIndexPath:indexPath];
        rltView.backgroundColor     = [UIColor purpleColor];
    }
    return rltView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell    *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    cell.contentView.backgroundColor                = [UIColor orangeColor];
    return cell;
}

@end
