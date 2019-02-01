////  CNCViewController.h
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "QMUICommonViewController.h"
#import "CNCNavigationController.h"

@interface CNCViewController : QMUICommonViewController

/** 是否加载过 */
@property(nonatomic, assign, getter=isLoading) BOOL loading;

/** 导航栏 */
@property(nonatomic, strong) UIView *navigationBar;

/** 活动指示器 */
@property(nonatomic, strong) QMUITips *toastView;

@end
