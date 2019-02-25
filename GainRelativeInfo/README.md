# 获取设备当前信息、新用户统计及新用户来源追踪

## 设备标识
#### IDFA （32 位）

*  广告标识符 - Apple 专门给各广告提供商用来追踪用户设置的32位标识符。默认设置为允许追踪。设置 - 隐私 - 广告 可以自行设置。在被允许访问的情况下，卸载之后再安装，该字符串保持不变。在不被允许情况下，iOS10 开始开发者将会读取到32位全0的字符串；iOS10之前版本即便不被允许，开发者还是可以取到32位字符串，只是这时的字符串不同于被允许情况下的字符串，而且还有可能发生变化(这种情况测试设备为 iPhone6 - 中国电信 - iOS9.2 - 未越狱 - MG4H2J/A)。

```
[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]
```

#### UDID （40 位）

* UDID [Unique Device Identifier Description] - Apple 提供的用来区别每一个iOS设备(iPhone、iPad、iPod)的由字母和数字组成的40位字符串。该字符串与硬件设备相关。开发者会注意到，添加测试机时就需要先获取该字符串，这是因为Apple的消息推送功能及区分不同应用程序功能上都有用到该字符串。由于该字符串涉及用户隐私，所以Apple在iOS5之后禁止开发者试图获取该字符串；否则应用将被禁止上架。

#### IDFV

* IDFV [identifierForVendor] - 给Vendor用以标识用户的32位字符串，每个设备在所属同一个Vendor的应用里具有相同的值；虽然该标识一定可以读取到，但卸载以后再安装该字符串的读取值会发生变化。

#### MAC地址

* 在iOS 7中苹果再一次无情的封杀mac地址，使用之前的方法获取到的mac地址全部都变成了02:00:00:00:00:00。

#### Keychain

* 我们可以把 Keychain 理解为一个 Dictionary,其中的数据均以key-value的形式存储，可以对该Dictionary进行add、update、get、delete四个操作。
* 对于每一个应用来说，Keychain 都有两个访问区即私有区和公共区。私有区是一个 sandbox ，本程序存储的任何数据对其他程序不可见。而要将数据存储在公共区，需要先声明公共区的名称。
* iOS的 Keychain 服务提供了一种安全的保存私密信息的方式，每个iOS应用程序均有一个独立的 Keychain 存储。Keychain存储的信息不会因APP的删除而丢失，只要是同一个APP（bunldid）,即便重新安装，依旧可以读取到Keychain里存储的数据。
* 这样就可以将获取到 UUID ，保存到KeyChain里面。
* 刷机或重装系统后 UUID 还是会改变。
* 倘若只是配置同一个 bunldleid 无论卸载与否均可以使用同一个 UUID ,可做如下配置。


第一：添加文件

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/GainRelativeInfo/image/img1.png)



第二：配置工程

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/GainRelativeInfo/image/img2.png)



第三：存操作

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/GainRelativeInfo/image/img3.png)



第四：取操作

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/GainRelativeInfo/image/img4.png)


#### deviceToken 推送
* 64位字符串,同一台设备卸载在安装值会改变,不被允许时全0；每次安装都是唯一的

#### SimulateIDFA
* 尽可能多的读取设备信息生成唯一标识

## 应用

> 数据统计、用户追踪这些是应用推广运营工作中所需的参数指标；与技术开发工作者而言，解决用户设备唯一标识无疑是首先面对的问题。iOS 系统原本有一个可用于唯一标记设备的字符串标记，只是当用户关闭广告追踪时，便无法获取。

* 用户激活统计：网上很多各种各样的解决方案；但无疑归纳一下三种方式，1> 取设备的 IDFA ；2> 尽可能多的取设备的信息然后附加随机参数在自定义生成；3> 数据存储 Keychain 中。

#### 问题讨论

* 在应用 A 中推广应用 B 的下载链接，倘若应用 B 想统计通过应用 A 推广链接而来的新用户；网上有资料说可以考虑 iOS9 后苹果推出的 SafariServices 或者 iOS10 之后的剪切板共享数据。

* 网上给出的两种方案大致如下：

> 1.1>  iOS 因为系统封闭无法取得其他应用的信息， iOS9 后苹果推出的 SafariServices 可以在应用中打开一个 Safari 页面，这里可以尝试获取 Safari 的 cookie 。

> 1.2> 假定未安装 B 应用的新用户在应用 A 中点击了跳转下载应用 B 的中转页；中转页可以将必要信息写入系统 cookie 。

> 1.3> 用户下载 B 应用之后通过 SafariServices 获取系统 cookie(这里说的 cookie 不同与应用内部 UIWebView 或 WKWebView 所开辟的 cookie 存储区) 数据。



> 2.1> 虽然iOS系统封闭，但可以通过剪切板互通数据（iOS 10 一下 JS 无法读写剪切板）。

> 2.2>  假定未安装 B 应用的新用户在应用 A 中点击了跳转下载应用 B 的中转页 ；该用户打开的中转页将必要的信息通过 JS 写入系统剪切板 。

> 2.3> 用户下载应用 B 之后，使用原生操作剪切板的 API 读取系统剪切板内容（已尝试，失败）。

> 2.3> 用户下载应用 B 之后，可以尝试使用应用 B 加载一个 web ，再次借用 JS 读取系统剪切板（未尝试）。

* 在应用中使用苹果在 iOS9 之后推出的 SafariServices 服务的确可以读取到设备默认浏览器的 cookie ；但应用读取过程中必须展示一个类似 Safari 打开的网页，当然你可以在其上加一层蒙版。剪切板方案测试中，JS 并未成功操作系统剪切板，所以应用的原生 API 也就读取不到； 但该方案可以尝试在原生应用中加载一个 Web 页来读取剪切板。

##### 参考
* [获取iOS设备唯一标示UUID](http://www.jianshu.com/p/2741f0124cd3)
* [SimulateIDFA，新一代iOS设备的广告追踪解决方案](http://www.cocoachina.com/industry/20161014/17761.html) [SimulateIDFA Git地址](https://github.com/youmi/SimulateIDFA.git)
