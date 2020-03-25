## iOS地图定位记录。

##### 简要介绍
> 关于地图开发，Apple 提供的 API 在iOS6-iOS10过程中，有较大变化，这次记录以最新 API 为准。

* 在iOS开发中，Apple 提供了2个框架用于地图相关的开发：
1. Map Kit 用于地图展示
2. Core Location 用于地理定位
> 这里可以了解一下关于地图开发的两个热门专业术语：LBS (Location Based Service 基于定位的服务)、SoLoMo（Social Local Mobile 索罗门）

3. 头文件导入：#import <CoreLocation/CoreLocation.h>

##### CoreLocation 定位服务

1. 属性

```
CLLocationManager :统一管理地理位子信息的类
@property(assign, nonatomic) CLLocationDistance distanceFilter; // 每隔多少米重新定位一次
@property(assign, nonatomic) CLLocationAccuracy desiredAccuracy; // 定位精准度 (一般来说，越精准就越耗电)

CLLocation        : 位置信息，比较重要的是经纬度
@property(readonly, nonatomic) CLLocationCoordinate2D coordinate; // 经纬度
 typedef struct {
     CLLocationDegrees latitude; // 纬度
     CLLocationDegrees longitude; // 经度
 } CLLocationCoordinate2D;
@property(readonly, nonatomic) CLLocationDirection course; // 航向
@property(readonly, nonatomic) CLLocationDirection speed;  // 速度
@property(readonly, nonatomic) CLLocationDistance altitude; // 海拔
@property(readonly, nonatomic) CLLocationAccuracy horizontalAccuracy; // 水平方向位置的精准度，倘若定位成功，该值不应小于 0
@property(readonly, nonatomic) CLLocationAccuracy verticalAccuracy; // 垂直方向位置的精准度，倘若定位成功，该值不应小于 0
@property(readonly, nonatomic, copy) NSDate *timestamp; // 获取当前位置时的时间戳
@property(assign, nonatomic) BOOL allowsBackgroundLocationUpdates; // 是否准许定位后台更新 - 注意 iOS 9+ 可用
- (instancetype)initWithLatitude:(CLLocationDegrees)latitude
longitude:(CLLocationDegrees)longitude;
- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate
altitude:(CLLocationDistance)altitude
horizontalAccuracy:(CLLocationAccuracy)hAccuracy
verticalAccuracy:(CLLocationAccuracy)vAccuracy
timestamp:(NSDate *)timestamp;
- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate
altitude:(CLLocationDistance)altitude
horizontalAccuracy:(CLLocationAccuracy)hAccuracy
verticalAccuracy:(CLLocationAccuracy)vAccuracy
course:(CLLocationDirection)course
speed:(CLLocationSpeed)speed
timestamp:(NSDate *)timestamp API_AVAILABLE(ios(4.2), macos(10.7));
// 计算2个位置之间的距离
- (CLLocationDistance)distanceFromLocation:(const CLLocation *)location;

CLLocationManagerDelegate :请求获取地理定位的位置回调

```

2. 基本使用 （LocationsProject - LocationVC）

* 首先：隐私配置 ，info.plist 文件配置
* 其次：判断系统定位权限是否打开
* 然后：弹框给用户，本APP启用地图定位的状态

##### 区域监听

1. 基本使用（LocationsProject - RegionVC）

* 首先需要准许使用地图定位

##### CLGeocoder 地理编码

1. 基本使用（LocationsProject - GeoCoderVC）

* 首先需要准许使用地图定位


##### 参考
