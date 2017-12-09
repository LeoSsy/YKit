//
//  YReversalView.m
//  Ykit
//
//  Created by shusy on 2017/12/9.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import "YReversalView.h"

@interface YReversalView()<CAAnimationDelegate>
//获取指定的产生图片的个数
@property(nonatomic,strong)NSArray *texts;
//动画类型
@property(nonatomic,assign)YReversalViewType type;
//动画方向
@property(nonatomic,assign)YReversalViewDirType dirType;
//子控件之间的间距
@property(nonatomic,assign)CGFloat margin;
//动画时长
@property(nonatomic,assign)CGFloat duration;
//子控件的背景颜色
@property(nonatomic,strong)UIColor *normalColor;
//子控件的文本颜色
@property(nonatomic,strong)UIColor *textColor;
//记录动画的view
@property(nonatomic,strong)UILabel *animateView;
//保存所有的子控件
@property(nonatomic,strong)NSMutableArray *views;
//记录当前是否正在动画
@property(nonatomic,assign)BOOL isAnimated;
@end

@implementation YReversalView

/**
 初始化方法
 @param frame frame
 @param texts 文本数组
 @return YReversalView
 */
- (instancetype)initWithFrame:(CGRect)frame texts:(NSArray*)texts  {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        self.type =  kReversalViewCube;
        self.dirType = kReversalViewRight;
        self.texts = texts;
        self.margin = 5;
        self.duration = 0.25;
        self.normalColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
        self.textColor = [UIColor blackColor];
        self.views = [NSMutableArray array];
        [self addViews];
    }
    return self;
}

/**
 重新设置所有的标题文本
 */
- (void)setAllTexts:(NSArray*)texts{
    [self.views makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.texts = texts;
    [self.views removeAllObjects];
    [self addViews];
    [self layoutIfNeeded];
}

/**
 快捷配置相关的参数
 totalCount 获取指定的产生图片的个数
 margin子控件之间的间距
 duration 动画时长
 normalColor 子控件的背景颜色
 textColor 子控件的文本颜色
 @param effectBlock 快捷设置block
 */
- (void)setUpProperties:(void(^)(YReversalViewType *type, YReversalViewDirType *dirType,CGFloat *margin,CGFloat *duration,UIColor **normalColor,UIColor **textColor))effectBlock {
    if (effectBlock) {
        //动画类型
        YReversalViewType type = kReversalViewCube;
        //动画方向
        YReversalViewDirType dirType = kReversalViewBottom;
        //动画时间间隔
        CGFloat margin = 0;
        //动画时长
        CGFloat duration = 0;
        //子控件的背景颜色
        UIColor *normalColor= nil;
        //子控件的文本颜色
        UIColor *textColor= nil;
        effectBlock(&type,&dirType,&margin,&duration,&normalColor,&textColor);

        self.type = type;
        self.dirType = dirType;
    
        if (margin) {
            self.margin = margin;
        }
        if (duration) {
            self.duration = duration;
        }
        if (normalColor) {
            self.normalColor = normalColor;
        }
        if (textColor) {
            self.textColor = textColor;
        }
    }
}


/**
 为指定索引的的子控件添加动画
 @param index 子控件索引
 @param text 当前文本视图显示的文字
 */
- (void)setAnimationWithIndex:(NSInteger)index text:(NSString*)text {
    if (index <0 || index > self.views.count - 1 || self.isAnimated) {return; }
    //获取指定索引的子控件
     UILabel *label = (UILabel*)self.views[index];
     label.clipsToBounds = YES;
     self.animateView = label;
    //创建动画
    CATransition *transition = [CATransition animation];
    transition.duration = self.duration;
    transition.delegate = self;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //设置动画类型
    if (self.type == kReversalViewCube) {
        transition.type = @"cube"  ;
    }else if (self.type == kReversalViewPush){
        transition.type = kCATransitionPush;
    }else if (self.type == kReversalViewMoveIn){
        transition.type = kCATransitionMoveIn;
    }else if (self.type == kReversalViewFade){
        transition.type = kCATransitionFade;
    }else if (self.type == kReversalViewReveal){
        transition.type = kCATransitionReveal;
    }
    //设置动画方向
    if (self.dirType == kReversalViewTop) {
        transition.subtype = kCATransitionFromBottom;
    }else if (self.dirType == kReversalViewBottom){
        transition.subtype = kCATransitionFromTop;
    }else if (self.dirType == kReversalViewLeft){
        transition.subtype = kCATransitionFromRight;
    }else if (self.dirType == kReversalViewRight){
        transition.subtype = kCATransitionFromLeft;
    }
    [label.layer addAnimation:transition forKey:@"animation"];
    if (text == nil) {return;}
    //设置文字
    self.animateView.text = text;
}

/**
 添加子视图
 */
- (void)addViews{
    for (int i = 0 ; i< self.texts.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.text = self.texts[i];
        label.backgroundColor = self.normalColor;
        label.textColor = self.textColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:20];
        [self.views addObject:label];
        [self addSubview:label];
    }
}

/**
 布局子控件
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    NSInteger count = self.texts.count;
    CGFloat viewW = (width - count-1*self.margin) / count;
    for (int i = 0 ; i< self.views.count; i++) {
        UIView *view = (UIView*)self.views[i];
        view.frame = CGRectMake(i*(viewW+self.margin), 0, viewW, height);
    }
}

#pragma mark CAAnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim {
    self.isAnimated = YES;
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        self.isAnimated = NO;
    }
}
@end
