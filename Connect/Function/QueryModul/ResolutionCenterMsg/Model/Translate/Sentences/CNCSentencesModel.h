////  CNCSentencesModel.h
//  Connect
//
//  Created by iizvv on 2018/11/28.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCSentencesModel : NSObject

/** 翻译后的结果 */
@property(nonatomic, copy, readonly) NSString *trans;

/** 原始内容 */
@property(nonatomic, copy, readonly) NSString *orig;

@end

NS_ASSUME_NONNULL_END
