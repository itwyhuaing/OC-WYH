### URL Schemes

* URL Schemes是苹果给出的用来跳转到系统应用或者跳转到别人的应用的一种机制。同时还可以在应用之间传数据。

* 这里演示 SDemoA 打开 SDemoB

> 为使其他 APP 可以打开 SDemoB ，SDemoB 需做如下配置 （作如下配置之后会修改 工程的 .plist 文件）

  ![image](https://github.com/itwyhuaing/OC-WYH/blob/master/URL%20Schemes/image/SDemoB配置_1.png)


> SDemoA 若要打开 SDemoB ，SDemoA 的工程需做如下两步配置。

>> 1. URL Types 配置 （作如下配置之后会修改 工程的 .plist 文件）

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/URL%20Schemes/image/SDemoA配置_2.png)

>> 2. 工程配置白名单 LSApplicationQueriesSchemes

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/URL%20Schemes/image/SDemoA配置_3.png)


> A、B工程代码部分

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/URL%20Schemes/image/SDemoA与B代码配置_4.png)


##### 参考
* [URL Schemes 使用详解](https://sspai.com/post/31500#04)

* [Universal Links通用链接应用跳转总结以及坑](http://www.jianshu.com/p/16374288c976)

* [iOS H5打开App(通用链接)](https://www.jianshu.com/p/0ead88409212)
