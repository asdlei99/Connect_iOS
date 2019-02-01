////  CNCAppDetailModel.h
//  Connect
//
//  Created by Dwang on 2018/10/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CNCDetailPlatformModel;
@class CNCDetailModel;
@class CNCLanguageModel;

NS_ASSUME_NONNULL_BEGIN

@interface CNCAppDetailModel : NSObject

/** 主销售国家代码 */
@property(nonatomic, copy, readonly) NSString *primaryLocaleCode;

/** appid */
@property(nonatomic, copy, readonly) NSString *adamId;

/** 商店地址 */
@property(nonatomic, copy, readonly) NSString *appStoreUrl;

/** 所有语言 */
@property(nonatomic, copy, readonly) NSArray<CNCLanguageModel *> *localizedMetadata;

/** 平台 */
@property(nonatomic, copy, readonly) NSArray<CNCDetailPlatformModel *> *platforms;

/** 应用名称 */
@property(nonatomic, copy, readonly) NSString *appName;

/** icon */
@property(nonatomic, copy, readonly) NSString *iconUrl;

/** 语言 */
@property(nonatomic, copy, readonly) NSString *language;

/** 介绍 */
@property(nonatomic, strong, readonly) CNCDetailModel *desc;

/** 更新日志 */
@property(nonatomic, strong, readonly) CNCDetailModel *releaseNotes;

/** 关键词 */
@property(nonatomic, strong, readonly) CNCDetailModel *keywords;

/** 版本 */
@property(nonatomic, strong, readonly) CNCDetailModel *version;

/** 状态 */
@property(nonatomic, copy, readonly) NSString *status;

/** 状态中文 */
@property(nonatomic, copy, readonly) NSString *statusStr;

/** 状态颜色 */
@property(nonatomic, strong, readonly) UIColor *statusColor;

/** 设备型号 */
@property(nonatomic, copy, readonly) NSArray<NSString *> *screenshotNames;

/** 截图地址 */
@property(nonatomic, copy, readonly) NSArray<NSArray <NSString *>*> *screenshots;

@property(nonatomic, copy) void (^cnc_applicationDetailCallBack)(void);

- (void)cnc_requestApplicationDetailWithAppid:(NSString *)appid;

- (void)cnc_reloadData;

@end

NS_ASSUME_NONNULL_END
