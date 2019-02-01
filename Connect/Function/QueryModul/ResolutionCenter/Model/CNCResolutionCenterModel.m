////  CNCResolutionCenterModel.m
//  Connect
//
//  Created by Dwang on 2018/10/5.
//    QQ群:    577506623
//    GitHub:    https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCResolutionCenterModel.h"

@interface CNCResolutionCenterModel ()

/** 版本号 */
@property(nonatomic, copy, readwrite) NSString *version;

/** 版本号id */
@property(nonatomic, copy, readwrite) NSString *versionId;

/** 反馈id */
@property(nonatomic, copy, readwrite) NSString *backId;

/** 是否处于活动状态 */
@property(nonatomic, assign, readwrite) BOOL active;

/** 反馈信息 */
@property(nonatomic, strong, readwrite) NSArray<CNCResolutionCenterMsgModel *> *messages;;

@end

@implementation CNCResolutionCenterModel

- (void)cnc_requestResolutionCenterWithAppid:(NSString *)appid {
    __weak __typeof(self)weakSelf = self;
    [CNCNetwork getUrl:CNCiTunesConnectResolutionCenter(appid) callBack:^(id success) {
        if (ISEqualToString(success[@"statusCode"], @"SUCCESS") &&
            weakSelf.cnc_requestResolutionCenterCallBack) {
            NSDictionary *thread = success[@"data"][@"appNotes"][@"threads"][0];
            weakSelf.version = thread[@"version"];
            weakSelf.versionId = thread[@"versionId"];
            weakSelf.active = thread[@"active"];
            weakSelf.messages = [[NSArray yy_modelArrayWithClass:[CNCResolutionCenterMsgModel class] json:thread[@"messages"]] sortedArrayUsingComparator:^NSComparisonResult(CNCResolutionCenterMsgModel * _Nonnull obj1, CNCResolutionCenterMsgModel * _Nonnull obj2) {
                return [obj2.date compare:obj1.date];
            }];
            weakSelf.cnc_requestResolutionCenterCallBack();
        }
        
    }];
}

@end

