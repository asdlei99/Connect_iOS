////  NSDate+CNCExtension.m
//  Connect
//
//  Created by Dwang on 2018/9/8.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "NSDate+CNCExtension.h"

@implementation NSDate (CNCExtension)

+ (NSString *)cnc_currentDate {
    return [self cnc_currentDateWithFormat:@"MM-dd"];
}

+ (NSString *)cnc_currentDateWithFormat:(NSString *)format {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}

@end
