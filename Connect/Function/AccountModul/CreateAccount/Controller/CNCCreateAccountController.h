////  CNCCreateAccountController.h
//  Connect
//
//  Created by Dwang on 2018/9/3.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCViewController.h"
@class CNCAccountModel;

@interface CNCCreateAccountController : CNCViewController

/** 刷新账号管理数据 */
@property(nonatomic, copy) void (^cnc_accountOperateTypeCallBack)(CNCAccountOperateType operateType);

/** 账号信息模型,当此模型存在时表示当前模式为修改账号 */
@property(nonatomic, strong) CNCAccountModel *accountModel;

@end
