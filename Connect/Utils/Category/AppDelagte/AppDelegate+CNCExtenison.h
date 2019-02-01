////  AppDelegate+CNCExtenison.h
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (CNCExtenison)

/** app的全局设置 */
- (void)cnc_applyConfigurationWithOptions:(NSDictionary *)launchOptions;

/** 启动动画 */
- (void)startAnimation;

@end
