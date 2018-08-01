//
//  AppDelegate.h
//  CoreDataPro
//
//  Created by hnbwyh on 2018/8/1.
//  Copyright © 2018年 TongXing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

