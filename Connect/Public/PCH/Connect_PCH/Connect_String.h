////  Connect_String.h
//  Connect
//
//  Created by Dwang on 2018/9/30.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#ifndef Connect_String_h
#define Connect_String_h

/** s1的内容是否与s2的内容相等 */
#define ISEqualToString(s1, s2) [s1 isEqualToString:s2]

/** 极光Key */
static NSString *const kJPushKey = @"49e817a6acf30cdd3629b571";

/** 蒲公英Key */
static NSString *const kPGYKey = @"a1e6d774eb32cb7be3752dba5969022a";

/** 收件人 */
static NSString *const kEMail = @"coderdwang@outlook.com";

/** 抄送人 */
static NSString *const kCopyEMail = @"coderdwang@gmail.com";

#endif /* Connect_String_h */
