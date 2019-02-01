////  CNCDetailModel.m
//  Connect
//
//  Created by iizvv on 2018/11/21.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCDetailModel.h"

@interface CNCDetailModel ()

/** 详情 */
@property(nonatomic, copy, readwrite) NSString *value;

/** 是否可编辑 */
@property(nonatomic, assign, readwrite) BOOL isEditable;

/** 是否必填 */
@property(nonatomic, assign, readwrite) BOOL isRequired;

@end

@implementation CNCDetailModel

@end
