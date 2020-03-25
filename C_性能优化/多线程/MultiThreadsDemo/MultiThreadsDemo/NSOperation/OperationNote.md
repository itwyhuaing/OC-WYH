### NSOperation

* 基于 GCD 的封装，面向对象编程，更加简单强大。同样也类似于 GCD ，有操作（NSOperation）与队列（NSOperationQueue）的概念。

**NSOperation**

* NSOperation 是个抽象类，不能用来封装操作。只能使用其子类来封装操作，系统已提供两种：NSInvocationOperation、NSBlockOperation；我们也可以自定义。

* addDependency: 方法可设置不同 NSOperation 操作的依赖关系。假设 operation2 依赖于 operation1 ([operation1 addDependency：operation2];),即操作operation1执行完成之后才会执行operation2；在operation1未执行完成之前operation2并未进入就绪状态。

* addExecutionBlock: 方法可给已存在的 NSBlockOperation 操作添加操作，新添加进的操作是否会新开辟线程取决于系统。

* queuePriority 可设置 NSOperation 操作的优先级。优先级只对已进入就绪状态的操作生效。

* cancel 可取消操作。这里的取消并不代表可以将当前的操作立即取消，而是当当前的操作执行完毕之后不再执行新的操作。

* completionBlock 会在当前操作执行完毕时执行 completionBlock。

**NSOperationQueue**

*  一般 NSOperation 实例化之后的操作需要添加到队列之后才会执行；否则需要调用 start 实例方法，此时默认在主队列执行操作。

*  线程间通信常见于子线程执行耗时操作，回到主线程刷新 UI。

* 多线程同事读写某一块内存内容时往往涉及线程安全问题，NSLock、dispatch_semaphore、@synchronized、NSCondition、NSConditionLock、NSRecursiveLock等可用于给线程加锁，确保线程安全。

* cancelAllOperations 可以取消队列的所有操作。

* setSuspended 可设置操作的暂停和恢复，YES 代表暂停队列，NO 代表恢复队列。

* 这里的暂停/取消并不代表可以将当前的操作立即取消，而是当当前的操作执行完毕之后不再执行新的操作。
