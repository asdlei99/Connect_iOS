////  Connect_Regular.h
//  Connect
//
//  Created by Dwang on 2018/9/25.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#ifndef Connect_Regular_h
#define Connect_Regular_h

/** 是否隐藏准备提交状态的Apps */
static NSString *const kHiddenPrepareForUpload = @"CNCHiddenPrepareForUpload";

/** 是否关闭启动动画 */
static NSString *const kCloseLaunchScreenAnimation = @"CNCCloseLaunchScreenAnimation";

/** 是否关闭TabBar点击动画 */
static NSString *const kCloseTabBarItemAnimation = @"CNCCloseTabBarItemAnimation";

/** 是否关闭删除账号时的弹框 */
static NSString *const kCloseDeleteAccountAlert = @"CNCCloseDeleteAccountAlert";

/** 账号添加完成后是否提示 */
static NSString *const kCloseCreateAccountAlert = @"kCloseCreateAccountAlert";

/** 新添加账号按照倒序排序 */
static NSString *const kNewAccountSort = @"kNewAccountSort";

/** 是否关闭隐藏应用时的弹框 */
static NSString *const kCloseHiddenApplicationAlert = @"kCloseHiddenApplicationAlert";

/** 是否为最后查询的账号增加标记 */
static NSString *const kOpenLastQueryAccountMark = @"kOpenLastQueryAccountMark";

/** 增加新账号 */
static NSString *const kCreateAccount = @"com.coderdwang.connect.createAccount";

/** 邮箱验证,自己写的第一个正则,记录一下😁😁😁 */
static NSString *const kEMailRegular = @"^\\w.+@([A-Za-z0-9]{2,}\\.)+[A-Za-z]{2,}$";

/** 匹配html标签的正则 */
static NSString *const kHTMLTagRegular = @"<[^>]*>|&nbsp;";

/** cookie分割规则 */
static NSString *const kCookiesSegmentationRegular = @"CoderDwang_Connect_iOS_Segmentation_Regular";

/** 请求地址替换规则,此处需要与<Connect_UrlHost.h>文件中的内容统一 */
static NSString *const kResolutionCenterRepcRegular = @"######";
static NSString *const kResolutionCenterRepcRegular2 = @"******";

/** 最后一个查询的数据 */
static NSString *const kLastQueryAccount = @"kLastQueryAccount";

#endif /* Connect_Regular_h */
