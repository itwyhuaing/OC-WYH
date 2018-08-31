//
//  Animation3VC.h
//  AnimationDemo
//
//  Created by hnbwyh on 2018/8/22.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import "BaseAnimationVC.h"

@interface Animation3VC : BaseAnimationVC

@end


/**
 顺序问题
 假设当前(由上到下顺序) 1 - 2 - 3 - 4
 > 向左滑动之后(由上到下顺序) 2 - 3 - 4 - 1
 > 向右滑动之后(由上到下顺序) （中间过程显示右侧第一张 1 依次第二张 4）4 - 1 - 2 - 3
 
 
 向左：
 快滑
 慢滑
 
 向右:
 快滑
 慢滑
 
 
 如何去取图片及处理子视图层级 :
 > 设置 tag 标记并依序存入数组 -- > 按照数组顺序设置效果(Frame - 缩放 - 图片赋值)
 > 动画手势所在图片 + 依据 Tag 取另一张图片
 > 满足变换条件时:(依照当前数组顺序)立即更新 tag 及数组顺序 -- > 按照数组顺序设置效果(Frame - 缩放 - 图片赋值)
 */
