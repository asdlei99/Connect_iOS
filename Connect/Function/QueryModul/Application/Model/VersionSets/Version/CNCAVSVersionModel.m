////  CNCAVSVersionModel.m
//  Connect
//
//  Created by Dwang on 2018/9/26.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCAVSVersionModel.h"

@interface CNCAVSVersionModel ()

/** 类型 */
@property(nonatomic, copy, readwrite) NSString *type;

/** 版本 */
@property(nonatomic, copy, readwrite) NSString *version;

/** 状态 */
@property(nonatomic, copy, readwrite) NSString *state;

/** 状态key */
@property(nonatomic, copy, readwrite) NSString *stateKey;

/** 状态分组 */
@property(nonatomic, copy, readwrite) NSString *stateGroup;

/** 状态颜色 */
@property(nonatomic, strong, readwrite) UIColor *stateColor;

/** 状态中文 */
@property(nonatomic, copy, readwrite) NSString *stateStr;

@end

@implementation CNCAVSVersionModel

- (NSString *)stateStr {
    if (ISEqualToString(_state, @"inReview")) {
        return @"正在审核";
    }else if (ISEqualToString(_state, @"waitingForReview")) {
        return @"等待审核";
    }else if (ISEqualToString(_state, @"prepareForUpload")) {
        return @"准备提交";
    }else if (ISEqualToString(_state, @"devRejected")) {
        return @"被开发人员拒绝";
    }else if (ISEqualToString(_state, @"rejected")) {
        return @"二进制文件被拒绝";
    }else if (ISEqualToString(_state, @"metadataRejected")) {
        return @"元数据被拒绝";
    }else if (ISEqualToString(_state, @"removedFromSale")) {
        return @"已下架";
    }else if (ISEqualToString(_state, @"readyForSale")) {
        return @"可供销售";
    }else if (ISEqualToString(_state, @"pendingDeveloperRelease")) {
        return @"等待开发人员发布";
    }else if (ISEqualToString(_state, @"pendingContract")) {
        return @"等待协议";
    }else if (ISEqualToString(_state, @"developerRemovedFromSale")) {
        return @"被开发人员下架";
    }
    return _state;
}

- (UIColor *)stateColor {
    if (ISEqualToString(_state, @"waitingForReview") ||
        ISEqualToString(_state, @"prepareForUpload")) {
        return UIColorHex(#FFD700);//金色
    }else if (ISEqualToString(_state, @"devRejected") ||
              ISEqualToString(_state, @"rejected") ||
              ISEqualToString(_state, @"metadataRejected") ||
              ISEqualToString(_state, @"removedFromSale")) {
        return UIColorHex(#DC143C);//深红(猩红)
    }else if (ISEqualToString(_state, @"inReview")) {
        return UIColorHex(#00BFFF);//深天蓝
    }else if (ISEqualToString(_state, @"pendingDeveloperRelease") ||
              ISEqualToString(_state, @"pendingContract")) {
        return UIColorHex(#00FFFF);//浅绿色(水色)
    }else if (ISEqualToString(_state, @"readyForSale")) {
        return UIColorHex(#00FF00);//闪光绿
    }else if (ISEqualToString(_state, @"developerRemovedFromSale")) {
        return UIColorHex(#FF99CC);
    }
    return [UIColor qmui_randomColor];
}

@end
