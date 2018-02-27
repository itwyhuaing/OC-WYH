## iOS地图定位记录。

### 简要介绍
> 关于地图开发，Apple 提供的 API 在iOS6-iOS10过程中，有较大变化，这次记录以最新 API 为准。

* 在iOS开发中，Apple 提供了2个框架用于地图相关的开发：
1. Map Kit 用于地图展示
2. Core Location 用于地理定位
> 这里可以了解一下关于地图开发的两个热门专业术语：LBS (Location Based Service 基于定位的服务)、SoLoMo（Social Local Mobile 索罗门）

3. 头文件导入：#import <CoreLocation/CoreLocation.h>

* CoreLocation 定位服务


1. 属性
2. 方法
3. 应用
基本使用
首先：隐私配置

其次：判断系统定位权限是否打开

然后：弹框给用户，本APP启用地图定位的状态


* CLGeocoder 地理编码
>
1. 属性
2. 方法
3. 应用

##### 参考


NSLocationAlwaysAndWhenInUseUsageDescription
NSLocationWhenInUseUsageDescription
