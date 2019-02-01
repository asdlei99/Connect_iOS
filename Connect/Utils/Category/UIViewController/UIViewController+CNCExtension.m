////  UIViewController+CNCExtension.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "UIViewController+CNCExtension.h"

@implementation UIViewController (CNCExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExchangeImplementations([self class], @selector(viewDidLoad), @selector(cnc_viewDidLoad));
    });
}

- (void)cnc_viewDidLoad {
    [self cnc_viewDidLoad];
    [self setUI];
    [self setNetwork];
}

- (void)setUI {
    
}

- (void)setNetwork {
    
}

@end
