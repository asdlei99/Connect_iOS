////  CNCApplicationModel.m
//  Connect
//
//  Created by Dwang on 2018/9/11.
//    QQ群:    577506623
//    GitHub:    https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCApplicationModel.h"
#import "CNCAccountModel.h"
#import "CNCNotification.h"
#import "CNCSQLManager.h"

@interface CNCCookieModel : NSObject

/** 版本 */
@property(nonatomic, copy) NSString *version;

/** 名称 */
@property(nonatomic, copy) NSString *name;

/** 数据 */
@property(nonatomic, copy) NSString *value;

/** 日期 */
@property(nonatomic, copy) NSString *expiresDate;

/** domain */
@property(nonatomic, copy) NSString *domain;

/** 路径 */
@property(nonatomic, copy) NSString *path;

/** 是否安全 */
@property(nonatomic, copy) NSString *isSecure;

@end

@interface CNCApplicationModel ()

/** 数据模型 */
@property(nonatomic, copy, readwrite) NSArray<CNCApplicationModel *> *models;

/** id */
@property(nonatomic, copy, readwrite) NSString *adamId;

/** 名称 */
@property(nonatomic, copy, readwrite) NSString *name;

/** SKU */
@property(nonatomic, copy, readwrite) NSString *vendorId;

/** bundleId */
@property(nonatomic, copy, readwrite) NSString *bundleId;

/** logo */
@property(nonatomic, copy, readwrite) NSString *iconUrl;

/** 预订截止日期 */
@property(nonatomic, copy, readwrite) NSString *preOrderEndDate;

/** 最后操作时间 */
@property(nonatomic, copy, readwrite) NSString *lastModifiedDate;

/** 最后修改时间格式化时间 */
@property(nonatomic, copy, readwrite) NSString *lastModifiedFormatDate;

/** 最后修改时间至今时间差 */
@property(nonatomic, copy, readwrite) NSString *lastModifiedFifferenceDate;

/** 问题数量 */
@property(nonatomic, copy, readwrite) NSString *issuesCount;

/** 版本状态 */
@property(nonatomic, strong, readwrite) NSArray<CNCAVersionSetsModel *> *versionSets;



/** 暂存账号模型 */
@property(nonatomic, strong) CNCAccountModel *accountModel;

/** 暂存index */
@property(nonatomic, assign) NSInteger index;

@end

@implementation CNCApplicationModel

- (void)cnc_getApplicationStatusWithAccountModel:(CNCAccountModel *)model index:(NSInteger)index {
    self.accountModel = model;
    self.index = index;
    [CNCNotification cnc_addObserver:self selector:@selector(cnc_reloadNetwork) name:kREQUESTQUERYAPPLICATIONERRORCALLBACK];
    __weak __typeof(self)weakSelf = self;
    if (model.cookies.isNotBlank && !ISEqualToString(model.cookies, @"cookies")) {
        NSArray<NSString *> *cookies = [model.cookies componentsSeparatedByString:kCookiesSegmentationRegular];
        NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        [cookies enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CNCCookieModel *cookieModel = [CNCCookieModel yy_modelWithJSON:[weakSelf cnc_cookieString:obj]];
            NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:
                                    [NSDictionary dictionaryWithObjectsAndKeys:
                                     cookieModel.name,NSHTTPCookieName,
                                     cookieModel.value,NSHTTPCookieValue,
                                     cookieModel.version,NSHTTPCookieVersion,
                                     cookieModel.domain,NSHTTPCookieDomain,
                                     cookieModel.path,NSHTTPCookiePath,
                                     cookieModel.isSecure,NSHTTPCookieSecure,
                                     cookieModel.expiresDate,NSHTTPCookieExpires,nil]];
            [cookieStorage setCookie:cookie];
        }];
        [self cnc_getAppleApplicationStatus];
    }else {
        [CNCNetwork cnc_setAppleDevSiginHeader];
        [CNCNetwork postUrl:appleDevSiginUrlHost params:@{@"accountName":model.email,
                                                          @"password":model.developer_password,
                                                          @"rememberMe":@"true"}
                   callBack:^(id success) {
                       if (ISEqualToString(success[@"authType"], @"sa")) {
                           CNCAccountModel *accountModel = [[CNCAccountModel alloc] init];
                           [accountModel setValue:model.email forKey:@"email"];
                           [accountModel setValue:model.developer_password forKey:@"developer_password"];
                           [accountModel setValue:model.email_password forKey:@"email_password"];
                           [accountModel setValue:model.mark forKey:@"mark"];
                           [accountModel setValue:model.createTime forKey:@"createTime"];
                           [accountModel setValue:[[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies] componentsJoinedByString:kCookiesSegmentationRegular] forKey:@"cookies"];
                           [CNCSQL cnc_editForAccountSQLTableWithModel:accountModel];
                           [CNCNotification cnc_postNotificationName:kACCOUNTDATACHANGE object:@(index)];
                           [weakSelf cnc_getAppleApplicationStatus];
                       }else {
                           [CNCNotification cnc_postNotificationName:kREQUESTERROR object:[NSString stringWithFormat:@"登录失败\n%@", success]];
                       }
                   }];
    }
}

