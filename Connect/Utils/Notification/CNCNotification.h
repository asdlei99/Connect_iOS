////  CNCNotification.h
//  Connect
//
//  Created by Dwang on 2018/9/13.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNCNotification : NSObject

/**
 添加通知

 @param observer 监听通知的对象
 @param selector 接收到通知后执行的方法
 @param notificationName 通知名
 */
+ (void)cnc_addObserver:(id)observer selector:(SEL)selector name:(NSNotificationName)notificationName;

/**
 发送通知

 @param notificationName 通知名
 */
+ (void)cnc_postNotificationName:(NSNotificationName)notificationName;

/**
 发送通知

 @param notificationName 通知名
 @param object 发送的对象
 */
+ (void)cnc_postNotificationName:(NSNotificationName)notificationName object:(id)object;

/**
 移除通知

 @param observer 移除监听通知的对象
 @param notificationName 通知名
 */
+ (void)cnc_removeObserver:(id)observer name:(NSNotificationName)notificationName;

@end
