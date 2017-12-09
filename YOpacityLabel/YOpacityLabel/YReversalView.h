//
//  YReversalView.h
//  Ykit
//
//  Created by shusy on 2017/12/9.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import <UIKit/UIKit.h>

/**动画类型*/
typedef enum : NSUInteger {
    kReversalViewPush,
    kReversalViewFade,
    kReversalViewMoveIn,
    kReversalViewCube,
    kReversalViewReveal,
} YReversalViewType;

/**动画方向*/
typedef enum : NSUInteger {
    kReversalViewTop,
    kReversalViewLeft,
    kReversalViewBottom,
    kReversalViewRight
} YReversalViewDirType;

@interface YReversalView : UIView

/**
 初始化方法
 @param frame frame
 @param texts 文本数组
 @return YReversalView
 */
- (instancetype)initWithFrame:(CGRect)frame texts:(NSArray*)texts;

/**
 重新设置所有的标题文本
 */
- (void)setAllTexts:(NSArray*)texts;

/**
 快捷配置相关的参数
 totalCount 获取指定的产生图片的个数
 margin子控件之间的间距
 duration 动画时长
 normalColor 子控件的背景颜色
 textColor 子控件的文本颜色
 @param effectBlock 快捷设置block
 */
- (void)setUpProperties:(void(^)(YReversalViewType *type, YReversalViewDirType *dirType,CGFloat *margin,CGFloat *duration,UIColor **normalColor,UIColor **textColor))effectBlock;
    
/**
 为指定索引的的子控件添加动画
 @param index 子控件索引
 @param text 当前文本视图显示的文字
 */
- (void)setAnimationWithIndex:(NSInteger)index text:(NSString*)text;

@end
