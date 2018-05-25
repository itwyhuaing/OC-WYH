//
//  TextViewLoadHtmlVC.h
//  RichTextProjectDemo
//
//  Created by hnbwyh on 2018/5/18.
//  Copyright © 2018年 hainbwyh. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 经测试，在加载 HTML 数据中，使用 UITextView 与 WKWebView 加载时间相差（ 10 * 10 ）两个数量级。
 但是，在第一次加载 HTML 数据时需要较长时间的转换，该过程比较耗费时间。
 */
@interface TextViewLoadHtmlVC : UIViewController

@end
