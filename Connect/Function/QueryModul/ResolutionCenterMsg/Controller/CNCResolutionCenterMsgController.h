////  CNCResolutionCenterMsgController.h
//  Connect
//
//  Created by Dwang on 2018/10/7.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CNCResolutionCenterMsgController : CNCViewController

/** 反馈详情 */
@property(nonatomic, copy) NSString *htmlString;

/** 来源 */
@property(nonatomic, copy) NSString *author;

/** 是否允许回复 */
@property(nonatomic, assign) BOOL reply;

@end

NS_ASSUME_NONNULL_END
