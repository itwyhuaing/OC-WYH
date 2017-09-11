# 分析iOS Crash文件：符号化iOS Crash文件
> 虽然解析有多种方式，但常用且比较稳定的方式还是终端命令；具体如下。

###### 收集对应的三个必需文件

* crash报告（.crash文件）

```
应用程序发生 crash 时的日志问题件。
```

*  符号文件 (.dsymb文件)

```
这个文件可以在打包文件 .xcarchive 中找到。
```

*  应用程序文件 (.app 文件)

```
找到打包文件导出的 .ipa 文件，将其后缀改为 zip ，然后解压，找到 payload 目录下的 appName.app 文件。
```

* 需要注意的是，以上三个文件必须是对应的。然后将其放在同一个目录下。记为 testCrash 文件。


###### 终端命令的执行解析

* 打开进入到 testCrash 文件下

* 终端命令

```
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer

/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/PrivateFrameworks/DTDeviceKitBase.framework/Versions/A/Resources/symbolicatecrash appName.crash appName.app > appName.log
```

* 顺利执行以上步骤之后，解析的结果就已保存在了 appName.log 文件中。当然，不同的电脑配置及Xcode版本可能会有与以上不完全相同的地方，具体问题还需具体分析。
