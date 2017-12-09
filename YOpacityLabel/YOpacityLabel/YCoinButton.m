//
//  YCoinButton.m
//  YOpacityLabel
//
//  Created by shusy on 2017/12/9.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import "YCoinButton.h"

@interface YCoinButton()<CAAnimationDelegate>
//内部动画视图的tags
@property(nonatomic,strong)NSMutableArray *tags;
//动画结束的点
@property(nonatomic,assign)CGPoint endPoint;
//获取指定的产生图片的个数
@property(nonatomic,assign)CGFloat totalCount;
//动画时间间隔
@property(nonatomic,assign)CGFloat timeDelay;
//动画时长
@property(nonatomic,assign)CGFloat duration;
//动画图片
@property(nonatomic,strong)UIImage *animatedImage;
@end

@implementation YCoinButton

- (instancetype)initWithFrame:(CGRect)frame endPoint:(CGPoint)point {
    if (self = [super initWithFrame:frame]) {
        _tags = [NSMutableArray array];
        _endPoint = CGPointMake(point.x - frame.origin.x, point.y - frame.origin.y);
        self.totalCount = 10;
        self.timeDelay = 0.3;
        self.duration = 1;
        self.animatedImage = [UIImage imageNamed:@"coin"];
        [self setImage:self.animatedImage forState:UIControlStateNormal];
        //添加点击事件
        [self addTarget:self action:@selector(startAnimation) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


/**
 配置相关的参数
 totalCount 获取指定的产生图片的个数
 timeDelay动画时间间隔
 duration 动画时长
 animatedImage 动画图片
 @param effectBlock 快捷设置block
 */
- (void)setUpProperties:(void(^)(CGFloat *totalCount,CGFloat *timeDelay,CGFloat *duration,UIImage **animatedImage))effectBlock {
    if (effectBlock) {
        //获取指定的产生图片的个数
        CGFloat totalCount = 0;
        //动画时间间隔
        CGFloat timeDelay = 0;
        //动画时长
        CGFloat duration = 0;
        //动画图片
        UIImage *animatedImage = nil;
        effectBlock(&totalCount,&timeDelay,&duration,&animatedImage);
        if (totalCount) {
            self.totalCount = totalCount;
        }
        if (timeDelay) {
            self.timeDelay = timeDelay;
        }
        if (duration) {
            self.duration = duration;
        }
        if (animatedImage) {
            self.animatedImage = animatedImage;
        }
    }
}

/**
 开始动画
 */
- (void)startAnimation {
    //循环创建子视图
    for (int i = 0 ; i< self.totalCount ; i++) {
        //延迟创建
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(i*self.timeDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIImageView *imageView = [[UIImageView alloc] initWithImage:self.animatedImage];
            imageView.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
            imageView.tag = i+ 1000;
            [self.tags addObject:[NSNumber numberWithInt:(int)imageView.tag]];
            [self addSubview:imageView];
            [self addAnimationWithView:imageView];
        });

    }
}

/**
 添加动画
 */
- (void)addAnimationWithView:(UIView*)imageView {
    //添加直线动画
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5)];
//    [path addLineToPoint:self.endPoint];
    [path addQuadCurveToPoint:self.endPoint controlPoint:CGPointMake(self.endPoint.x, self.center.y)];

    //创建移动动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.duration = self.duration;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.calculationMode = kCAAnimationPaced;
    [imageView.layer addAnimation:animation forKey:@"positionAnim"];
    
}

#pragma mark CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        UIView *view = (UIView*) [self viewWithTag:[self.tags[0] intValue]];
        [view removeFromSuperview];
        [self.tags removeObjectAtIndex:0];
    }
}

@end
