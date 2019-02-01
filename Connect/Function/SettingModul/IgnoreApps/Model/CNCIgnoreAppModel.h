////  CNCIgnoreAppModel.h
//  Connect
//
//  Created by Dwang on 2018/9/29.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCIgnoreAppModel : NSObject

/** id */
@property(nonatomic, copy, readonly) NSString *appid;


/** icon */
@property(nonatomic, copy, readonly) NSString *appIcon;

/** 名称 */
@property(nonatomic, copy, readonly) NSString *appName;

/** 归属账号 */
@property(nonatomic, copy, readonly) NSString *account;

/** 创建时间/隐藏时间 */
@property(nonatomic, copy, readonly) NSString *creatTime;

@end

NS_ASSUME_NONNULL_END
