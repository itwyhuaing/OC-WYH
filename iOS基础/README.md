# iOS基础
iOS基础 记录 。

#### Property 与 属性修饰符  [参考1](https://juejin.im/post/5bf608c6e51d451f6e5299f7)

* Property

```
property = 实例变量+setter方法+getter方法
```
> 属性修饰符会直接影响后续编译器对于 setter 和 getter 方法的合成。

* 线程安全问题(原子性 : atomic VS nonatomic)

> 具备atomic特质的属性，编译器合成的setter和getter方法会加锁，能够保证当多个线程在读写属性时，总是能够获取到属性值，如果修饰符为nonatomic，则不会对setter和getter方法加锁，在通常情况下，使用nonatomic不会带来什么问题，但是如果一个线程在多次修改某个属性时，另一个线程去读取属性时，可能会取到未修改好的属性。

* 读/写权限 (readwrite VS readonly)

> readwrite 修饰的属性只会合成setter和getter方法 。readonly 修饰的属性只会合成getter方法，可以以直接访问实例变量的方式来完成赋值操作。

* 内存管理

> 该部分的修饰符主要影响编译器合成 setter 方法。

  * assign

    > 修饰基础类型数据，setter 方法只执行简单的赋值操作。

  * weak

    > weak 是 ARC 中新增加的属性修饰符，使用 weak 修饰的属性的 setter 方法会既不保留新值，也不释放旧值，不会使属性指的对象的引用计数增加，当指向的对象被释放时，属性值也会被自动置为 nil。

  * strong

    > strong 是 ARC 中新增加的属性修饰符，跟MRC时代中的retain修饰符很像，描述一种“拥有关系”，使用strong修饰的属性的setter方法会先保留新值，再释放旧值，最后把新值设置上。

  * retained  

    > 类似 ARC 下的 strong 。

  * unsafe_unretained

    > unsafe_unretained与assign类似，但是用于对象类型，从字面意思上，也能看到，它是不安全，也不会强引用对象，所以它跟weak很相似，跟weak的区别在于当指向的对象被释放时，属性不会被置为nil，所以是不安全的。

  * copy

    > copy表达的语义相似，都会持有对象，但是它的setter方法不会保留新值，而是会调用对象的copy方法将新值拷贝一份，然后将它设置上。
