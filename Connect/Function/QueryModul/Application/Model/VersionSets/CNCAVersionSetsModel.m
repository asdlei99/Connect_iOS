////  CNCAVersionSetsModel.m
//  Connect
//
//  Created by Dwang on 2018/9/26.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCAVersionSetsModel.h"
#import "CNCQueryOptionsModel.h"

@interface CNCAVersionSetsModel ()

/** 平台 */
@property(nonatomic, copy, readwrite) NSString *platformString;

/** 在审核的版本 */
@property(nonatomic, strong, readwrite) CNCAVSVersionModel *inFlightVersion;

/** 在销售的版本 */
@property(nonatomic, strong, readwrite) CNCAVSVersionModel *deliverableVersion;

/** 类型 */
@property(nonatomic, copy, readwrite) NSString *type;

/** 曾经是否销售过 */
@property(nonatomic, assign, readwrite) BOOL everBeenOnSale;

/** 可操作类型 */
@property(nonatomic, strong, readwrite) CNCQueryOptionsModel *optionsModel;

@end

@implementation CNCAVersionSetsModel

- (CNCQueryOptionsModel *)optionsModel {
    if (!_optionsModel) {
        NSMutableArray <CNCQueryOptionsModel *>*temp = [NSMutableArray array];
        _optionsModel = [[CNCQueryOptionsModel alloc] init];
        [temp addObject:[_optionsModel cnc_modelWithValues:@[@"查看详情"]]];
//        if (ISEqualToString(self.inFlightVersion.state, @"inReview") ||ISEqualToString(self.inFlightVersion.state, @"waitingForReview") ||ISEqualToString(self.inFlightVersion.state, @"prepareForUpload") ||ISEqualToString(self.inFlightVersion.state, @"devRejected") ||
//            ISEqualToString(self.inFlightVersion.state, @"removedFromSale") ||
//            ISEqualToString(self.inFlightVersion.state, @"pendingDeveloperRelease")) {
//        }
        if (ISEqualToString(self.inFlightVersion.state, @"rejected") ||ISEqualToString(self.inFlightVersion.state, @"metadataRejected") ||
            ISEqualToString(self.deliverableVersion.state, @"removedFromSale")||
            ISEqualToString(self.deliverableVersion.state, @"rejected") ||
            ISEqualToString(self.deliverableVersion.state, @"metadataRejected")) {
            [temp addObject:[_optionsModel cnc_modelWithValues:@[@"反馈中心"]]];
        }
        if (ISEqualToString(self.inFlightVersion.state, @"readyForSale") ||
            ISEqualToString(self.deliverableVersion.state, @"readyForSale")) {
            [temp addObject:[_optionsModel cnc_modelWithValues:@[@"AppStore"]]];
//            [temp addObject:[_optionsModel cnc_modelWithValues:@[@"蝉大师"]]];
        }
//        [temp addObject:[_optionsModel cnc_modelWithValues:@[@"全部选项"]]];
        [_optionsModel setValue:temp forKey:@"models"];
    }
    return _optionsModel;
}

@end
