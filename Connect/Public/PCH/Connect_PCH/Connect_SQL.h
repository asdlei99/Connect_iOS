////  Connect_SQL.h
//  Connect
//
//  Created by Dwang on 2018/9/3.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#ifndef Connect_SQL_h
#define Connect_SQL_h

/** 账号数据库名称 */
static NSString *const kACCOUNTSQLDBNAME = @"CNCACCOUNTSQLDBNAME";

/** 账号数据库表名称 */
static NSString *const kACCOUNTSQLTABLENAME = @"ACCOUNTSQLTABLENAME";

/** 隐藏App数据库名称 */
static NSString *const kIGNOREAPPSQLDBNAME = @"IGNOREAPPSQLDBNAME";

/** 隐藏App数据库表名称 */
static NSString *const kIGNOREAPPSQLTABLENAME = @"IGNOREAPPSQLTABLENAME";

/** SQL */
#define CNCSQL [CNCSQLManager sharedInstance]

#endif /* Connect_SQL_h */
