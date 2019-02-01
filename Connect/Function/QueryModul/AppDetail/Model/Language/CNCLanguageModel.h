////  CNCLanguageModel.h
//  Connect
//
//  Created by iizvv on 2018/11/28.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCLanguageModel : NSObject

/** 国家代码 */
@property(nonatomic, copy, readonly) NSString *localeCode;

/** App名称 */
@property(nonatomic, copy, readonly) NSString *name;

@end

NS_ASSUME_NONNULL_END
