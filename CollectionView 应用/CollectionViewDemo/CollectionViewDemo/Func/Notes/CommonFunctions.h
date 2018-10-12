1.  isnan
如果一个数是一个确定的数，那它就不是nan值;如果一个数是无穷大，无穷小，那它就是nan值。

```

if (isnan(1)) {
    NSLog(@"1是NAN");
} else {
    NSLog(@"1不是NAN");
}

```

2. abs( 处理int类型的取绝对值 )、fabs( 处理double类型的取绝对值 )、fabsf( 处理float类型的取绝对值 )

```

int abs(int i);

double fabs(double i);

float fabsf(float i);

```

3. ceilf
进位方法

```
float numberToRound;
int result;
numberToRound = 5.61;
result = (int)ceilf(numberToRound);
NSLog(@"ceilf(%.2f) = %d", numberToRound, result);
//输出 ceilf(5.61) = 6

numberToRound = 5.41;
result = (int)ceilf(numberToRound);
NSLog(@"ceilf(%.2f) = %d", numberToRound, result);
//输出 ceilf(5.41) = 6

```

4. roundf
四舍五入

```
float numberToRound;
int result;
numberToRound = 5.61;
result = (int)roundf(numberToRound);
NSLog(@"roundf(%.2f) = %d", numberToRound, result);
//输出 roundf(5.61) = 6

numberToRound = 5.41;
result = (int)roundf(numberToRound);
NSLog(@"roundf(%.2f) = %d", numberToRound, result);
//输出 roundf(5.41) = 5
```

5. floorf

```
float numberToRound;
int result;
numberToRound = 5.61;
result = (int)floorf(numberToRound);
NSLog(@"floorf(%.2f) = %d", numberToRound, result);
//输出 floorf(5.61) = 5

numberToRound = 5.41;
result = (int)floorf(numberToRound);
NSLog(@"floorf(%.2f) = %d", numberToRound, result);
//输出 floorf(5.41) = 5
```

6.

```

```


7. 

```

```
