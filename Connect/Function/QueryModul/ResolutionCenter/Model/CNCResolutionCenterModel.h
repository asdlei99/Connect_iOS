////  CNCResolutionCenterModel.h
//  Connect
//
//  Created by Dwang on 2018/10/5.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CNCResolutionCenterMsgModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CNCResolutionCenterModel : NSObject

/** 版本号 */
@property(nonatomic, copy, readonly) NSString *version;

/** 版本号id */
@property(nonatomic, copy, readonly) NSString *versionId;

/** 反馈id */
@property(nonatomic, copy, readonly) NSString *backId;

/** 是否处于活动状态 */
@property(nonatomic, assign, readonly) BOOL active;

/** 反馈信息 */
@property(nonatomic, strong, readonly) NSArray<CNCResolutionCenterMsgModel *> *messages;

@property(nonatomic, copy) void (^cnc_requestResolutionCenterCallBack)(void);

- (void)cnc_requestResolutionCenterWithAppid:(NSString *)appid;

@end

NS_ASSUME_NONNULL_END
