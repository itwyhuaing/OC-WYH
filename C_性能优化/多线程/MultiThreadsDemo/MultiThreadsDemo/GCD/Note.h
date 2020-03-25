##### Dispatch Semaphore
1. 基本理解
Dispatch Semaphore 是持有技术的信号，该计数是多线程编程中的计数类型信号。计数为 0 时等待，计数为 1 或者 大于 1 时，减去 1 而不等待。该函数被创建之后，必须通过 dispatch_release 函数释放；同理也可以通过 dispatch_release 函数持有。

2. 常用函数
/** Dispatch Semaphore 生成
 参数表示计数的初始值。
 */
dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);

/** 两种操作
 Dispatch Semaphore 计数值 < 1 时执行等待操作 / Dispatch Semaphore 计数值 >= 1 时执行减1操作
 第一个参数为已被创建的 Dispatch Semaphore ；第二个参数由 dispatch_time_t 类型值指定等待时间， DISPATCH_TIME_FOREVER 意为永久等待。
 */
dispatch_semaphore_wait(semaphore,DISPATCH_TIME_FOREVER);

