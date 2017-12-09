//
//  YOpacityLabel.h
//  YOpacityLabel
//
//  Created by shusy on 2017/12/8.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YOpacityLabel : UILabel

/**
 创建透明度变化label
 @param frame frame
 @param offsetX x  正值表示x加大 负值表示x减小
 @param offsetY y  正值表示y加大 负值表示y减小
 @return 透明度变化label
 */
- (instancetype)initWithFrame:(CGRect)frame offsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY duration:(CGFloat)duration;

@end
