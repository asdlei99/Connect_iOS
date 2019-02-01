////  CNCCreateAccountModel.h
//  Connect
//
//  Created by Dwang on 2018/9/5.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNCCreateAccountModel : NSObject

@property(nonatomic, copy, readonly) NSArray <CNCCreateAccountModel *> *models;

/** 标题 */
@property(nonatomic, copy, readonly) NSString *title;

/** 内容 */
@property(nonatomic, copy, readonly) NSString *value;

/** key */
@property(nonatomic, copy, readonly) NSString *key;

@end
