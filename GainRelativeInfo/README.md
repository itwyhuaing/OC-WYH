### 获取设备当前信息

#### 设备标识
###### IDFA

*  广告标识符 - Apple 专门给各广告提供商用来追踪用户设置的32位标识符。默认设置为允许追踪，当不被允许时，将会读取到32位全0的字符串。设置 - 隐私 - 广告 可以自行设置。

###### UDID

* UDID [Unique Device Identifier Description] - Apple 提供的用来区别每一个iOS设备(iPhone、iPad、iPod)的由字母和数字组成的40位字符串。该字符串与硬件设备相关。开发者会注意到，添加测试机时就需要先获取该字符串，这是因为Apple的消息推送功能及区分不同应用程序功能上都有用到该字符串。由于该字符串涉及用户隐私，所以Apple在iOS5之后禁止开发者试图获取该字符串；否则应用将被禁止上架。

###### IDFV

* IDFV [identifierForVendor] - 给Vendor用以标识用户的32位字符串，每个设备在所属同一个Vendor的应用里具有相同的值；虽然该标识一定可以读取到，但卸载以后再安装该字符串的读取值会发生变化。


###### Keychain

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
