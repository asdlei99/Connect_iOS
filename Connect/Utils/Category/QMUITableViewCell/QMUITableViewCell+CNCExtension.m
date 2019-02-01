////  QMUITableViewCell+CNCExtension.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "QMUITableViewCell+CNCExtension.h"

@implementation QMUITableViewCell (CNCExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ExchangeImplementations([self class], @selector(initWithStyle:reuseIdentifier:), @selector(cnc_initWithStyle:reuseIdentifier:));
    });
}

- (instancetype)cnc_initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    QMUITableViewCell *cell = [self cnc_initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setCellINFO];
    return cell;
}

- (void)setCellINFO {
    
}

@end
