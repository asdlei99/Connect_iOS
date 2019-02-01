////  CNCAppDetailController.h
//  Connect
//
//  Created by Dwang on 2018/9/21.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CNCAppDetailController : CNCViewController

/** 应用id */
@property(nonatomic, copy) NSString *appid;

/** 版本id */
@property(nonatomic, copy) NSString *versionid;

@end

NS_ASSUME_NONNULL_END
