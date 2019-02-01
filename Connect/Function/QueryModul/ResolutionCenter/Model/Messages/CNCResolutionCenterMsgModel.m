////  CNCResolutionCenterMsgModel.m
//  Connect
//
//  Created by Dwang on 2018/10/5.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCResolutionCenterMsgModel.h"

@interface CNCResolutionCenterMsgModel ()

/** 信息数量 */
@property(nonatomic, copy, readwrite) NSString *appleMsg;

/** 详情 */
@property(nonatomic, copy, readwrite) NSString *body;

/** 时间戳 */
@property(nonatomic, copy, readwrite) NSString *date;

/** 格式化后的时间/YYYY-MM-dd hh:mm:ss */
@property(nonatomic, copy, readwrite) NSString *dateFormat;

/** 来源 */
@property(nonatomic, copy, readwrite) NSString *from;

@end

@implementation CNCResolutionCenterMsgModel

- (NSString *)dateFormat {
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"YYYY年MM月dd日";
    NSDate *lastDate = [NSDate dateWithTimeIntervalSince1970:[_date doubleValue]/1000.0];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *compas = [calendar components:unit fromDate:lastDate toDate:nowDate options:0];
    if (compas.year) {
        format.dateFormat = @"YYYY年MM月dd日";
    }else if (compas.month) {
        if (compas.month > 9) {
            format.dateFormat = @"MM月dd日 HH时mm分";
        }else {
            format.dateFormat = @"M月dd日 HH时mm分";
        }
    }else if (compas.day) {
        format.dateFormat = @"dd日 HH时mm分ss秒";
    }else if (compas.hour) {
        format.dateFormat = @"HH时mm分ss秒";
    }else if (compas.minute) {
        format.dateFormat = @"HH时mm分ss秒";
    }else {
        return @"刚刚";
    }
    return [format stringFromDate:lastDate];
}

@end
