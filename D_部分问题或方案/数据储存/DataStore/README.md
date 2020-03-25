## DataStore 数据存储

### 常见存储方式
* Plist 格式文件存储
* NSUserDefaults 沙盒存储(个人偏好存储)
* 文件读写储存
* 解归档存储
* 数据库存储
* Keychain 存储(可解决设备唯一标识问题)

### Demo 示例

* 文件读写操作、沙盒操作、解归档操作、依赖 FMDB 的数据库操作 以及 UIWeb/WKWeb 缓存清理 、NSPredicate 数据筛查等操作 [DataStore Git地址](https://github.com/itwyhuaing/OC-WYH/tree/master/DataStore)


![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/demo1.png)

* 依赖 MagicalRecord 的数据库操作 [CoreDataPro](https://github.com/itwyhuaing/OC-WYH/tree/master/DataStore/CoreData应用简介/CoreDataPro)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/demo2.png)

* 获取设备信息 - keychain 存储 [GainRelativeInfo](https://github.com/itwyhuaing/OC-WYH/tree/master/GainRelativeInfo)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/demo1_0.png)

* Demo 做笔记使用，持续更新 。。。

### 数据存储基础
* 作为移动端开发工程师，所需要的数据几乎全部都是通过网络获取，而且网络请求都有时耗；在网络好的情况下这种时耗虽然不足考虑，但是一旦网络环境不好，会很影响产品体验。网络环境无法控制，但是对于一些数据不经常变动的网络请求或没必要实时更新的数据，我们可以选择将网络数据缓存本地，适时更新。
* 在iOS中涉及存储方式不外乎这几种，只是大家各自的分类方式可能有些不同。这里仅是自己的思考与分类。
* 了解缓存，有必要先了解一下沙盒这个概念。
沙盒其实质就是在iOS系统下，每个应用在内存中所对应的储存空间。
每个iOS应用都有自己的应用沙盒（文件系统目录），与其他文件系统隔离，各个沙盒之间相互独立，而且不能相互访问（手机没有越狱的情况下）。
各个应用程序的沙盒是相互独立的，在系统内存消耗过高时，系统会收到内存警告并自动将一些退出软件。这就保证了系统的数据的安全性及系统的稳定性。

* 一个应用的沙盒目录如下：

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/sh1.png)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/sh2.png)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/sh3.png)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/sh4.png)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/sh5.png)

* Documents 应用程序在运行时生成的一些需要长久保存的数据。

* Library/Caches 储存应用程序网络请求的数据信息(音视频与图片等的缓存)。此目录下的数据不会自动删除，需要程序员手动清除该目录下的数据。主要用于保存应用在运行时生成的需要长期使用的数据.一般用于存储体积较大数据。
* Library/Preferences 设置应用的一些功能会在该目录中查找相应设置的信息,该目录由系统自动管理,通常用来储存一些基本的应用配置信息,比如账号密码,自动登录等。
* tmp 保存应用运行时产生的一些临时数据;应用程序退出、系统空间不够、手机重启等情况下都会自动清除该目录的数据，iTunes或iCloud也不会对其进行备份。无需程序员手动清除该目录中的数据。
* SystemData - 近期优化项目数据存储，发现多了该文件路径，暂未做过多研究。

#### Plist 格式文件存储
* plist文件，即属性列表文件。
* 可以存储的数据类型有 Array Dictionary String Boolean Date Data Number。
* 常用于储存用户的设置 或 存储项目中经常用到又不经常修改的数据。
* 创建 .plist 文件可以使用可视化工具即Xcode ,也可以使用代码。
* 不适合存储大量数据，而且只能存储基本数据类型。
* 虽然可以实现 ：增 删 改 查 等操作，但由于数据的存取必须是一次性全部操作，所以性能方面表现并不好。

文件创建

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/plist_create.png)


字符串写入

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/plist_string_write.png)


数组写入

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/plist_arr_write.png)


字典写入

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/plist_dic_write.png)


数据读取

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/plist_read.png)


#### NSUserDefaults 沙盒存储(个人偏好存储)
* 补充几个方法：

isSubclassOfClass :参数为类 - 参数类为其子类或本身 ；

isMemberOfClass   ：参数为实例对象 - 参数所属类为其本身 ；

isKindOfClass     ：参数为实例对象 - 参数所属类为其子类或本身 。

* 应用程序启动后，会在沙盒路径Library -> Preferences 下默认生成以工程bundle为名字的 .plist 文件 , 该方式存储的数据即存进该文件当中。
* 常用语存储用户的个人偏好设置。
* 这种方式本质是操作plist文件，所以性能方面的考虑同plist文件数据储存。

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/default_write_before.png)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/default_write_after.png)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/default_read.png)


#### 文件读写储存
* 文件操作可通过单例 NSFileManager 处理。文件存储的路径可以代码设置。
* 可以存储大量数据，对数据格式没有限制。
* 但由于数据的存取必须是一次性全部操作，所以在频繁操作数据方面性能欠缺。

