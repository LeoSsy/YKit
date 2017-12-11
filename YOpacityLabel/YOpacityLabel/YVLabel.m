//
//  VLabel.m
//  Jiutifen
//
//  Created by shusy on 2017/11/14.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import "YVLabel.h"

@implementation YVLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"0";
        _titleLabel.font = [UIFont boldSystemFontOfSize:24];
        _titleLabel.textColor = [UIColor blackColor];
        [self addSubview:_titleLabel];
        
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.text = @"金币管理";
        _subTitleLabel.font = [UIFont boldSystemFontOfSize:12];
        _subTitleLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:_subTitleLabel];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked)]];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat height = self.bounds.size.height*0.5;
    _titleLabel.frame = CGRectMake(0, 5, self.bounds.size.width, height);
    _subTitleLabel.frame =CGRectMake(0, height-8, self.bounds.size.width, height);
}

- (void)tapClicked{
    if (self.clicked) {
        self.clicked();
    }
}

@end
