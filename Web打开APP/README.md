## URL Schemes

> 笔记修改更新于 20190815 ；系统和API 均在更新，测试于iPhone XR ios 12

#### URL schemes 简介
* URL schemes是苹果给出的用来跳转到系统应用或者跳转到别人的应用的一种机制。同时还可以在应用之间传数据。

#### 这里演示 SDemoA 打开 SDemoB

* 为使其他 APP 可以打开 SDemoB ，SDemoB 需做如下配置 （作如下配置之后会修改 工程的 .plist 文件），即配置 URL schemes

  ![image](https://github.com/itwyhuaing/OC-WYH/blob/master/Web打开APP/image/SDemoB配置_1.png)


* SDemoA 若要打开 SDemoB ，SDemoA 的工程需做如下配置;即将 SDemoB 已配置的 URL schemes 标识添加到工程的白名单（LSApplicationQueriesSchemes）中。

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/Web打开APP/image/SDemoA配置_2.png)


* A、B工程代码部分

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/Web打开APP/image/SDemoA与B代码配置_3.png)


#### URL schemes 与 白名单

* URL schemes 配置之后的应用运行在设备上之后，所配置的标记会“注册”到系统中；不同的应用有可能相同；但是否会覆盖有待进一步测试（查阅资料显示，有说会覆盖也有说不会覆盖的）。
* “注册”操作之后，该应用在该设备上就可以通过其他应用打开或者可以直接在 Safari 中验证,譬如

> SDemoB 工程配置了 URL schemes ，

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/Web打开APP/image/image_1.jpg)


> 那么在 Safari 中可以输入类似 “appSDemoB://xxx” 的链接直接打开 SDemoB ,xxx 为参数

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/Web打开APP/image/image_2.jpg)

> 打开之后的显示如下，这里左上角标记可以回到 safari

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/Web打开APP/image/image_3.jpg)


* iOS 9 之后，系统加强安全性，倘若你的应用想要打开其他app，就需要事先将带打开app所配置的 URL schemes 添加到你工程的白名单当中；但 Safari 依旧在iOS 9 之后可以直接打开，是否也已添加尚不可知。

## Universal Links


##### 参考


> 值得实践的技术与笔记

* [iOS H5打开App(通用链接)](https://www.jianshu.com/p/0ead88409212)
