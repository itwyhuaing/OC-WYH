//
//  ThirdVC.m
//  CollectionViewDemo
//
//  Created by hnbwyh on 2018/10/9.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "ThirdVC.h"
#import "CustomLineLayout.h"
#import "CustomLineCell.h"

@interface ThirdVC () <UICollectionViewDataSource,UIScrollViewDelegate>

// imageName 数组 （图片的命名是按钮 1.jpg ， 2.jpg 来命名的）
@property (strong,nonatomic) NSMutableArray * imageNames;
// 控制器 View 里面的 CollectionView
@property (weak,nonatomic) UICollectionView *collectionView;

@end

@implementation ThirdVC


// 重用 ID
static NSString *const ID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor               = [UIColor whiteColor];
    self.title                              = NSStringFromClass(self.class);
    
    // 取出 layout
    CustomLineLayout *layout                = (CustomLineLayout *)self.collectionView.collectionViewLayout;
    // 为了让第一个 Item 放在最中间，所以设置了 edgeInsets
//    self.collectionView.contentInset    = UIEdgeInsetsMake(0, self.collectionView.bounds.size.width * 0.5 - layout.itemSize.width * 0.5 , 0, self.collectionView.bounds.size.width * 0.5 - layout.itemSize.width * 0.5);
    
    self.collectionView.backgroundColor     = [UIColor orangeColor];
    //self.collectionView.contentInset        = UIEdgeInsetsMake(0, 0 , 10, 0);
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"\n\n 测试:scrollViewDidScroll \n\n");
}


//数据源方法返回一共多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageNames.count;
}

//数据源方法，返回显示的是什么样的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.imageName  = self.imageNames[indexPath.item];
    return cell;
}

// 懒加载图片数组
- (NSMutableArray *)imageNames {
    
    if (!_imageNames) {
        _imageNames = [NSMutableArray array];
        for (int i = 0; i < 4; i++ ) {
            NSString *name = [NSString stringWithFormat:@"%d",i%5 + 1];
            [_imageNames addObject:name];
        }
    }
    return _imageNames;
}

//懒加载CollectionView。。。其实没必要
- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        //创建自定义的布局 【这个是重点】
        CustomLineLayout *layout = [[CustomLineLayout alloc] init];
        //创建collectionView并且设置frame ，frame是随便写的
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200) collectionViewLayout:layout];
        //collectionView.contentSize       = CGSizeMake(SCREEN_WIDTH * 2.0, 200);
        //不显示水平滚动条
        collectionView.showsHorizontalScrollIndicator = TRUE;
        //滑动
        collectionView.alwaysBounceHorizontal         = TRUE;
        //不显示垂直滚动条
        collectionView.showsVerticalScrollIndicator = NO;
        //随便设置了1个背景颜色
        collectionView.backgroundColor = [UIColor darkGrayColor];
        //设置数据源
        collectionView.dataSource = (id)self;
        collectionView.delegate   = (id)self;
        //注册Cell
        [collectionView registerClass:[CustomLineCell class] forCellWithReuseIdentifier:ID];
        //添加到控制器的View中
        [self.view addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

@end
