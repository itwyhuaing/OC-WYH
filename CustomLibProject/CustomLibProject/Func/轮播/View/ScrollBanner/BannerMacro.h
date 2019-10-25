//
//  BannerMacro.h
//  CustomLibProject
//
//  Created by hnbwyh on 2019/10/18.
//  Copyright © 2019 JiXia. All rights reserved.
//

#ifndef BannerMacro_h
#define BannerMacro_h

#define ScreenHieght [UIScreen mainScreen].bounds.size.height
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width

#define kScrollBannerViewTimerOnNotify   @"scrollBannerView.timer.on.notify"
#define kScrollBannerViewTimerOffNotify  @"scrollBannerView.timer.off.notify"

/**< 理论上 imgViewArr 与给定的数据源数组有同样个数的元素，但为了更好地无线循环的体验效果，imgViewArr 往往多2个元素 >*/
#define IMGVIEW_EXTRA_COUNT         2
#define IMGVIEW_LOCATION_TAG        100


#endif /* BannerMacro_h */
