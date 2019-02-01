////  CNCSQLManager.h
//  Connect
//
//  Created by Dwang on 2018/9/3.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CNCIgnoreAppModel.h"
#import "CNCAccountModel.h"

@interface CNCSQLManager : NSObject

+ (instancetype)sharedInstance;

/** 账号模型数组 */
@property(nonatomic, copy, readonly) NSArray<CNCAccountModel *> *accountModels;

/** 被忽略的App模型数组 */
@property(nonatomic, copy, readonly) NSArray<CNCIgnoreAppModel *> *ignoreAppModels;

/**
 为账号模型重新排序
 */
- (void)rearrangeAccountModels;

/**
 添加账号

 @param model 账号模型
 */
- (void)cnc_putToAccountSQLTableWithModel:(CNCAccountModel *)model;

/**
 删除账号

 @param model 账号模型
 */
- (void)cnc_deleteForAccountSQLTableWithModel:(CNCAccountModel *)model;

/**
 修改账号信息

 @param model 账号模型
 */
- (void)cnc_editForAccountSQLTableWithModel:(CNCAccountModel *)model;

/**
 移动账号模型顺序

 @param fromModel 从谁
 @param toModel 到谁
 */
- (void)cnc_moveForAccountSQLTableWithFromModel:(CNCAccountModel *)fromModel toModel:(CNCAccountModel *)toModel;

/**
 添加被忽略的app
 
 @param model 被忽略的app模型
 */
- (void)cnc_putToIgnoreAppSQLTableWithModel:(CNCIgnoreAppModel *)model;

/**
 移除被忽略的app
 
 @param model 账号模型
 */
- (void)cnc_deleteForIgnoreAppSQLTableWithModel:(CNCIgnoreAppModel *)model;

@end
