////  CNCNotification.m
//  Connect
//
//  Created by Dwang on 2018/9/13.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCNotification.h"

@implementation CNCNotification

+ (void)cnc_addObserver:(id)observer selector:(SEL)selector name:(NSNotificationName)notificationName {
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:notificationName object:nil];
}

+ (void)cnc_postNotificationName:(NSNotificationName)notificationName {
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];
}

+ (void)cnc_postNotificationName:(NSNotificationName)notificationName object:(id)object {
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:object];
}

+ (void)cnc_removeObserver:(id)observer name:(NSNotificationName)notificationName {
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:notificationName object:nil];
}

@end
