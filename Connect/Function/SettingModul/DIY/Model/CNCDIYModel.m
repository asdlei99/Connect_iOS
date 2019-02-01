////  CNCDIYModel.m
//  Connect
//
//  Created by Dwang on 2018/10/18.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCDIYModel.h"

@interface CNCDIYModel ()

/** 模型数据 */
@property(nonatomic, copy, readwrite) NSArray<CNCDIYModel *> *models;

/** 标题 */
@property(nonatomic, copy, readwrite) NSString *title;

/** 开关状态 */
@property(nonatomic, assign, readwrite) BOOL status;

@end

@implementation CNCDIYModel

- (NSArray<CNCDIYModel *> *)models {
    if (!_models) {
        _models = @[
                    [self cnc_modelWithValues:@[@"使用启动动画", @(CNCUserDefaultsBoolForKey(kCloseLaunchScreenAnimation))]],
                    [self cnc_modelWithValues:@[@"使用TabBarItem点击动画", @(CNCUserDefaultsBoolForKey(kCloseTabBarItemAnimation))]],
                    [self cnc_modelWithValues:@[@"隐藏等待提交状态的应用", @(CNCUserDefaultsBoolForKey(kHiddenPrepareForUpload))]],
                    [self cnc_modelWithValues:@[@"账号添加完成后不再提示",@(CNCUserDefaultsBoolForKey(kCloseCreateAccountAlert))]],
                    [self cnc_modelWithValues:@[@"账号按照倒序排序",@(CNCUserDefaultsBoolForKey(kNewAccountSort))]],
                    [self cnc_modelWithValues:@[@"删除账号时不再提示", @(CNCUserDefaultsBoolForKey(kCloseDeleteAccountAlert))]],
                    [self cnc_modelWithValues:@[@"隐藏应用时不再提示", @(CNCUserDefaultsBoolForKey(kCloseHiddenApplicationAlert))]],
                    [self cnc_modelWithValues:@[@"最后查询的账号增加标记", @(CNCUserDefaultsBoolForKey(kOpenLastQueryAccountMark))]],
        ];
    }
    return _models;
}

- (CNCDIYModel *)cnc_modelWithValues:(NSArray *)values {
    NSArray *keys = @[@"title", @"status"];
    CNCDIYModel *model = [CNCDIYModel new];
    [values enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [model setValue:obj forKey:keys[idx]];
    }];
    return model;
}

@end