- (void)cnc_getAppleApplicationStatus {
    __weak __typeof(self)weakSelf = self;
    [CNCNetwork cnc_setQueryApplicationStatusHeaderHeader];
    [CNCNetwork getUrl:appleApplicationStatusUrlHost callBack:^(id success) {
        if (ISEqualToString(success[@"statusCode"], @"SUCCESS")) {
            weakSelf.models = nil;
            NSMutableArray <CNCApplicationModel *>*tempM = [NSMutableArray array];
            weakSelf.models = [NSArray yy_modelArrayWithClass:[CNCApplicationModel class] json:success[@"data"][@"summaries"]];
            [weakSelf.models enumerateObjectsUsingBlock:^(CNCApplicationModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CNCApplicationModel *tempAModel = obj;
                __block BOOL result = YES;
                [CNCSQL.ignoreAppModels enumerateObjectsUsingBlock:^(CNCIgnoreAppModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (ISEqualToString(tempAModel.adamId, obj.appid)) {
                        result = NO;
                        *stop = YES;
                    }
                }];
                if (CNCUserDefaultsBoolForKey(kHiddenPrepareForUpload) && result) {
                    result = (ISEqualToString(tempAModel.versionSets[0].inFlightVersion.state, @"prepareForUpload")?NO:ISEqualToString(tempAModel.versionSets[0].deliverableVersion.state, @"prepareForUpload")?NO:YES);
                }
                if (result) {
                    [tempM addObject:tempAModel];
                }
            }];
            weakSelf.models = tempM;
            if (weakSelf.cnc_queryApplicationStatusCallBack) {
                weakSelf.models = [weakSelf.models sortedArrayUsingComparator:^NSComparisonResult(CNCApplicationModel *obj1, CNCApplicationModel *obj2) {
                    return [obj2.lastModifiedDate compare:obj1.lastModifiedDate];
                }];
                weakSelf.cnc_queryApplicationStatusCallBack();
            }
        }else {
            [CNCNotification cnc_postNotificationName:kREQUESTERROR object:[NSString stringWithFormat:@"查询失败\n%@", success]];
        }
    }];
}

- (void)cnc_reloadNetwork {
    [self.accountModel setValue:@"cookies" forKey:@"cookies"];
    [self cnc_getApplicationStatusWithAccountModel:self.accountModel index:self.index];
}

- (NSString *)lastModifiedFormatDate {
    NSTimeInterval interval = [_lastModifiedDate doubleValue]/1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    return [formatter stringFromDate:date];
}

- (NSString *)lastModifiedFifferenceDate {
    NSTimeInterval interval = [_lastModifiedDate doubleValue]/1000.0;
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    NSDate *creat = [NSDate dateWithTimeIntervalSince1970:interval];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *compas = [calendar components:unit fromDate:creat toDate:nowDate options:0];
    if (compas.year) {
        return [NSString stringWithFormat:@"%ld years ago", (long)compas.year];
    }else if (compas.month) {
        return [NSString stringWithFormat:@"%ld months ago", (long)compas.month];
    }else if (compas.day) {
        return [NSString stringWithFormat:@"%ld days ago", (long)compas.day];
    }else if (compas.hour) {
        return [NSString stringWithFormat:@"%ld hours ago", (long)compas.hour];
    }else if (compas.minute) {
        return [NSString stringWithFormat:@"%ld minutes ago", (long)compas.minute];
    }
    return @"刚刚";
}

- (NSDictionary *)cnc_cookieString:(NSString *)cookieString {
    NSMutableDictionary *cookies = [NSMutableDictionary dictionary];
    cookieString = [cookieString stringByReplacingOccurrencesOfString:@"<NSHTTPCookie" withString:@""];
    NSMutableArray <NSString *>*coks = [NSMutableArray arrayWithArray:[cookieString componentsSeparatedByString:@"\n"]];
    [coks removeLastObject];
    [coks enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray <NSString *>*kvs = [obj componentsSeparatedByString:@":"];
        if (kvs.count > 1) {
            [cookies setObject:kvs[1] forKey:[kvs[0] qmui_trimAllWhiteSpace]];
        }
    }];
    return cookies;
}

- (NSArray<CNCAVersionSetsModel *> *)versionSets {
    return [NSArray yy_modelArrayWithClass:[CNCAVersionSetsModel class] json:_versionSets];
}

- (NSArray<CNCApplicationModel *> *)models {
    if (!_models) {
        _models = [NSArray array];
    }
    return _models;
}

- (void)dealloc
{
    [CNCNotification cnc_removeObserver:self name:kREQUESTQUERYAPPLICATIONERRORCALLBACK];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage].cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:obj];
    }];
}

@end

@implementation CNCCookieModel

@end

