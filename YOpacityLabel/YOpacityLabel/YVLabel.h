//
//  VLabel.h
//  Jiutifen
//
//  Created by shusy on 2017/11/14.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YVLabel : UIView
@property(strong,nonatomic)UILabel *titleLabel; //标题
@property(strong,nonatomic)UILabel *subTitleLabel;//描述
@property(nonatomic,copy)void(^clicked)(void);//点击回调
@end
