//
//  TabBarAdapter.m
//  hinabian
//
//  Created by hnbwyh on 2019/5/10.
//  Copyright © 2019 深圳市海那边科技有限公司. All rights reserved.
//

#import "TabBarAdapter.h"
#import "HomeVC.h"
#import "DtVC.h"
#import "TrVC.h"
#import "MsVC.h"
#import "PersonVC.h"

@interface TabBarAdapter () <UITabBarControllerDelegate>
{
    WindowRootTabBarType theRootType;
}

@property (nonatomic, strong) CYLTabBarController *tabbarController;
@property (nonatomic, strong) UINavigationController *ymNav;
@property (nonatomic, strong) UINavigationController *hfNav;
@property (nonatomic, strong) UINavigationController *qzNav;
@property (nonatomic, strong) UINavigationController *msgNav;
@property (nonatomic, strong) UINavigationController *myNav;

@property (nonatomic,strong) CYLTabBarController *ymTabbarController;
@property (nonatomic,strong) CYLTabBarController *hfTabbarController;

@end

@implementation TabBarAdapter

+(instancetype)defaultInstance {
    static TabBarAdapter *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TabBarAdapter alloc] init];
    });
    return instance;
}

-(CYLTabBarController *)adapterTabBarVCWithType:(WindowRootTabBarType)rootType {
    theRootType = rootType;
    CYLTabBarController *tabbarController = [self resetTabbarControllerWithType:rootType];
    [self.tabbarController removeFromParentViewController];
    self.tabbarController = tabbarController;
    self.tabbarController.delegate = self;
    self.tabbarController.tabBar.backgroundColor = [UIColor whiteColor];
    [self customizeInterface];
    return self.tabbarController;
}

- (CYLTabBarController *)resetTabbarControllerWithType:(WindowRootTabBarType)type {
    if (type == WindowRootTabBarTypeFangChan) {
        //NSLog(@"\n 海房 => %@ \n",self.hfTabbarController);
        return self.hfTabbarController;
    } else {
        //NSLog(@"\n 移民 => %@ \n",self.ymTabbarController);
        return self.ymTabbarController;
    }
}

- (CYLTabBarController *)ymTabbarController {
    if (!_ymTabbarController) {
        _ymTabbarController = [[CYLTabBarController alloc]initWithViewControllers:self.ymvcs tabBarItemsAttributes:self.ymitems];
    }
    return _ymTabbarController;
}

- (CYLTabBarController *)hfTabbarController {
    if (!_hfTabbarController) {
        _hfTabbarController = [[CYLTabBarController alloc]initWithViewControllers:self.hfvcs tabBarItemsAttributes:self.hfitems];
    }
    return _hfTabbarController;
}

- (NSArray *)ymvcs {
    return @[self.ymNav,self.hfNav,self.qzNav,self.msgNav,self.myNav];
}

- (NSArray *)hfvcs {
    return @[self.hfNav,self.ymNav,self.qzNav,self.msgNav,self.myNav];
}

- (NSArray *)ymitems {
    NSDictionary *dic1 = @{
                           CYLTabBarItemTitle:@"移民",
                           CYLTabBarItemImage:@"index_icon_ym_normal",
                           CYLTabBarItemSelectedImage:@"index_icon_ym_pressed"
                           };
    
    NSDictionary *dic2 = @{
                           CYLTabBarItemTitle:@"房产",
                           CYLTabBarItemImage:@"index_icon_house_normal",
                           CYLTabBarItemSelectedImage:@"index_icon_house_pressed"
                           };
    
    NSDictionary *dic3 = @{
                           CYLTabBarItemTitle:@"圈子",
                           CYLTabBarItemImage:@"index_icon_quanzi_normal",
                           CYLTabBarItemSelectedImage:@"index_icon_quanzi_pressed"
                           };
    
    NSDictionary *dic4 = @{
                           CYLTabBarItemTitle:@"消息",
                           CYLTabBarItemImage:@"index_icon_message_normal",
                           CYLTabBarItemSelectedImage:@"index_icon_message_pressed"
                           };
    
    NSDictionary *dic5 = @{
                           CYLTabBarItemTitle:@"我的",
                           CYLTabBarItemImage:@"index_icon_my_normal",
                           CYLTabBarItemSelectedImage:@"index_icon_my_pressed"
                           };
    
    return @[dic1, dic2, dic3, dic4, dic5];
}

