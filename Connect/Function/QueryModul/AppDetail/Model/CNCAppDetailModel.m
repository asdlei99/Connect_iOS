////  CNCAppDetailModel.m
//  Connect
//
//  Created by Dwang on 2018/10/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCAppDetailModel.h"
#import "CNCDetailPlatformModel.h"
#import "CNCDetailVersionModel.h"
#import "CNCDetailModel.h"
#import "CNCLanguageModel.h"

@interface CNCAppDetailModel ()

/** 主销售国家代码 */
@property(nonatomic, copy, readwrite) NSString *primaryLocaleCode;

/** appid */
@property(nonatomic, copy, readwrite) NSString *adamId;

/** 商店地址 */
@property(nonatomic, copy, readwrite) NSString *appStoreUrl;

/** 平台 */
@property(nonatomic, copy, readwrite) NSArray<CNCDetailPlatformModel *> *platforms;

/** 所有语言 */
@property(nonatomic, copy, readwrite) NSArray<CNCLanguageModel *> *localizedMetadata;

/** appid */
@property(nonatomic, copy) NSString *appid;

/** 语言 */
@property(nonatomic, copy, readwrite) NSString *language;

/** 应用名称 */
@property(nonatomic, copy, readwrite) NSString *appName;

/** icon */
@property(nonatomic, copy, readwrite) NSString *iconUrl;

/** 介绍 */
@property(nonatomic, strong, readwrite) CNCDetailModel *desc;

/** 关键词 */
@property(nonatomic, strong, readwrite) CNCDetailModel *keywords;

/** 更新日志 */
@property(nonatomic, strong, readwrite) CNCDetailModel *releaseNotes;

/** 版本 */
@property(nonatomic, strong, readwrite) CNCDetailModel *version;

/** 状态 */
@property(nonatomic, copy, readwrite) NSString *status;

/** 设备型号 */
@property(nonatomic, copy, readwrite) NSArray<NSString *> *screenshotNames;

/** 截图地址 */
@property(nonatomic, copy, readwrite) NSArray<NSArray <NSString *>*> *screenshots;

/** 暂存版本id */
@property(nonatomic, copy) NSString *versionID;

@end

@implementation CNCAppDetailModel

- (void)cnc_requestApplicationDetailWithAppid:(NSString *)appid {
    self.appid = appid;
    __weak __typeof(self)weakSelf = self;
    [CNCNetwork getUrl:CNCiTunesConnectVerisons(appid) callBack:^(id success) {
        NSDictionary *data = success[@"data"];
        weakSelf.primaryLocaleCode = data[@"primaryLocaleCode"];
        weakSelf.adamId = data[@"adamId"];
        weakSelf.platforms = data[@"platforms"];
        weakSelf.localizedMetadata = [NSArray yy_modelArrayWithClass:[CNCLanguageModel class] json:data[@"localizedMetadata"]];
        if (weakSelf.platforms[0].inFlightVersion.vid.length) {
            weakSelf.versionID = weakSelf.platforms[0].inFlightVersion.vid;
        }else if (weakSelf.platforms[0].deliverableVersion.vid.length) {
            weakSelf.versionID = weakSelf.platforms[0].deliverableVersion.vid;
        }
        [weakSelf cnc_requestApplicationDetailWithAppid:weakSelf.adamId versionid:weakSelf.versionID];
    }];
}

