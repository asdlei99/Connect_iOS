////  CNCDetailVersionModel.h
//  Connect
//
//  Created by Dwang on 2018/10/29.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCDetailVersionModel : NSObject

/** 类型 */
@property(nonatomic, copy, readonly) NSString *type;

/** 版本id */
@property(nonatomic, copy, readonly) NSString *vid;

/** 版本号 */
@property(nonatomic, copy, readonly) NSString *version;

/** 状态 */
@property(nonatomic, copy, readonly) NSString *state;

/** 状态key */
@property(nonatomic, copy, readonly) NSString *stateKey;

/** 状态分组 */
@property(nonatomic, copy, readonly) NSString *stateGroup;

@end

NS_ASSUME_NONNULL_END
