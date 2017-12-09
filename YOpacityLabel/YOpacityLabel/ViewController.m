//
//  ViewController.m
//  YOpacityLabel
//
//  Created by shusy on 2017/12/8.
//  Copyright © 2017年 杭州爱卿科技. All rights reserved.
//

#import "ViewController.h"
#import "YOpacityLabel.h"
#import "YCoinButton.h"
#import "YReversalView.h"

@interface ViewController ()
//@property(nonatomic,strong)YOpacityLabel *lael;
@property(nonatomic,strong)YCoinButton *btn;
@property(nonatomic,strong) YReversalView *reversalView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    YOpacityLabel *lael = [[YOpacityLabel alloc] initWithFrame:CGRectMake(100, 300, 100, 30) offsetX:100 offsetY:100 duration:1];
//    lael.text = @"+9999";
//    self.lael = lael;
    
//    YCoinButton *btn = [[YCoinButton alloc] initWithFrame:CGRectMake(200, 200, 40, 40) endPoint:CGPointMake(0, 0)];
//    [btn setUpProperties:^(CGFloat *totalCount, CGFloat *timeDelay, CGFloat *duration, UIImage *__autoreleasing *animatedImage) {
//        *totalCount = 5;
//        *timeDelay = 0.1;
//        *duration = 1;
//    }];
//    self.btn = btn;
//    [self.view addSubview:btn];
    
    NSArray *texts = @[@"9",@"9",@"8",@"7"];
    YReversalView *reversalView = [[YReversalView alloc] initWithFrame:CGRectMake(80, 100, 200, 40) texts:texts];
    [self.view addSubview:reversalView];
    self.reversalView = reversalView;
    [self.reversalView setUpProperties:^(YReversalViewType *type, YReversalViewDirType *dirType, CGFloat *margin, CGFloat *duration, UIColor *__autoreleasing *normalColor, UIColor *__autoreleasing *textColor) {
        *dirType = kReversalViewRight;
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  
    
    NSString *str = [NSString stringWithFormat:@"%d",arc4random_uniform(10)];
    [self.reversalView setAnimationWithIndex:arc4random_uniform(4) text:str];

}

@end
