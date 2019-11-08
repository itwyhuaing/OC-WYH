## 推送功能
---

** APNs推送 **

* 全称是Apple Push Notification service(苹果推送通知服务) 。

* iOS 系统不准许 APP 常驻后台；但若要使设备能够收到 APNs 推送，就必须保证设备处于 online 的状态。

* 每条推送消息均有过期时间，过期消息将会被丢弃。

** VoIP推送 **

* 全称voice-over-ip。

* iOS 8 引入的功能。

* 只有生产环境证书，没有调试证书；只可在生产环境发现问题、验证问题。

* 这种推送可以使用户收到一个来电唤醒App；而且推送消息可以在后台唤醒App。

** 普通推送 **

* 收到推送后（有文字有声音），点开通知，进入APP后，才执行如下代码：

```
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;
```


** 静默推送 **

* iOS 7 引入的功能。

* 收到推送（没有文字没有声音），不用点开通知，不用打开APP，才执行如下代码：

```
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;
```


##### 参考

* [APNS与VoIP](https://www.jianshu.com/p/edbfd8d515de)
* [iOS开发—iOS静默推送介绍及使用场景](https://www.jianshu.com/p/f326987c737e)
* [三、<iOS 远程推送> 静默推送](https://www.jianshu.com/p/6095be45f4e4)


**功能集成的一般步骤**

1. 引入依赖库。
2. 工程配置。
3. 证书制作与上传。
4. 代码调试：注册推送、接收到消息处理。
5. 测试消息。

## 分享
---

**分享的方式**

* 配置对应 AppKey ：微信、微博、QQ、钉钉
* AirDrop       ： WhatsAPP、印象笔记
* 调用系统自带应用进行分享：短信、邮件

**功能集成的一般步骤**

1. 引入依赖库。
2. 第三方平台账号申请；获取 APPID与APPSecrect
3. 工程配置：导入框架、SSO白名单、URL Scheme配置。
4. 代码调试：初始化、调用、回调。

## 支付
---

**常用支付方式**

* 支付宝支付
* 微信支付


**支付宝支付集成的一般步骤**

* [参考](https://docs.open.alipay.com/200/105310)

1. 申请经过实名认证过的支付宝账号。
2. 使用该账号登录支付宝开放平台。
3. 在该账号下创建应用
  - 选择应用类型：第三方应用 or 自用型应用
4. 选择接入支付的支付能力类型：支付接入 or 自定义接入 or 商业消费 or 交通出行 or 政务民生 or 医疗教育
5. 填写应用基本信息：应用名称、应用图标（320px * 320px , < 3M）
6. 开通相应功能 - APP 支付。
7. 配置应用环境
8. 查看 APPID
9. 引入依赖库、配置工程环境
10. 调试代码

**微信支付集成的一般步骤**

* [参考](https://developers.weixin.qq.com/doc/oplatform/Mobile_App/WeChat_Pay/Vendor_Service_Center.html)

* 注：微信支付、微信分享、微信登录共用同一套微信开放平台分配的 APPID 和 APPSecrect ；所以在微信支付过程中，应用的创建并不同于支付宝直接在收款账号下创建。

1. 微信开放平台注册账号并创建应用，获取APPID 和 APPSecrect。
2. 申请收款账号。
3. 登录收款账号，开通APP支付功能。
4. 引入依赖库、配置工程环境
5. 调试代码

## 第三方登录
---

**微信登录**

* [参考](https://developers.weixin.qq.com/doc/oplatform/Mobile_App/WeChat_Login/Development_Guide.html)


**QQ登录**

* [参考](https://wiki.open.qq.com/wiki/【QQ登录】IOS_SDK使用说明)
