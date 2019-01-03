//
//  LineLayoutVC.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/10/9.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "LineLayoutVC.h"
#import "LineLayout.h"
#import "JXCollectionViewCell.h"

@interface LineLayoutVC ()<UICollectionViewDataSource,UICollectionViewDelegate>

//imageName 数组 （图片的命名是按钮 1.jpg，2.jpg 来命名的）
@property (strong,nonatomic)    NSMutableArray * imageNames;

//控制器View里面的 CollectionView
@property (weak,nonatomic)      UICollectionView *collectionView;

@end

@implementation LineLayoutVC

// 重用ID
static NSString *const ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor               = [UIColor whiteColor];
    self.title                              = NSStringFromClass(self.class);
    
    self.collectionView.backgroundColor     = [UIColor orangeColor];
    
    //取出layout
    LineLayout *layout                  = (LineLayout *)self.collectionView.collectionViewLayout;
    // 为了让第一个 Item 放在最中间，所以设置了edgeInsets
    // self.collectionView.contentInset    = UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
//    self.collectionView.contentInset    = UIEdgeInsetsMake(0, self.collectionView.bounds.size.width * 0.5 - layout.itemSize.width * 0.5 , 0, self.collectionView.bounds.size.width * 0.5 - layout.itemSize.width * 0.5);
//    
//    CGFloat sw = [UIScreen mainScreen].bounds.size.width;
//    CGFloat sh = [UIScreen mainScreen].bounds.size.height;
//    self.collectionView.contentInset    = UIEdgeInsetsMake(0, sw * 0.5 , 0, sw * 0.5);
    
}

//数据源方法返回一共多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageNames.count;
}

//数据源方法，返回显示的是什么样的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JXCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imageName  = self.imageNames[indexPath.item];
    return cell;
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@" \n\n scrollViewDidScroll \n\n\n ");
}


// 懒加载图片数组
- (NSMutableArray *)imageNames {
    
    if (!_imageNames) {
        _imageNames = [NSMutableArray array];
        for (int i = 0; i < 800; i++ ) {
            NSString *name = [NSString stringWithFormat:@"%d",i%5 + 1];
            [_imageNames addObject:name];
        }
    }
    return _imageNames;
}

//懒加载CollectionView。。。其实没必要
- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        //创建自定义的布局【这个是重点】
        LineLayout *layout = [[LineLayout alloc] init];
        //创建collectionView并且设置frame ，frame是随便写的
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200) collectionViewLayout:layout];
        //不显示水平滚动条
        collectionView.showsHorizontalScrollIndicator = NO;
        //不显示垂直滚动条
        collectionView.showsVerticalScrollIndicator = NO;
        //随便设置了1个背景颜色
        collectionView.backgroundColor = [UIColor darkGrayColor];
        //设置数据源
        collectionView.dataSource = (id)self;
        collectionView.delegate   = (id)self;
        
        //注册Cell
        [collectionView registerClass:[JXCollectionViewCell class] forCellWithReuseIdentifier:ID];
        //添加到控制器的View中
        [self.view addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}


@end
