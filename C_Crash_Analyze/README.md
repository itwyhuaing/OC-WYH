### 分析iOS Crash文件：符号化iOS Crash文件
> 虽然解析有多种方式，但常用且比较稳定的方式还是终端命令；具体如下。

###### 收集对应的三个必需文件

* crash报告（.crash文件）

```
crash 文件内第一行 Incident Identifier 就是该 crash 文件的 UUID。

路径：应用程序发生 crash 时的日志问件。
```

*  符号文件 (.dsymb文件)

```
该文件保存函数地址映射信息的中转文件，调试所需的 symbols 都会包含在这个文件里面。该文件在每次打包时生成新的。

路径：这个文件可以在打包文件 .xcarchive 显示包内容之后，在文件夹 dSYMs 下。
```

*  应用程序文件 (.app 文件)

```
路径：这个文件可以在打包文件 .xcarchive 显示包内容之后，在文件夹 Products  ---> Applications 下 。
```

* 需要注意的是，以上三个文件必须是对应的即UUID相同 。然后将其放在同一个目录下。记为 testCrash 文件。


###### 终端命令的执行解析

* 打开进入到 testCrash 文件下

* 终端命令

```
export DEVELOPER_DIR=/Applications/Xcode.app/Contents/Developer

/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/PrivateFrameworks/DTDeviceKitBase.framework/Versions/A/Resources/symbolicatecrash appName.crash appName.app > appName.log
```

* 顺利执行以上步骤之后，解析的结果就已保存在了 appName.log 文件中。当然，不同的电脑配置及Xcode版本可能会有与以上不完全相同的地方，具体问题还需具体分析。


### 终端命令

* 查看 xx.app 文件的 UUID
```
dwarfdump --uuid xx.app/xx (xx代表你的项目名)
```

* 查看 xx.app.dSYM 文件的 UUID
```
dwarfdump --uuid xx.app.dSYM
```

* 依据UUID查找 .dsymb 文件路径
```
mdfind "com_apple_xcode_dsym_uuids == <UUID>"
```

### 可读文章
* [Fabric-All about Missing dSYMs](https://docs.fabric.io/apple/crashlytics/missing-dsyms.html)
