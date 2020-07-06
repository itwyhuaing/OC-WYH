###### Web加载缓存问题



现象

* 1.0 cache-control 设置为 no-cache 属性时，第一次进入该页面，请求相应的资源 ，请求响应的状态码 200

![image](https://github.com/itwyhuaing/HybridAPP/blob/master/Web加载缓存问题/image/WK_12.png)

![image](https://github.com/itwyhuaing/HybridAPP/blob/master/Web加载缓存问题/image/WK_13.png)

![image](https://github.com/itwyhuaing/HybridAPP/blob/master/Web加载缓存问题/image/WK_14.png)

* 1.1 cache-control 设置为 no-cache 属性时，第二次进入该页面，请求相应的资源 ，请求响应的状态码 304

![image](https://github.com/itwyhuaing/HybridAPP/blob/master/Web加载缓存问题/image/WK_15.png)

![image](https://github.com/itwyhuaing/HybridAPP/blob/master/Web加载缓存问题/image/WK_16.png)

![image](https://github.com/itwyhuaing/HybridAPP/blob/master/Web加载缓存问题/image/WK_17.png)

* 1.2 cache-control 设置为 no-cache 属性时，清除缓存之后再次进入该页面，请求相应的资源 ，请求响应的状态码 200

![image](https://github.com/itwyhuaing/HybridAPP/blob/master/Web加载缓存问题/image/WK_18.png)

![image](https://github.com/itwyhuaing/HybridAPP/blob/master/Web加载缓存问题/image/WK_19.png)

![image](https://github.com/itwyhuaing/HybridAPP/blob/master/Web加载缓存问题/image/WK_20.png)

* 2.0 cache-control 设置为 max-age=43200 属性时（注意这里只有 index.html 资源文件的请求响应头中cache-control 设置为 no-cache）， 第一次进入该页面，请求相应的资源 ，请求响应的状态码 200

![image](https://github.com/itwyhuaing/HybridAPP/blob/master/Web加载缓存问题/image/WK_21.png)

![image](https://github.com/itwyhuaing/HybridAPP/blob/master/Web加载缓存问题/image/WK_22.png)

![image](https://github.com/itwyhuaing/HybridAPP/blob/master/Web加载缓存问题/image/WK_23.png)

* 2.1 cache-control 设置为 max-age=43200 属性时，第二次进入该页面，请求相应的资源 ，请求响应的状态码 304 ；其中 .css 资源与 .js 资源文件并未发出请求

![image](https://github.com/itwyhuaing/HybridAPP/blob/master/Web加载缓存问题/image/WK_24.png)

* 2.2 cache-control 设置为 max-age=43200 属性时，清除缓存之后再次进入该页面，请求相应的资源 ，请求响应的状态码 200

![image](https://github.com/itwyhuaing/HybridAPP/blob/master/Web加载缓存问题/image/WK_25.png)

![image](https://github.com/itwyhuaing/HybridAPP/blob/master/Web加载缓存问题/image/WK_26.png)

![image](https://github.com/itwyhuaing/HybridAPP/blob/master/Web加载缓存问题/image/WK_27.png)


* 2.3 页面反复进入多次之后，未清除缓存，此时 .html 、.js 、.css 三个资源文件均已被修改并发布，请求响应头 cache-control 设置为 no-cache 属性的文件在此时再次进入时会立刻前往服务器请求资源，而设置为 max-age=43200 属性的文件在此时再次进入时并没相应的请求发出。(这里的 4320 单位为秒，即 12 小时，在该时间内该资源文件会直接读取本地已缓存数据)

![image](https://github.com/itwyhuaing/HybridAPP/blob/master/Web加载缓存问题/image/WK_28.png)

![image](https://github.com/itwyhuaing/HybridAPP/blob/master/Web加载缓存问题/image/WK_29.png)



结论：
cache-control 设置为 no-cache 属性，第一次请求返回码 200 ，之后多次请求 304 ，页面修改之后的再次请求 200

cache-control 设置为 max-age=xx 属性，第一次请求返回码 200 ，之后多次请求 - 若请求发生在时间内则不会发出请求，若请求发生在时间之外则会重新发出请求

cache-control 无论设置怎样， 清楚缓存 ( WKWebsiteDataStore ) 之后，请求返回 200








##### 参考

* [HTTP缓存控制小结](http://imweb.io/topic/5795dcb6fb312541492eda8c)
