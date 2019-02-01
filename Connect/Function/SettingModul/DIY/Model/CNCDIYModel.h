////  CNCDIYModel.h
//  Connect
//
//  Created by Dwang on 2018/10/18.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCDIYModel : NSObject

/** 模型数据 */
@property(nonatomic, copy, readonly) NSArray<CNCDIYModel *> *models;

/** 标题 */
@property(nonatomic, copy, readonly) NSString *title;

/** 开关状态 */
@property(nonatomic, assign, readonly) BOOL status;

@end

NS_ASSUME_NONNULL_END
