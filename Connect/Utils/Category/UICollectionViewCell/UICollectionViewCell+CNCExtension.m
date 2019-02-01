////  UICollectionViewCell+CNCExtension.m
//  Connect
//
//  Created by Dwang on 2018/9/11.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "UICollectionViewCell+CNCExtension.h"

@implementation UICollectionViewCell (CNCExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExchangeImplementations([self class], @selector(initWithFrame:), @selector(cnc_cellinitWithFrame:));
    });
}

- (instancetype)cnc_cellinitWithFrame:(CGRect)frame {
    UICollectionViewCell *cell = [self cnc_cellinitWithFrame:frame];
    [self setCellINFO];
    return cell;
}

- (void)setCellINFO {
}

@end
