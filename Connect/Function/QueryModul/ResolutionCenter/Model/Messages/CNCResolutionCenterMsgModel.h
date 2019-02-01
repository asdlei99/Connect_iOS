////  CNCResolutionCenterMsgModel.h
//  Connect
//
//  Created by Dwang on 2018/10/5.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCResolutionCenterMsgModel : NSObject

/** 信息数量 */
@property(nonatomic, copy, readonly) NSString *appleMsg;

/** 详情 */
@property(nonatomic, copy, readonly) NSString *body;

/** 时间戳 */
@property(nonatomic, copy, readonly) NSString *date;

/** 格式化后的时间/YYYY-MM-dd hh:mm:ss */
@property(nonatomic, copy, readonly) NSString *dateFormat;

/** 来源 */
@property(nonatomic, copy, readonly) NSString *from;

@end

NS_ASSUME_NONNULL_END
