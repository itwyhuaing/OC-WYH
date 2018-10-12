##### cookie

// cookie 版本
// 版本0：此版本是指由Netscape定义的原始cookie格式的“传统”或“旧式”cookie。遇到的大多数Cookie都是这种格式。
// 版本1：此版本是指RFC 2965（HTTP状态管理机制）中定义的Cookie。
@property (readonly) NSUInteger version;

// cookie存储信息的名字，比如：token
@property (readonly, copy) NSString *name;

// cookie存储的信息，比如：8d2je219jjd0120d12e1212e12(token的值)
@property (readonly, copy) NSString *value;

// cookie有效期（过期，NSHTTPCookieStorage会自动删除存储的cookie）
@property (nullable, readonly, copy) NSDate *expiresDate;

// 是否应在会话结束时被丢弃（不管过期日期如何）
@property (readonly, getter=isSessionOnly) BOOL sessionOnly;

// cookie 的域名
@property (readonly, copy) NSString *domain;

// 路径
@property (readonly, copy) NSString *path;

// 该cookie是否应该仅通过安全通道发送
@property (readonly, getter=isSecure) BOOL secure;

// 是否应仅根据RFC 2965发送到HTTP服务器
@property (readonly, getter=isHTTPOnly) BOOL HTTPOnly;

// 端口列表
@property (nullable, readonly, copy) NSArray<NSNumber *> *portList;


##### cookie 管理
1. iOS 开发中，用户登录之后，服务器会将当前用户的 token 等相关信息存在 cookie 中返回给客户端；该客户端在之后的每次数据请求都需要将此 cookie 携带发送给服务器，这样服务器才可以区分当前是哪个用户。

2. 为了接收服务器下发的 cookie ，iOS 中提供了 NSHTTPCookieStorage 这个类来对其进行相关的操作。

3. NSURLResponse 根据当前的 NSHTTPCookieStorage 接收策略自动接收服务器下发的 cookie 并存储在 NSHTTPCookieStorage 中，不需要开发者做任何操作；在发送请求时，开发者只需要设置 HTTPShouldHandleCookies 为 YES（默认为YES）， NSURLRequest 会自动附带 cookie 的信息发送给服务器。

4. NSHTTPCookieStorage

// cookie 的接收策略
@property NSHTTPCookieAcceptPolicy cookieAcceptPolicy

// 获取 NSHTTPCookieStorage 存储的所有cookie
@property (nullable , readonly, copy) NSArray<NSHTTPCookie *> *cookies

// 设置cookie
- (void)setCookie:(NSHTTPCookie *)cookie

// 删除cookie
- (void)deleteCookie:(NSHTTPCookie *)cookie

// 在某个时间点删除cookies
- (void)removeCookiesSinceDate:(NSDate *)date

// 获取指定URL的cookies
- (nullable NSArray<NSHTTPCookie *> *)cookiesForURL:(NSURL *)URL

// 获取指定域名指定URL的cookies
- (void)setCookies:(NSArray<NSHTTPCookie *> *)cookies forURL:(nullable NSURL *)URL mainDocumentURL:(nullable NSURL *)mainDocumentURL

// 用户退出登录， 清除cookie
NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
for (NSHTTPCookie *cookie in cookies) {
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
}























































