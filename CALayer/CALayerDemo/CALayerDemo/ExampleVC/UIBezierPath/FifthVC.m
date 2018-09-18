//
//  FifthVC.m
//  CALayerDemo
//
//  Created by hnbwyh on 2018/9/13.
//  Copyright © 2018年 ZhiXingJY. All rights reserved.
//

#import "FifthVC.h"

@interface FifthVC ()

@property (nonatomic,strong) UIView                 *sview;
@property (nonatomic,assign) BOOL                   isClicked;
@property (nonatomic,strong) NSMutableArray         *dataSource;
@property (nonatomic,strong) NSMutableArray         *pathData;
@property (nonatomic,strong) NSMutableArray         *layerData;

@end

@implementation FifthVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *tv = [[UIView alloc] initWithFrame:self.view.bounds];
    tv.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:tv];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = FALSE;
    self.title          = NSStringFromClass(self.class);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _isClicked = !_isClicked;
    if (_isClicked) {
        [self drawLineWithCount:5];
    } else {
        [self drawLineWithCount:10];
    }
}

- (void)drawLineWithCount:(NSInteger)count{
    // 1.
    [self composeDataSourceWithCount:count];
    // 2.
    for (UIBezierPath *p in self.pathData) {
        [p removeAllPoints];
    }
    for (CAShapeLayer *l in self.layerData) {
        [l removeFromSuperlayer];
    }

    CGPoint curPoint    = CGPointZero;
    CGPoint prePoint    = CGPointZero;
    CGPoint midPoit     = CGPointZero;
    UIBezierPath *path  = [UIBezierPath bezierPath];
    for (NSInteger cou = 0; cou < self.dataSource.count; cou ++) {
        curPoint  = [(NSValue *)self.dataSource[cou] CGPointValue];
        midPoit   = CGPointMake((curPoint.x + prePoint.x)/2.0,
                                (curPoint.y + prePoint.y)/2.0);
        if (cou <= 0) {
            [path moveToPoint:curPoint];
        }else{
            [path addQuadCurveToPoint:curPoint controlPoint:midPoit];
        }
        prePoint = curPoint;
    }
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];

    shapeLayer.path          = path.CGPath;
    shapeLayer.strokeColor   = count <=5 ? [UIColor blackColor].CGColor:[UIColor redColor].CGColor;
    shapeLayer.fillColor     = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth     = 3.0;
    [self.sview.layer addSublayer:shapeLayer];

    
    [self.pathData removeAllObjects];
    [self.layerData removeAllObjects];
    [self.pathData addObject:path];
    [self.layerData addObject:shapeLayer];
}


- (void)composeDataSourceWithCount:(NSInteger)count{
    [self.dataSource removeAllObjects];
    NSArray *xs     = @[@20,@40,@60,@80,@100,@120,@140,@160,@180,@200];
    NSArray *ys     = @[@200,@140,@68,@80,@110,@60,@40,@30,@90,@56];
    NSInteger max1  = MIN(count, xs.count);
    NSInteger max   = MIN(max1, ys.count);
    for (NSInteger cou = 0; cou < max; cou ++) {
        CGFloat px  = [(NSNumber *)xs[count<=5?cou%2:cou] floatValue];
        CGFloat py  = [(NSNumber *)ys[count<=5?cou%2:cou] floatValue];
        CGPoint pt  = CGPointMake(px, py);
        NSValue *pv = [NSValue valueWithCGPoint:pt];
        [self.dataSource addObject:pv];
    }
}

-(UIView *)sview{
    if (!_sview) {
        CGRect rect             = self.view.bounds;
        rect.size.height        -= 160.0;
        _sview = [[UIView alloc] initWithFrame:rect];
        _sview.backgroundColor  = [UIColor orangeColor];
        [self.view addSubview:_sview];
    }
    return _sview;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource         = [NSMutableArray new];
    }
    return _dataSource;
}

-(NSMutableArray *)pathData{
    if (!_pathData) {
        _pathData           = [NSMutableArray new];
    }
    return _pathData;
}

-(NSMutableArray *)layerData{
    if (!_layerData) {
        _layerData          = [NSMutableArray new];
    }
    return _layerData;
}

@end
