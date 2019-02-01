////  CNCDetailPlatformModel.h
//  Connect
//
//  Created by Dwang on 2018/10/29.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CNCDetailVersionModel;

NS_ASSUME_NONNULL_BEGIN

@interface CNCDetailPlatformModel : NSObject

/** 曾经是否出售过 */
@property(nonatomic, assign, readonly) BOOL everBeenOnSale;

/** 平台 */
@property(nonatomic, copy, readonly) NSString *platformString;

/** 在审核的 */
@property(nonatomic, strong, readonly) CNCDetailVersionModel *inFlightVersion;

/** 正在销售的 */
@property(nonatomic, strong, readonly) CNCDetailVersionModel *deliverableVersion;

@end

NS_ASSUME_NONNULL_END
