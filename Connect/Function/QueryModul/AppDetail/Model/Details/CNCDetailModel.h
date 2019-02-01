////  CNCDetailModel.h
//  Connect
//
//  Created by iizvv on 2018/11/21.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCDetailModel : NSObject

/** 详情 */
@property(nonatomic, copy, readonly) NSString *value;

/** 是否可编辑 */
@property(nonatomic, assign, readonly) BOOL isEditable;

/** 是否必填 */
@property(nonatomic, assign, readonly) BOOL isRequired;

@end

NS_ASSUME_NONNULL_END
