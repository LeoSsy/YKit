//
//  JTHLabel.m
//  Jiutifen
//
//  Created by shusy on 2017/12/7.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import "YHLabel.h"

@interface YHLabel()

@end

@implementation YHLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _leftL = [[UILabel alloc] init];
        _leftL.text = @"提现到";
        _leftL.font = [UIFont systemFontOfSize:12];
        _leftL.textColor = [UIColor lightGrayColor];
        [self addSubview:_leftL];
        
        _rightL = [[UILabel alloc] init];
        _rightL.text = @"工商银行";
        _rightL.font = [UIFont systemFontOfSize:12];
        _rightL.textColor = [UIColor blackColor];
        _rightL.textAlignment = NSTextAlignmentRight;
        [self addSubview:_rightL];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat btnW= width*0.5;
    
    self.leftL.frame = CGRectMake(0, 0, btnW, height);
    self.leftL.frame = CGRectMake(btnW, 0, btnW, height);

}

@end