#### 解归档存储
* plist 与 NSUserDefaults(个人偏好设置)两种类型的储存只适用于系统自带的一些常用类型，而且前者必须拿到文件路径，后者也只能储存应用的主要信息。
* 对于开发中自定义的数据模型的储存，我们可以考虑使用归档储存方案。
* 归档保存数据，文件格式自己可以任意，没有要求 ; 即便设置为常用的数据格式(如：.c .txt .plist 等)要么不能打开，要么打开之后乱码显示。
* 值得注意的是使用归档保存的自定义模型需要实现NSCoding协议下的两个方法。
* 不适合存储大量数据，可以存储自定义的数据模型。
* 虽然归档可以存储自定义的数据结构，但在大批量处理数据时，性能上仍有所欠缺。

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/encode.png)

#### 数据库存储
* SQLite : 它是一款轻型的嵌入式数据库，安卓和ios开发使用的都是SQLite数据库；占用资源非常的低，在嵌入式设备中，可能只需要几百K的内存就够了；而且它的处理速度比Mysql、PostgreSQL这两款著名的数据库都还快。
* FMDB是iOS平台的SQLite数据库框架，它是以OC的方式封装了SQLite的C语言API。FMDB使用时，需要自己写一些简单的SQLite语句。使用起来更加面向对象，省去了很多麻烦、冗余的C语言代码；比苹果自带的Core Data框架，更加轻量级和灵活；供了多线程安全的数据库操作方法，有效地防止数据混乱。
* CoreData 是苹果给出的一套基于 SQLite 的数据存储方案；而且不需要自己写任何SQLite语句。该功能依赖于 CoreData.framework 框架，该框架已经很好地将数据库表和字段封装成了对象和属性，表之间的一对多、多对多关系则封装成了对象之间的包含关系。
* Core Data的强大之处就在于这种关系可以在一个对象更新时，其关联的对象也会随着更新，相当于你更新一张表的时候，其关联的其他表也会随着更新。Core Data的另外一个特点就是提供了更简单的性能管理机制，仅提供几个类就可以管理整个数据库。由于直接使用苹果提供的CoreData容易出错，这里提供一个很好的三方库 MagicalRecord 。
* 关于 Core Data 想吐槽的是，数据存储功能虽然封装的很好、功能很强大，但是版本迭代中反复修改数据模型、新增数据模型等问题引起的数据库迁移问题给开发工作带来很多不必要的工作；尤其有未解除过该技术的新人加入。

* Pod 添加 MagicalRecord 依赖库之后，文件创建 - 数据实体创建 - 数据迁移 :

> 新建工程 ，Use Core Data 可选可不选，这就给未勾选该项的旧工程使用 Core Data 技术提供可能

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/cd0.png)


> 创建 .xcdatamodeld 文件

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/cd1.png)


> 创建实体、新增属性

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/cd2.png)


> 创建实体相应的关联文件

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/cd3.png)


> 数据库迁移步骤 1

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/cd4.png)


> 数据库迁移步骤 2

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/DataStore/image/cd5.png)


#### 缓存系统

> [APP缓存系统设计简要记录(整理中)](https://github.com/itwyhuaing/OC-WYH/tree/master/APP缓存系统设计简要记录)

> [HybridAPP(整理优化中)](https://github.com/itwyhuaing/HybridAPP)

* 对大多数 APP 而言，都是 Hybrid 开发，Web 页与原生同时存在，其中 Web 页可能是 UIWeb 也可能是 WKWeb 。所以与之相应的缓存系统，应该包括 Web 缓存与 原生接口数据缓存两部分。

* Web 缓存有网络缓存及 Webkit 框架机制内的缓存。这里也可以依据 URL + 时间戳 自行设计一套缓存。

* 原生接口部分的数据缓存

  1. 与用户相关的信息、单个标记符标识等常采用沙盒存储。
  2. 全局使用到的数据模型，需要永久存储的话可以考虑归档；例如用户登陆后的个人信息数据模型。
  3. 倘若不涉及大规模数据的增删改查等操作，可以考虑文件读写的方式直接存储网络返回的 JSON 对象，借助 YYCache 亦可实现高性能存储。
  4. 大规模数据的存储例如帖子、评论、新闻、外卖、商品等可以考虑使用数据库：FMDB （DataStoreDemo - JXFMDBMOperator）或 Core Data （推荐使用 CoreData 的封装库 MagicalRecord）；也可以简单点直接使用 NSPredicate 对数据的筛查操作，简单直接。

##### 参考

* [iOS内存缓存和磁盘缓存的区别](https://www.jianshu.com/p/3b0e290cc049)


##### 参考

* [NSBundle的一些理解](https://www.jianshu.com/p/b64ff9d8e7ce)









































































end
