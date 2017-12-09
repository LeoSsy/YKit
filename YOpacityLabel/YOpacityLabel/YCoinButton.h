//
//  YCoinButton.h
//  YOpacityLabel
//
//  Created by shusy on 2017/12/9.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCoinButton : UIButton

/**
 初始化方法

 @param frame frame
 @param point 目标点
 @return 创建好的按钮
 */
- (instancetype)initWithFrame:(CGRect)frame endPoint:(CGPoint)point;
/**
 快捷配置相关的参数
 totalCount 获取指定的产生图片的个数
 timeDelay动画时间间隔
 duration 动画时长
 animatedImage 动画图片
 @param effectBlock 快捷设置block
 */
- (void)setUpProperties:(void(^)(CGFloat *totalCount,CGFloat *timeDelay,CGFloat *duration,UIImage **animatedImage))effectBlock;

@end