- (void)cnc_requestApplicationDetailWithAppid:(NSString *)appid versionid:(NSString *)versionid {
    __weak __typeof(self)weakSelf = self;
    [CNCNetwork getUrl:CNCiTunesConnectDetail(appid, versionid) callBack:^(id success) {
        NSDictionary *details = success[@"data"][@"details"][@"value"][0];
        NSDictionary *preReleaseBuild = success[@"data"][@"preReleaseBuild"];
        if ([preReleaseBuild isKindOfClass:[NSDictionary class]]) {
            weakSelf.appName = preReleaseBuild[@"appName"];
            weakSelf.iconUrl = preReleaseBuild[@"iconUrl"];
        }else {
            weakSelf.appName = success[@"data"][@"gameCenterSummary"][@"versionCompatibility"][@"value"][0][@"name"];
        }
        NSArray<NSDictionary *> *displayFamilies = details[@"displayFamilies"][@"value"];
        NSMutableArray <NSArray <NSString *>*>*screenshots = [NSMutableArray array];
        NSMutableArray <NSString *>*names = [NSMutableArray array];
        [displayFamilies enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj[@"screenshots"][@"value"] count]) {
                [names addObject:obj[@"name"]];
                NSMutableArray <NSString *> *strs = [NSMutableArray array];
                [obj[@"screenshots"][@"value"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSString *url = obj[@"value"][@"assetToken"];
                    [strs addObject:CNCiTunesAppPreview(url)];
                }];
                [screenshots addObject:strs];
            }
        }];
        weakSelf.screenshotNames = [NSArray arrayWithArray:names];
        weakSelf.screenshots = [NSArray arrayWithArray:screenshots];
        weakSelf.status = success[@"data"][@"status"];
        weakSelf.language = details[@"language"];
        weakSelf.version = [CNCDetailModel yy_modelWithJSON:success[@"data"][@"version"]];
        weakSelf.desc = [CNCDetailModel yy_modelWithJSON:details[@"description"]];
        weakSelf.keywords = [CNCDetailModel yy_modelWithJSON:details[@"keywords"]];
        weakSelf.releaseNotes = [CNCDetailModel yy_modelWithJSON:details[@"releaseNotes"]];
        if (weakSelf.cnc_applicationDetailCallBack) {
            weakSelf.cnc_applicationDetailCallBack();
        }
    }];
}

- (NSString *)statusStr {
    if (ISEqualToString(_status, @"inReview")) {
        return @"正在审核";
    }else if (ISEqualToString(_status, @"waitingForReview")) {
        return @"等待审核";
    }else if (ISEqualToString(_status, @"prepareForUpload")) {
        return @"准备提交";
    }else if (ISEqualToString(_status, @"devRejected")) {
        return @"被开发人员拒绝";
    }else if (ISEqualToString(_status, @"rejected")) {
        return @"二进制文件被拒绝";
    }else if (ISEqualToString(_status, @"metadataRejected")) {
        return @"元数据被拒绝";
    }else if (ISEqualToString(_status, @"removedFromSale")) {
        return @"已下架";
    }else if (ISEqualToString(_status, @"readyForSale")) {
        return @"可供销售";
    }else if (ISEqualToString(_status, @"pendingDeveloperRelease")) {
        return @"等待开发人员发布";
    }else if (ISEqualToString(_status, @"pendingContract")) {
        return @"等待协议";
    }else if (ISEqualToString(_status, @"developerRemovedFromSale")) {
        return @"被开发人员下架";
    }
    return _status;
}

- (UIColor *)statusColor {
    if (ISEqualToString(_status, @"waitingForReview") ||
        ISEqualToString(_status, @"prepareForUpload")) {
        return UIColorHex(#FFD700);//金色
    }else if (ISEqualToString(_status, @"devRejected") ||
              ISEqualToString(_status, @"rejected") ||
              ISEqualToString(_status, @"metadataRejected") ||
              ISEqualToString(_status, @"removedFromSale")) {
        return UIColorHex(#DC143C);//深红(猩红)
    }else if (ISEqualToString(_status, @"inReview")) {
        return UIColorHex(#00BFFF);//深天蓝
    }else if (ISEqualToString(_status, @"pendingDeveloperRelease") ||
              ISEqualToString(_status, @"pendingContract")) {
        return UIColorHex(#00FFFF);//浅绿色(水色)
    }else if (ISEqualToString(_status, @"readyForSale")) {
        return UIColorHex(#00FF00);//闪光绿
    }else if (ISEqualToString(_status, @"developerRemovedFromSale")) {
        return UIColorHex(#FF99CC);
    }
    return [UIColor qmui_randomColor];
}

- (void)cnc_reloadData {
    [self cnc_requestApplicationDetailWithAppid:self.appid versionid:self.versionID];
}

- (NSArray<CNCDetailPlatformModel *> *)platforms {
    return [NSArray yy_modelArrayWithClass:[CNCDetailPlatformModel class] json:_platforms];
}

@end
