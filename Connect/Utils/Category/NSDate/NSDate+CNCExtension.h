////  NSDate+CNCExtension.h
//  Connect
//
//  Created by Dwang on 2018/9/8.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CNCExtension)

/** 获取当前时间, 格式为:(MM-dd) */
+ (NSString *)cnc_currentDate;

/** 获取具体格式的当前时间 */
+ (NSString *)cnc_currentDateWithFormat:(NSString *)format;

@end
