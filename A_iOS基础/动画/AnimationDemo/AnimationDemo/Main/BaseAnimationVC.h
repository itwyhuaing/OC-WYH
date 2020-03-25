//
//  BaseAnimationVC.h
//  AnimationDemo
//
//  Created by hnbwyh on 2018/8/22.
//  Copyright © 2018年 JiXia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseAnimationVC : UIViewController

@end

/**
 参考1 https://github.com/yixiangboy/IOSAnimationDemo
 
 
 1. Core Animation 框架简介
 iOS 动画主要是指 Core Animation 框架，该框架是 iOS 和 OS X 平台上负责图形渲染与动画的基础框架。
 只需要配置少量的动画参数（如开始点的位置和结束点的位置）即可使用 Core Animation 的动画效果。
 Core Animation将大部分实际的绘图任务交给了图形硬件来处理，图形硬件会加速图形渲染的速度。
 这种自动化的图形加速技术让动画拥有更高的帧率并且显示效果更加平滑，不会加重CPU的负担而影响程序的运行速度。
 
 2. 动画属性解释
 duration
 动画持续时间
 
 repeatCount
 动画重复次数
 
 beginTime
 制定动画开始时间。从开始延迟几秒的话，设置为CACurrentMediaTime()+ 秒数的方式
 
 timeingFunction
 设置动画的速度变化
 
 fillMode
 动画在开始和结束时的动作，默认值是 kCAFillModeRemoved
 
 autoreverses
 动画结束时是否执行逆动画
 
 fromValue
 所改变属性的起始值
 
 toValue
 所改变属性的结束时的值
 
 byValue
 所改变属性相同起始值的改变量
 
 3. keyPath 值
 transform.scale
 整体比例缩放，0-1之间取值
 
 transform.scale.x
 宽度(x轴方向)比例缩放，0-1之间取值
 
 transform.scale.y
 高度(y轴方向)比例缩放，0-1之间取值
 
 transform.rotation.x
 围绕 x 轴旋转,0-2*M_PI之间取值
 
 transform.rotation.y
 围绕 y 轴旋转,0-2*M_PI之间取值
 
 transform.rotation.z
 围绕 z 轴旋转,0-2*M_PI之间取值
 
 backgroundColor
 背景颜色的变化
 
 bounds
 大小缩放，中心不变
 
 position
 位置（中心点的改变）
 
 opacity
 透明度
 
 contentsRect.size.width
 横向拉伸缩放
 
 contentsRect.size.height
 纵向拉伸缩放
 */
