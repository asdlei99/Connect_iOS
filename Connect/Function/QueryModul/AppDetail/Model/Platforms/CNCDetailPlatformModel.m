////  CNCDetailPlatformModel.m
//  Connect
//
//  Created by Dwang on 2018/10/29.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCDetailPlatformModel.h"

@interface CNCDetailPlatformModel ()

/** 曾经是否出售过 */
@property(nonatomic, assign, readwrite) BOOL everBeenOnSale;

/** 平台 */
@property(nonatomic, copy, readwrite) NSString *platformString;

/** 在审核的 */
@property(nonatomic, strong, readwrite) CNCDetailVersionModel *inFlightVersion;

/** 正在销售的 */
@property(nonatomic, strong, readwrite) CNCDetailVersionModel *deliverableVersion;

@end

@implementation CNCDetailPlatformModel

@end
