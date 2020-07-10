---

* [Flutter中文网](https://flutterchina.club)


---
### Mac 上搭建 Flutter 开发环境

**安装Flutter SDK**

* 第一步，这里就直接在根目录下操作，下载的 flutter 包也直接放在根目录下；自定义路径也可以。

```

export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
git clone -b dev https://github.com/flutter/flutter.git
export PATH="$PWD/flutter/bin:$PATH"

```

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/跨平台/Flutter/image/安装Flutter_1.png)

* 第二步，检测环境

```

cd ./flutter 			// 这里替换成自己刚才下载flutter的路径，这里直接在根目录下
flutter doctor

```

> 检测环境所遇到问题如图 "Unable to locate Android SDK." ; 该问题的解决大致如下图所示。


![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/跨平台/Flutter/image/问题1.png)


![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/跨平台/Flutter/image/问题1_1.png)


> 第一次打开 android studio 工具，遇到第一个报错如图 “Unable to access Android SDK add-on list” ; 该问题的解决大致如下图所示。

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/跨平台/Flutter/image/问题2.png)


![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/跨平台/Flutter/image/问题2_1.png)

> 正常打开 android studio 工具后，新建工程仍显示错误 “Your Android SDK is missing,out of date or corrupdated” ; 该问题的解决大致如下图所示。

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/跨平台/Flutter/image/问题3.png)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/跨平台/Flutter/image/问题3_1.png)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/跨平台/Flutter/image/问题3_2.png)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/跨平台/Flutter/image/问题3_3.png)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/跨平台/Flutter/image/问题3_4.png)


* 解决上述问题再次执行 “flutter doctor” ，依旧报错

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/跨平台/Flutter/image/问题4.png)


* 检测无误的环境显示如下

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/跨平台/Flutter/image/安装Flutter_last.png)


##### 配置 Flutter 开发环境

* [Flutter 安装 (Mac环境)](https://blog.csdn.net/wangjunling888/article/details/80768285)

> 报错问题解决方式
* [超详细！mac flutter 创建过程及遇到的问题](https://www.jianshu.com/p/603649a02956)

* [Unable to access Android SDK add-on list](https://www.cnblogs.com/coolcold/p/10479596.html)

* [Your Android SDK is missing, out of date or corrupted](https://blog.csdn.net/qq_24118527/article/details/82717041)



**编辑器设置**


### 开发实践中遇到的部分问题简述

**Android Studio没有新建flutter项目选项**

> 问题原因：1、Android Studio 版本过低 2、Android Studio 工具中的 flutter 、Dart 插件未安装正确版本。


**系统已正确配置flutter环境，但终端执行flutter命令报错：“zsh: command not found: flutter”**

> 虽然已配置系统环境，但Flutter并未永久添加到PATH中；针对此情况，如下代码可实现暂时针对当前命令行窗口设置PATH环境变量。该问题永久解决如下图或参考 [将Flutter永久将添加到PATH中/终端"zsh: command not found: flutter"报错永久解决](https://blog.csdn.net/iotjin/article/details/105629266)

```
export PATH=`pwd`/flutter/bin:$PATH

```

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/跨平台/Flutter/image/path_1_2.png)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/跨平台/Flutter/image/path_3.png)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/跨平台/Flutter/image/path_4.png)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/D_部分问题或方案/跨平台/Flutter/image/path_5.png)


**flutter pub get**

> 首次运行新建工程，往往卡在 flutter pub get 处；暂且的解决方式是把默认的 package 获取地址改为访问没有问题的镜像站就可以了；当前可更新为。

```
export PUB_HOSTED_URL=https://pub.flutter-io.cn
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

```





