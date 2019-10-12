
---

> 项目需要，涉及音频部分简要作如下笔记。使用 AVPlayer 实现音视频，两者差不多，这里不做太多记录。

###### 视频播放方案

1. iOS9.0 之前使用 MPMoviePlayerController, 或者自带一个 view 的 MPMoviePlayerViewController。
2. iOS9.0 之后，可以使用新的API AVPictureInPictureController, AVPlayerViewController。
3. 使用WKWebView。
4. AVPlayer，这种方案可实现较强的个性化定制需求。



---
###### AVPlayer

* AVPlayer支持播放本地、分步下载、或在线流媒体音视频。

* AVPlayer只支持单个媒体资源的播放，使用AVPlayer的子类AVQueuePlayer可实现列表播放。

> 常用类简述

```
1. AVPlayer - 播放器。

// 实例化播放器对象
+ (instancetype)playerWithURL:(NSURL *)URL;
+ (instancetype)playerWithPlayerItem:(nullable AVPlayerItem *)item;
- (instancetype)initWithURL:(NSURL *)URL;
- (instancetype)initWithPlayerItem:(nullable AVPlayerItem *)item;
// 播放器状态(只读)
@property (nonatomic, readonly) AVPlayerStatus status;
// 播放器报错(只读)
@property (nonatomic, readonly, nullable) NSError *error;

@property (nonatomic) float rate;
- (void)play;
- (void)pause;


typedef NS_ENUM(NSInteger, AVPlayerTimeControlStatus) {
	AVPlayerTimeControlStatusPaused,
	AVPlayerTimeControlStatusWaitingToPlayAtSpecifiedRate,
	AVPlayerTimeControlStatusPlaying
} NS_ENUM_AVAILABLE(10_12, 10_0);
@property (nonatomic, readonly) AVPlayerTimeControlStatus timeControlStatus;

// 当前播放器所拥有的多媒体资源
@property (nonatomic, readonly, nullable) AVPlayerItem *currentItem;
// 修改/更新播放器所拥有的多媒体资源
- (void)replaceCurrentItemWithPlayerItem:(nullable AVPlayerItem *)item;

// 播放进度/时间监听
- (id)addPeriodicTimeObserverForInterval:(CMTime)interval queue:(nullable dispatch_queue_t)queue usingBlock:(void (^)(CMTime time))block;
- (void)removeTimeObserver:(id)observer;

// 以下属性、方法可实现多媒体资源播放的一些交互操作
- (CMTime)currentTime;
- (void)seekToDate:(NSDate *)date;
- (void)seekToDate:(NSDate *)date completionHandler:(void (^)(BOOL finished))completionHandler;
- (void)seekToTime:(CMTime)time;
- (void)seekToTime:(CMTime)time toleranceBefore:(CMTime)toleranceBefore toleranceAfter:(CMTime)toleranceAfter;
- (void)seekToTime:(CMTime)time completionHandler:(void (^)(BOOL finished))completionHandler;
- (void)seekToTime:(CMTime)time toleranceBefore:(CMTime)toleranceBefore toleranceAfter:(CMTime)toleranceAfter completionHandler:(void (^)(BOOL finished))completionHandler;

- (void)setRate:(float)rate time:(CMTime)itemTime atHostTime:(CMTime)hostClockTime;
- (void)prerollAtRate:(float)rate completionHandler:(nullable void (^)(BOOL finished))completionHandler;
- (void)cancelPendingPrerolls;

2. AVPlayerItem - 一个媒体资源管理对象，管理着多媒体资源的一些基本信息和状态。

// 多媒体资源对象初始化
+ (instancetype)playerItemWithURL:(NSURL *)URL;
+ (instancetype)playerItemWithAsset:(AVAsset *)asset;
+ (instancetype)playerItemWithAsset:(AVAsset *)asset automaticallyLoadedAssetKeys:(nullable NSArray<NSString *> *)automaticallyLoadedAssetKeys;
- (instancetype)initWithURL:(NSURL *)URL;
- (instancetype)initWithAsset:(AVAsset *)asset;
- (instancetype)initWithAsset:(AVAsset *)asset automaticallyLoadedAssetKeys:(nullable NSArray<NSString *> *)automaticallyLoadedAssetKeys;
// 多媒体资源状态
@property (nonatomic, readonly) AVPlayerItemStatus status;
// 多媒体缓冲
@property (nonatomic, readonly) NSArray<NSValue *> *loadedTimeRanges;


```

