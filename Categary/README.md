### 分类使用

---
###### Category 与 Extension

* [【iOS】Category VS Extension 原理详解](http://www.cocoachina.com/ios/20170502/19163.html)
* [关于分类添加成员变量及分类中方法重写(覆盖) Demo](https://github.com/itwyhuaing/OC-WYH/tree/master/NSRuntime)

---
###### iOS 项目中字体设置问题 - Demo 参考分类 JXFont

> 在iOS开发中设置字体的方法有很多种，这里只介绍常用的三种：系统默认设置、内置自定义字体文件、动态下载。


*  使用系统默认提供的字体,这种方式只针对英文数字，对中文无效。可以通过以下方法获取字体家族名和字体名:

```
NSLog(@"familyNames：%@",[UIFont familyNames]);

输出：
[UIFont familyNames]:
(
 Copperplate,
 "Heiti SC",
 "Apple SD Gothic Neo",
 Thonburi,
 "Gill Sans",
 "Marker Felt",
 "Hiragino Maru Gothic ProN",
 "Courier New",
 "Kohinoor Telugu",
 "Heiti TC",
 "Impact MT Std",
 "Avenir Next Condensed",
 "Tamil Sangam MN",
 "Helvetica Neue",
 "Gurmukhi MN",
 Georgia,
 "Times New Roman",
 "Sinhala Sangam MN",
 "Arial Rounded MT Bold",
 Kailasa,
 "Kohinoor Devanagari",
 "Kohinoor Bangla",
 "Chalkboard SE",
 "Apple Color Emoji",
 "PingFang TC",
 "Gujarati Sangam MN",
 "Geeza Pro",
 Damascus,
 Noteworthy,
 Avenir,
 Mishafi,
 "Kannada Sangam MN",
 Futura,
 "Party LET",
 "Academy Engraved LET",
 "Arial Hebrew",
 Farah,
 Arial,
 Chalkduster,
 Kefa,
 "Hoefler Text",
 Optima,
 Palatino,
 "Malayalam Sangam MN",
 "Al Nile",
 "Lao Sangam MN",
 "Bradley Hand",
 "Hiragino Mincho ProN",
 "PingFang HK",
 Helvetica,
 Courier,
 Cochin,
 "Trebuchet MS",
 "Devanagari Sangam MN",
 "Oriya Sangam MN",
 Rockwell,
 "Snell Roundhand",
 "Zapf Dingbats",
 "Bodoni 72",
 Verdana,
 "American Typewriter",
 "Avenir Next",
 Baskerville,
 "Khmer Sangam MN",
 Didot,
 "Savoye LET",
 "Bodoni Ornaments",
 Symbol,
 Charter,
 Menlo,
 "Noto Nastaliq Urdu",
 "Bodoni 72 Smallcaps",
 "DIN Alternate",
 Papyrus,
 "Hiragino Sans",
 "PingFang SC",
 "Myanmar Sangam MN",
 Zapfino,
 "Telugu Sangam MN",
 "Bodoni 72 Oldstyle",
 "Euphemia UCAS",
 "Bangla Sangam MN",
 "DIN Condensed"
 )


```

* [iOS使用自定义字体的方法(内置和任意下载ttf\otf\ttc字体文件)](http://www.cnblogs.com/vicstudio/p/3961195.html)


* 动态下载系统提供的字体 - 可设置中文字体   [参考 - 动态下载苹果提供的多种中文字体](http://blog.devtang.com/2013/08/11/ios-asian-font-download-introduction/)

> 在今年 WWDC 的内容公开之前，大家都以为 iOS 系统里面只有一种中文字体。为了达到更好的字体效果，有些应用在自己的应用资源包中加入了字体文件。但自己打包字体文件比较麻烦，原因在于：

> 1、字体文件通常比较大，10M - 20M 是一个常见的字体库的大小。大部分的非游戏的 app 体积都集中在 10M 以内，因为字体文件的加入而造成应用体积翻倍让人感觉有些不值。如果只是很少量的按钮字体需要设置，可以用一些工具把使用到的汉字字体编码从字体库中抽取出来，以节省体积。但如果是一些变化的内容需要自定义的字体，那就只有打包整个字体库了。

> 2、中文的字体通常都是有版权的。在应用中加入特殊中文字体还需要处理相应的版权问题。对于一些小公司或个人开发者来说，这是一笔不小的开销。
以上两点造成 App Store 里面使用特殊中文字库的 iOS 应用较少。现在通常只有阅读类的应用才会使用特殊中文字库。
但其实从 iOS6 开始，苹果就支持动态下载中文字体到系统中。只是苹果一直没有公开相应的 API。最终，相应的 API 在今年的 WWDC 大会上公开，接下来就让我们来一起了解这个功能。

> 使用动态下载中文字体的 API 可以动态地向 iOS 系统中添加字体文件，这些字体文件都是下载到系统的目录中（目录是/private/var/mobile/Library/Assets/com_apple_MobileAsset_Font/），所以并不会造成应用体积的增加。并且，由于字体文件是 iOS 系统提供的，也免去了字体使用版权的问题。虽然第一次下载相关的中文字体需要一些网络开销和下载时间，但是这些字体文件下载后可以在所有应用间共享，所以可以遇见到，随着该 API 使用的普及，大部分应用都不需要提示用户下载字体，因为很可能这些字体在之前就被其它应用下载下来了。
