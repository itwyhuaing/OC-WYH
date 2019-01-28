
---
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

> AVPlayer 播放能力 - 后台播放

>> 1. 代码设置

![image](https://github.com/itwyhuaing/OC-WYH/tree/master/音视频/image/后台播放1.png)


>> 2. 工程配置

![image](https://github.com/itwyhuaing/OC-WYH/tree/master/音视频/image/后台播放2.png)


>> 3. 工程配置

![image](https://github.com/itwyhuaing/OC-WYH/tree/master/音视频/image/后台播放3.png)

>> 注意：后台播放需要注意播放器不要被释放。

> AVPlayer 播放能力 - 锁屏信息

```

```


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
