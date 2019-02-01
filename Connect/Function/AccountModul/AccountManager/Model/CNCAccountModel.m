////  CNCAccountModel.m
//  Connect
//
//  Created by Dwang on 2018/9/3.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCAccountModel.h"

@interface CNCAccountModel ()

/** 邮箱 */
@property(nonatomic, copy, readwrite) NSString *email;

/** 邮箱密码 */
@property(nonatomic, copy, readwrite) NSString *email_password;

/** 开发者密码 */
@property(nonatomic, copy, readwrite) NSString *developer_password;

/** cookie */
@property(nonatomic, copy, readwrite) NSString *cookies;

/** 备注 */
@property(nonatomic, copy, readwrite) NSString *mark;

/** 创建时间 */
@property(nonatomic, copy, readwrite) NSString *createTime;

@end

@implementation CNCAccountModel

@end
