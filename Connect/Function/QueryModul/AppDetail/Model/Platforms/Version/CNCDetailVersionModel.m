////  CNCDetailVersionModel.m
//  Connect
//
//  Created by Dwang on 2018/10/29.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCDetailVersionModel.h"

@interface CNCDetailVersionModel ()

/** 类型 */
@property(nonatomic, copy, readwrite) NSString *type;

/** 版本id */
@property(nonatomic, copy, readwrite) NSString *vid;

/** 版本号 */
@property(nonatomic, copy, readwrite) NSString *version;

/** 状态 */
@property(nonatomic, copy, readwrite) NSString *state;

/** 状态key */
@property(nonatomic, copy, readwrite) NSString *stateKey;

/** 状态分组 */
@property(nonatomic, copy, readwrite) NSString *stateGroup;

@end

@implementation CNCDetailVersionModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"vid":@"id"};
}

@end
