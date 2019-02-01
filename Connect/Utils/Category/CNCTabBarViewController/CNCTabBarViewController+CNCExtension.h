////  CNCTabBarViewController+CNCExtension.h
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCTabBarViewController.h"
@class CNCViewController;

@interface CNCTabBarViewController (CNCExtension)

/**
 添加tabBar导航控制器

 @param viewController 控制器
 @param imgName 图片名
 */
- (void)cnc_addChildViewController:(CNCViewController *)viewController tabBarImageName:(NSString *)imgName;

@end
