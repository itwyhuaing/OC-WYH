### iOS开发者证书

> 前者挖坑，后来者填坑。关于开发者账号申请、应用创建、证书创建以及应用上传等具体流程已有很多参考；这里只记录自己想记录的关键点。

##### 应用发布大概流程

1. 发布应用，首先你需要一个账号。[Apple 开发者中心](https://developer.apple.com)

2. 新建一个 APP 应用 ：基本信息的填写需要准备 Xcode 的 bundle identifier 等信息；App 价格与销售范围信息填写，价格大多为免费，没有必要支持预定(支持也可以)，所有地区，可提供教育机构批量购买折扣，其中有一项是 bitcode 编译 （需要时情况而定）。

3. 证书制作。

  3.1 发布证书 (开发者证书类似，推送证书多一步选择 bundle identifier。一个开发者账号可以制作的发布证书大概为 3 个)
App Store and Ad Hoc ---> CSR 文件 ---> Download 下载，双击安装 (可导出 p12 文件给其他开发者)

  3.2 注册 APP ID 。
name/id ---> 所需功能  ---> Register

  3.3 创建iOS Provisoning Profiles 描述文件。
App Store ---> 选择已注册的 APP ID ---> 发布证书 ---> 描述文件命名 ---> Download 下载，双击安装

4. 构建新版本，完善版本信息，上传 .ipa 包 ;安装的 Xcode 必须为正式版，beta 版本的 Xcode 不能上传项目到 App Store 。

5. 保存修改，提交审核。



> 补充：
1. bitcode 设置
Xcode 7 之后新建 iOS 工程， bitcode 选项默认设置为 TRUE , Xcode 中的设置 Targes -> Build Settings -> Enable BitCode。

> 2. bitcode 原理
LLVM 是目前苹果采用的编译器工具链,Bitcode是LLVM编译器的中间代码的一种编码,LLVM的前端可以理解为 C/C++/OC/Swift 等编程语言,LLVM的后端可以理解为各个芯片平台上的汇编指令或者可执行机器指令数据,那么,BitCode 就是位于这两者直接的中间码。
LLVM 的编译工作原理是前端负责把项目程序源代码翻译成 Bitcode 中间码,然后再根据不同目标机器芯片平台转换为相应的汇编指令以及翻译为机器码。这样设计就可以让 LLVM 成为了一个编译器架构,可以轻而易举的在 LLVM 架构之上发明新的语言(前端),以及在 LLVM 架构下面支持新的 CPU (后端)指令输出,虽然 Bitcode 仅仅只是一个中间码不能在任何平台上运行,但是它可以转化为任何被支持的 CPU 架构,包括现在还没被发明的 CPU 架构,也就是说现在打开 Bitcode 功能提交一个 App 到应用商店,以后如果苹果新出了一款手机并 CPU 也是全新设计的,在苹果后台服务器一样可以从这个 App 的 Bitcode 开始编译转化为新 CPU 上的可执行程序,可供新手机用户下载运行这个App。


##### 参考
* [iOS App打包上架超详细流程(手把手图文教你）](https://www.jianshu.com/p/817686897ec1?open_source=weibo_search)

* [iOS最新应用上架App Store流程）](https://www.jianshu.com/p/e5ac7b05750a)