- (NSArray *) hfitems {
    NSDictionary *dic1 = @{
                           CYLTabBarItemTitle:@"房产",
                           CYLTabBarItemImage:@"index_icon_house_normal",
                           CYLTabBarItemSelectedImage:@"index_icon_house_pressed"
                           };
    
    NSDictionary *dic2 = @{
                           CYLTabBarItemTitle:@"移民",
                           CYLTabBarItemImage:@"index_icon_ym_normal",
                           CYLTabBarItemSelectedImage:@"index_icon_ym_pressed"
                           };
    
    NSDictionary *dic3 = @{
                           CYLTabBarItemTitle:@"圈子",
                           CYLTabBarItemImage:@"index_icon_quanzi_normal",
                           CYLTabBarItemSelectedImage:@"index_icon_quanzi_pressed"
                           };
    
    NSDictionary *dic4 = @{
                           CYLTabBarItemTitle:@"消息",
                           CYLTabBarItemImage:@"index_icon_message_normal",
                           CYLTabBarItemSelectedImage:@"index_icon_message_pressed"
                           };
    
    NSDictionary *dic5 = @{
                           CYLTabBarItemTitle:@"我的",
                           CYLTabBarItemImage:@"index_icon_my_normal",
                           CYLTabBarItemSelectedImage:@"index_icon_my_pressed"
                           };
    return @[dic1, dic2, dic3, dic4, dic5];
}

- (void)customizeInterface {
    UIFont *unSelectFont = [UIFont systemFontOfSize:10];
    UIColor *unSelectColor = [self colorWithHexString:@"#333333"];
    UIFont *selectFont = [UIFont systemFontOfSize:10];
    UIColor *selectColor = [self colorWithHexString:@"#1300FE"];
    
    NSMutableDictionary *attributDicNor = [NSMutableDictionary dictionary];
    [attributDicNor setValue:unSelectFont forKey:NSFontAttributeName];
    [attributDicNor setValue:unSelectColor forKey:NSForegroundColorAttributeName];
    
    NSMutableDictionary *attributDicSelect = [NSMutableDictionary dictionary];
    [attributDicSelect setValue:selectFont forKey:NSFontAttributeName];
    [attributDicSelect setValue:selectColor forKey:NSForegroundColorAttributeName];
    
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitlePositionAdjustment:UIOffsetMake(0, -3)];
//    [tabBar setTitleTextAttributes:attributDicNor forState:UIControlStateNormal];
//    [tabBar setTitleTextAttributes:attributDicSelect forState:UIControlStateSelected];
}

- (UIColor *)colorWithHexString:(NSString *)string {
    unsigned rgbValue = 0;
    string = [string stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


#pragma mark --- UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    NSLog(@"\n %s => %@ \n",__FUNCTION__,viewController);
    BOOL should = YES;
    [self.tabbarController updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController shouldSelect:should];
    UIControl *selectedTabButton = [viewController.tabBarItem cyl_tabButton];
    if (selectedTabButton.selected) {
        @try {
            //[[[self class] cyl_topmostViewController] performSelector:@selector(refresh)];
            NSLog(@"\n 🔴类名与方法名 \n");
        } @catch (NSException *exception) {
            NSLog(@"🔴类名与方法名：%@（在第%@行），描述：%@", @(__PRETTY_FUNCTION__), @(__LINE__), exception.reason);
        }
    }
    return should;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSLog(@"\n %s => %@ \n",__FUNCTION__,viewController);
}

#pragma mark --- lazy load

- (UINavigationController *)ymNav {
    if (_ymNav == nil) {
        HomeVC *vc = [HomeVC new];
        _ymNav = [[UINavigationController alloc]initWithRootViewController:vc];
    }
    return _ymNav;
}

- (UINavigationController *)hfNav {
    if (_hfNav == nil) {
        DtVC *vc = [[DtVC alloc]init];
        _hfNav = [[UINavigationController alloc]initWithRootViewController:vc];
    }
    return _hfNav;
}

- (UINavigationController *)qzNav {
    if (_qzNav == nil) {
        TrVC *vc = [[TrVC alloc]init];
        _qzNav = [[UINavigationController alloc]initWithRootViewController:vc];
    }
    return _qzNav;
}

- (UINavigationController *)msgNav {
    if (_msgNav == nil) {
        MsVC *vc = [[MsVC alloc]init];
        _msgNav = [[UINavigationController alloc]initWithRootViewController:vc];
    }
    return _msgNav;
}

- (UINavigationController *)myNav {
    if (_myNav == nil) {
        PersonVC *vc = [[PersonVC alloc]init];
        _myNav = [[UINavigationController alloc]initWithRootViewController:vc];
    }
    return _myNav;
}



@end