>> loadedTimeRanges 时间占比

	![image](https://github.com/itwyhuaing/OC-WYH/blob/master/音视频/image/loadedTimeRanges时间占比.png)


> AVPlayer 播放能力 - 后台播放

>> 1. 代码设置

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/音视频/image/enable_11.png)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/音视频/image/enable_12.png)

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/音视频/image/enable_13.png)


>> 2. 工程配置

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/音视频/image/后台播放2.png)


>> 3. 工程配置

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/音视频/image/后台播放3.png)

>> 注意：后台播放需要注意播放器不要被释放。

> AVPlayer 播放能力 - 远程控制

>> 代码设置

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/音视频/image/enable_21.png)



![image](https://github.com/itwyhuaing/OC-WYH/blob/master/音视频/image/enable_22.png)


> AVPlayer 播放能力 - 锁屏信息

>> 代码设置

![image](https://github.com/itwyhuaing/OC-WYH/blob/master/音视频/image/enable_31.png)


* 《注：》当前未解决在非播放界面退出后台时，锁屏上的暂停、上下曲功能失效。(即：Demo 进入后台状态前，栈顶控制器不是VoiceAVPlayerVC时，锁屏界面无法远程控制播放状态。)

* [iOS开发之AVPlayer的精彩使用--->网易新闻视频播放界面的另类实现](http://blog.csdn.net/super_man_ww/article/details/52411332)
* [AVPlayer 本地、网络视频播放相关](http://www.jianshu.com/p/de418c21d33c)
* [CADisplayLink](http://www.jianshu.com/p/c35a81c3b9eb)

---
###### AVAudioPlayer

*  AVAudioPlayer是属于 AVFundation.framework 的一个类。

* 它的功能类似于一个功能强大的播放器，AVAudioPlayer每次播放都需要将上一个player对象释放掉，然后重新创建一个player来进行播放。

* 类AVAudioPlayer 与 类AVAudioRecorder 相似。

> 常见的属性与方法

```
// 常用的初始化音频播放器方法
- (nullable instancetype)initWithContentsOfURL:(NSURL *)url error:(NSError **)outError;
- (nullable instancetype)initWithData:(NSData *)data error:(NSError **)outError;

// 准备播放
- (BOOL)prepareToPlay;

// 播放
- (BOOL)play;		

// 指定播放时间
- (BOOL)playAtTime:(NSTimeInterval)time;

// 暂停
- (void)pause;

// 停止
- (void)stop;

// 播放状态(只读)
@property(readonly, getter=isPlaying) BOOL playing;

// 该音频的声道次数 (只读)
@property(readonly) NSUInteger numberOfChannels;

// 该音频播放时长
@property(readonly) NSTimeInterval duration;

//
@property(copy, nullable) NSString *currentDevice;

// 播放器代理
@property(assign, nullable) id<AVAudioPlayerDelegate> delegate;

// 获取播放器资源 (只读)
@property(readonly, nullable) NSURL *url;
@property(readonly, nullable) NSData *data;

// 允许使用立体声播放声音：播放器的pan只有一个浮点表示，范围从-1.0（极左）到1.0（极右）。默认值为0.0（居中）
@property float pan;

// 播放器的音量，播放器的音量独立于系统的音量；取值
@property float volume;

//
- (void)setVolume:(float)volume fadeDuration:(NSTimeInterval)duration;

// 是否允许改变播放速率
@property BOOL enableRate;

// 调整播放率，允许用户在不改变声调的情况下调整播放率（0.5-2.0）
@property float rate;

// 该音频的播放点
@property NSTimeInterval currentTime;

// /输出设备播放音频的时间，注意如果播放中被暂停此时间也会继续累加
@property(readonly) NSTimeInterval deviceCurrentTime;

// 循环次数，如果要单曲循环，设置为负数
@property NSInteger numberOfLoops;

//
@property(readonly) NSDictionary<NSString *, id> *settings;

//
@property(readonly) AVAudioFormat *format;

//
@property(getter=isMeteringEnabled) BOOL meteringEnabled;

// 更新音频测量值，注意如果要更新音频测量值必须设置meteringEnabled为YES，通过音频测量值可以即时获得音频分贝等信息
- (void)updateMeters;

// 返回给定通道的分贝峰值功率
- (float)peakPowerForChannel:(NSUInteger)channelNumber;

// 获得指定声道的分贝峰值，注意如果要获得分贝峰值必须在此之前调用updateMeters方法
- (float)averagePowerForChannel:(NSUInteger)channelNumber;

```

> 代理 AVAudioPlayerDelegate

```

// 一个音频播放结束时调用，由于中断而停止播放情况下并不调起该方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag;

// 播放音频文件中，解码发生错误回调
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error;


// 播放器中断回调 (比如有电话呼入，该方法就会被回调，该方法可以保存当前播放信息，以便恢复继续播放的进度)
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player;
// 播放器中断回调
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags;
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withFlags:(NSUInteger)flags;
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player;


```


---

CMTimeMake 和 CMTimeMakeWithSeconds 解释

* CMTime 是专门用来表示影片时间的类别,CMTimeMake 亦是用来创建 CMTime ；
* CMTimeMake(a, b), a为当前第几帧，b为每秒播放多少帧，当前时间为a/b;
* CMTimeMakeWithSeconds(a, b), a为当前秒数，b为每秒播放多少帧，当前时间为a；
* CMTimeGetSeconds 将 CMTime 转化为秒。

> 都表示当前时间为 2 秒，不同的是播放速率后者是前者的4.5倍。
```
CMTimeMake(20, 10);
CMTimeMake(90, 45);
```


* 关键词解释：

```
NSEC：纳秒。
USEC：微秒。
MSEC：毫秒
SEC：秒
PER：每

NSEC_PER_SEC， 每秒有多少纳秒。
USEC_PER_SEC， 每秒有多少微秒。   （注意是指在纳秒的基础上）。
NSEC_PER_USEC，每微秒有多少纳秒。

1 * NSEC_PER_SEC                （=1s）
1000 * USEC_PER_SEC             （=1s）
USEC_PER_SEC * NSEC_PER_USEC    （=1s）

1s=103ms(毫秒)
=106μs(微秒)
=109ns(纳秒)

```


### 音视频

1. automaticallyWaitsToMinimizeStalling

iOS 10下，AVplayer 新增属性 automaticallyWaitsToMinimizeStalling 。

文档中的两句话
HTTP Live Streaming (HLS): 当播放HLS媒体时, automaticallyWaitsToMinimizeStalling 的值为 true.
File-based Media: 当播放基于文件的媒体, 包括逐渐下载的内容, automaticallyWaitsToMinimizeStalling 的值为 false.
AVPlayer 在新系统下有时会播放不了,可以将 automaticallyWaitsToMinimizeStalling 设置为 false 即可。


2. AVAudioSession 通知处理，
   AVAudioSessionRouteChangeNotification 拔出耳机暂停播放，
   AVAudioSessionInterruptionNotification 来电、语音电话、音乐软件等其他音视频软件占用导致中断

3. [iOS 音频-AVAudioSession](https://www.jianshu.com/p/fb0e5fb71b3c)

4. [iOS音频掌柜-- AVAudioSession](https://www.jianshu.com/p/3e0a399380df)


5. [iOS UIFeedbackGenerator 系统触感反馈 震动](https://www.jianshu.com/p/49c0ead4b0ae)

6. [Android端和iOS端手机震动功能的实现](https://blog.csdn.net/RadiusCLL/article/details/82659464)

### AVFoundation

1. AVFoundation 是一个关于多媒体操作的库。
   因为多媒体一般以文件或流的形式存在，所以为了对其进行操作就需要了解很多底层多媒体方面的知识。
   AVFoundation 为开发者提供了多媒体载体类：AVAsset ，该类封装了统一且友好的接口，无需开发者了解太多底层多媒体方面知识就可轻松开发多媒体功能。

### UIKit

[iOS UIKit框架详解](https://blog.csdn.net/u011774517/article/details/64125115)



---

## AVKit

> ios 系统中用于处理多媒体资源的框架有 AVKit 与 AVFundation ;其中 AVKit 是基于 AVFundation 的一层视图层封装，使用中常涉及的 API 并不多，主要有 AVRoutePickerView（iOS 11 之后可用） 、AVPlayerViewController（iOS 8 之后可用）。

	//AVKit 与 AVFundation 在 iOS 系统中的层级结构如图所示：

	![image](https://github.com/itwyhuaing/OC-WYH/blob/master/音视频/image/AVFoundation与AVKit.png)



##### 参考

* [iOS开发之AVKit框架使用](https://cloud.tencent.com/developer/article/1354073)
