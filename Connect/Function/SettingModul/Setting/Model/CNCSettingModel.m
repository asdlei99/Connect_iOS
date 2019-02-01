////  CNCSettingModel.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCSettingModel.h"
#import <DWNetworking.h>

@interface CNCSettingModel ()

@property(nonatomic, copy, readwrite) NSArray<NSArray <CNCSettingModel *> *> *models;

@property(nonatomic, copy, readwrite) NSString *title;

@property(nonatomic, copy, readwrite) NSString *detail;

@end

@implementation CNCSettingModel

- (NSArray<NSArray<CNCSettingModel *> *> *)models {
    if (!_models) {
        _models = @[
                    @[
                        [self cnc_modelWithValues:@[@"自定义设置", @""]],
                        ],
                    @[
                        [self cnc_modelWithValues:@[@"清除缓存", [self cnc_getCacheSize]]],
                        ],
                    @[
                        [self cnc_modelWithValues:@[@"查看隐藏"]],
                        ],
                    @[
                        [self cnc_modelWithValues:@[@"打赏支持", @"¥ 10"]]
                        ],
                    @[
                        [self cnc_modelWithValues:@[@"加入QQ群"]]
                        ],
                    @[
                        [self cnc_modelWithValues:@[@"用户反馈"]],
                        ],
                    ];
    }
    return _models;
}

- (void)cnc_clearCacheWithCallBack:(void(^)(void))callBack {
    [DWNetworking cleanAllCache];
    [self.models[1][0] setValue:[self cnc_getCacheSize] forKey:@"detail"];
    if(callBack) {
        callBack();
    }
}

- (NSString *)cnc_getCacheSize {
    NSString *cacheSize = @"";
    CGFloat size = [DWNetworking getCachesSize]-36;
    if (size >= 1024*1024) {
        cacheSize = [NSString stringWithFormat:@"%.fGB", size/(1024*1024)];
    }else if (size > 1024) {
        cacheSize = [NSString stringWithFormat:@"%.fMB", size/1024];
    }else if (size <= 0){
        cacheSize = @"暂无缓存";
    }else {
        cacheSize = [NSString stringWithFormat:@"%.fKB", size];
    }
    return cacheSize;
}

- (CNCSettingModel *)cnc_modelWithValues:(NSArray <NSString *> *)values {
    NSArray <NSString *> *keys = @[@"title", @"detail"];
    CNCSettingModel *model = [CNCSettingModel new];
    [values enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [model setValue:obj forKey:keys[idx]];
    }];
    return model;
}

@end
