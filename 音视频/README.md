
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
USEC：微妙。
SEC：秒
PER：每

NSEC_PER_SEC，每秒有多少纳秒。
USEC_PER_SEC，每秒有多少毫秒。（注意是指在纳秒的基础上）。
NSEC_PER_USEC，每毫秒有多少纳秒。

1 * NSEC_PER_SEC                （=1s）
1000 * USEC_PER_SEC             （=1s）
USEC_PER_SEC * NSEC_PER_USEC    （=1s）

```



* [AVAudioPlayer的简单使用-涉及大多API](http://blog.csdn.net/wkffantasy/article/details/49890793)  备注： 类AVAudioPlayer 与 类AVAudioRecorder 相似。
* [iOS开发之AVPlayer的精彩使用--->网易新闻视频播放界面的另类实现](http://blog.csdn.net/super_man_ww/article/details/52411332)
* [AVPlayer 本地、网络视频播放相关](http://www.jianshu.com/p/de418c21d33c)
* [CADisplayLink](http://www.jianshu.com/p/c35a81c3b9eb)
* [AI](http://edu.csdn.net/topic/ai2?utm_source=blog10)
