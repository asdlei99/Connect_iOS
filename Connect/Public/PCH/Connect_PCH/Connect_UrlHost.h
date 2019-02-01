////  Connect_UrlHost.h
//  Connect
//
//  Created by Dwang on 2018/9/25.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#ifndef Connect_UrlHost_h
#define Connect_UrlHost_h

/** wkBaseUrl */
static NSString *const wkBaseUrl = @"";

/** 支付宝收款码 */
static NSString *const aliPay = @"alipayqr://platformapi/startapp?saId=10000007&clientVersion=3.7.0.0718&qrcode=https://qr.alipay.com/fkx05366x4vpdgkrpyxze2f";

/** 加入QQ群 */
static NSString *const joinQQCroup = @"mqqapi://card/show_pslcard?src_type=internal&version=1&uin=583946521&key=52786588117cfd58796e6000632a936b7ac07299f49589a8478fbe09bfbbf01c&card_type=group&source=external";

/** 商店 */
static NSString *const jumpAppStore = @"https://itunes.apple.com/cn/app/id######";
#define CNCJumpAppStore(appid) [jumpAppStore stringByReplacingOccurrencesOfString:kResolutionCenterRepcRegular withString:appid]

/** 登录开发者账号 */
static NSString *const appleDevSiginUrlHost = @"https://idmsa.apple.com/appleauth/auth/signin";

/** 查询应用状态 */
static NSString *const appleApplicationStatusUrlHost = @"https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/apps/manageyourapps/summary/v2";

/** 解决方案中心 */
static NSString const *appleiTunesConnectResolutionCenter = @"https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/apps/######/platforms/ios/resolutionCenter";
#define CNCiTunesConnectResolutionCenter(appid) [appleiTunesConnectResolutionCenter stringByReplacingOccurrencesOfString:kResolutionCenterRepcRegular withString:appid]

/** 获取版本信息 */
static NSString const *appleiTunesConnectVerisons = @"https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/apps/######/overview";
#define CNCiTunesConnectVerisons(appid) [appleiTunesConnectVerisons stringByReplacingOccurrencesOfString:kResolutionCenterRepcRegular withString:appid]

/** 详情 */
static NSString const *appleiTunesConnectDetail = @"https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/apps/######/platforms/ios/versions/******";
#define CNCiTunesConnectDetail(appid, vid) [[appleiTunesConnectDetail stringByReplacingOccurrencesOfString:kResolutionCenterRepcRegular withString:appid] stringByReplacingOccurrencesOfString:kResolutionCenterRepcRegular2 withString:vid]

/** iTunes预览图下载 */
#define CNCiTunesAppPreview(imgUrl) [NSString stringWithFormat:@"https://is1-ssl.mzstatic.com/image/thumb/%@/0x0ss.jpg", imgUrl]

/** google翻译 */
#define CNCGoogleTranslate(string) [NSString stringWithFormat:@"http://translate.google.cn/translate_a/single?client=gtx&dt=t&dj=1&ie=UTF-8&sl=auto&tl=zh_CN&q=%@", string.qmui_removeMagicalChar.qmui_stringByEncodingUserInputQuery]

/** 蝉大师今日发现 */
static NSString *const chanMasterTodayCount = @"https://www.chandashi.com/bang/week.html";
static NSString const *chanMasterTodayData = @"https://www.chandashi.com/bang/weekdata/genre/0/date/######.html";
#define CNCChanMasterTodayData [chanMasterTodayData stringByReplacingOccurrencesOfString:kResolutionCenterRepcRegular withString:[NSDate cnc_currentDateWithFormat:@"yyyy-MM-dd"]]

#endif /* Connect_UrlHost_h */
