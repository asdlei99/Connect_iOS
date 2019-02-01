////  CNCAVSVersionModel.h
//  Connect
//
//  Created by Dwang on 2018/9/26.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCAVSVersionModel : NSObject

/** 类型 */
@property(nonatomic, copy, readonly) NSString *type;

/** 版本 */
@property(nonatomic, copy, readonly) NSString *version;

/** 状态 */
@property(nonatomic, copy, readonly) NSString *state;

/** 状态key */
@property(nonatomic, copy, readonly) NSString *stateKey;

/** 状态分组 */
@property(nonatomic, copy, readonly) NSString *stateGroup;

/** 状态颜色 */
@property(nonatomic, strong, readonly) UIColor *stateColor;

/** 状态中文 */
@property(nonatomic, copy, readonly) NSString *stateStr;

@end

NS_ASSUME_NONNULL_END
