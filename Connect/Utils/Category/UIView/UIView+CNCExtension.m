////  UIView+CNCExtension.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "UIView+CNCExtension.h"

@implementation UIView (CNCExtension)
@dynamic round;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExchangeImplementations(self, @selector(initWithFrame:), @selector(cnc_initWithFrame:));
    });
}

- (instancetype)cnc_initWithFrame:(CGRect)rect {
    UIView *view = [self cnc_initWithFrame:rect];
    [self loadView];
    return view;
}

- (void)loadView {
}

- (void)cnc_setGradientColors:(NSArray <UIColor *>*)colors {
    [self layoutIfNeeded];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    NSMutableArray *gradientColors = [NSMutableArray array];
    [colors enumerateObjectsUsingBlock:^(UIColor * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [gradientColors addObject:obj];
    }];
    gradient.colors = gradientColors;
    gradient.startPoint = CGPointMake(0, 1);
    gradient.endPoint = CGPointMake(1, 1);
    [self.layer addSublayer:gradient];
}

- (void)setRound:(BOOL)round {
    if (round) {
        [self layoutIfNeeded];
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.bounds.size];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    }
}

@end
