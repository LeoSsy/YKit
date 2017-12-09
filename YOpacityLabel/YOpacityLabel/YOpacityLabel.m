//
//  YOpacityLabel.m
//  YOpacityLabel
//
//  Created by shusy on 2017/12/8.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import "YOpacityLabel.h"

@interface YOpacityLabel()<CAAnimationDelegate>
@property(nonatomic,assign)CGFloat offsetX;
@property(nonatomic,assign)CGFloat offsetY;
@property(nonatomic,assign)CGFloat duration;
@end

@implementation YOpacityLabel

/**
 创建透明度变化label
 @param frame frame
 @param offsetX x
 @param offsetY y
 @return 透明度变化label
 */
- (instancetype)initWithFrame:(CGRect)frame offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY duration:(CGFloat)duration {
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:28];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor blueColor];
        self.offsetX = offsetX;
        self.offsetY = offsetY;
        self.duration = duration;
        [self startAnimation];
    }
    return self;
}

/**
 开始动画
 */
- (void)startAnimation{
 
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.duration= self.duration;
    opacityAnimation.fromValue = @1;
    opacityAnimation.toValue = @0.0;
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *point1 = [NSValue valueWithCGPoint:self.center];
    NSValue *point2 = [NSValue valueWithCGPoint:CGPointMake(self.center.x+self.offsetX, self.center.y+self.offsetY)];
    positionAnimation.duration = self.duration;
    positionAnimation.keyTimes = @[@0,@1];
    positionAnimation.values = @[point1,point2];
    
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    groupAnimation.duration = self.duration;
    groupAnimation.delegate = self;
    groupAnimation.removedOnCompletion = NO;
    groupAnimation.fillMode = kCAFillModeForwards;
    groupAnimation.animations = @[positionAnimation,opacityAnimation];
    [self.layer addAnimation:groupAnimation forKey:@"YOpacityLabel"];
}

#pragma mark
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self removeFromSuperview];
}

@end
