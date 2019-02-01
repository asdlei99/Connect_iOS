////  CNCAVersionSetsModel.h
//  Connect
//
//  Created by Dwang on 2018/9/26.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CNCAVSVersionModel.h"
#import "CNCQueryOptionsModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface CNCAVersionSetsModel : NSObject

/** 平台 */
@property(nonatomic, copy, readonly) NSString *platformString;

/** 在审核的版本 */
@property(nonatomic, strong, readonly) CNCAVSVersionModel *inFlightVersion;

/** 在销售的版本 */
@property(nonatomic, strong, readonly) CNCAVSVersionModel *deliverableVersion;

/** 类型 */
@property(nonatomic, copy, readonly) NSString *type;

/** 曾经是否销售过 */
@property(nonatomic, assign, readonly) BOOL everBeenOnSale;

/** 可操作类型 */
@property(nonatomic, strong, readonly) CNCQueryOptionsModel *optionsModel;

@end

NS_ASSUME_NONNULL_END
