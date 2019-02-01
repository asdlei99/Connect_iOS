////  Connect_NSLog.h
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#ifndef Connect_NSLog_h
#define Connect_NSLog_h

#ifdef DEBUG
#define NSLog( s, ... ) NSLog( @"\n{\n所在方法:%s\n所在行数:%d\n打印内容:%@\n}", __func__, __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__])
#else
#define NSLog(...)
#endif

#endif /* Connect_NSLog_h */
