# ReactiveObjc
ReactiveObjc 记录。

##### 简要介绍
* RAC 是 RactiveCocoa 的缩写，可实现函数响应式编程，是 Github 的一个开源框架；
* RAC最大的优点是 提供了一个单一的、统一的方法去处理异步的行为，包括 Delegate，Blocks Callbacks，Target-Action机制，Notifications和KVO；
* 现在分为 ReactiveObjC 和 ReactiveSwift ，即 OC 与 swift 不同版本。

##### 应用

* RAC 应用的思路是：创建信号 -> 订阅信号 -> 发送信号。信号的处理大量使用到 block 回调。

* 几个基础的关键类与协议

```

RACSubject : RACSignal : RACStream : NSObject

RACSequence : RACStream

RACDisposable : NSObject

RACSubscriber <NSObject>

```

* 信号的一般处理过程

```

    // 1. 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 2. 发送信号
        [subscriber sendNext:@1];

        // 4. 取消订阅
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"\n disposableWithBlock \n");
        }];
        return nil;
    }];

    // 3. 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"\n 订阅:\n %@ \n",x);
    }];

```

* delegate

```

// DTestView.h 文件
@interface DTestView : UIView

@property (nonatomic,strong) RACSubject *delegateSignal;

@end

// DTestView.m 文件
@implementation DTestView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:@"测试数据-delegate"];
    }
}

@end


// DelegateVC.m 文件
@interface DelegateVC ()

@property (nonatomic,strong) DTestView *dtv;

@end

@implementation DelegateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title                = NSStringFromClass(self.class);
    self.dtv.backgroundColor = [UIColor cyanColor];
    self.dtv.delegateSignal = [RACSubject subject];
    [self.dtv.delegateSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"\n %@ \n",x);
    }];
}

-(DTestView *)dtv{
    if (!_dtv) {
        _dtv = [[DTestView alloc] init];
        [self.view addSubview:_dtv];
        _dtv.sd_layout
        .leftSpaceToView(self.view, 10)
        .rightSpaceToView(self.view, 10)
        .topSpaceToView(self.view, 100)
        .bottomSpaceToView(self.view, 10);
    }
    return _dtv;
}


```

* RACTuple 元组与 RACSequence

> RACTuple 是 RAC 的元祖，跟我们 OC 的数组其实是一样的，它其实就是封装了我们 OC 的数组。

> RACSequence 可用于 OC 基本集合数据的遍历。

* KVO

```
[[self.tojt rac_valuesForKeyPath:@"frame" observer:self] subscribeNext:^(id  _Nullable x) {
        NSLog(@" \n x = :\n%@ \n ",x);
    }];
```


* Notification

```
// 键盘通知监听
    self.keyBordDisposable = [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardDidShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        //NSLog(@"key-x = \n %@",x);
    }];
```

* Timer

```
// 定时器 - 延迟3秒
    RACSignal *racNal = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@"测试数据"];
        return nil;
    }] delay:3.0];
    [racNal subscribeNext:^(id  _Nullable x) {
        NSLog(@"\n %@ \n",x);
    }];
```

##### 示例 RACDemo 。

##### 参考

* [『状态』驱动的世界：ReactiveCocoa](https://github.com/Draveness/analyze/blob/master/contents/ReactiveObjC/RACSignal.md#信号的订阅与信息的发送)

* [关于ReactiveObjC原理及流程简介](https://www.jianshu.com/p/fecbe23d45c1)

* [关于ReactiveObjC使用简介](https://www.jianshu.com/p/14075b5ec5ff)
























f
