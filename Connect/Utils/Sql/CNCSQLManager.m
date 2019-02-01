////  CNCSQLManager.m
//  Connect
//
//  Created by Dwang on 2018/9/3.
//    QQ群:    577506623
//    GitHub:    https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCSQLManager.h"
#import "NSDate+CNCExtension.h"
#import <YTKKeyValueStore.h>
#import "CNCNotification.h"

@interface CNCSQLManager ()

/** 账号模型数组 */
@property(nonatomic, copy, readwrite) NSArray<CNCAccountModel *> *accountModels;

/** 被忽略的App模型数组 */
@property(nonatomic, copy, readwrite) NSArray<CNCIgnoreAppModel *> *ignoreAppModels;

/** 账号sql对象 */
@property(nonatomic, strong) YTKKeyValueStore *accountStore;

/** 隐藏App的sql对象 */
@property(nonatomic, strong) YTKKeyValueStore *ignoreAppStore;

@end

@implementation CNCSQLManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static CNCSQLManager *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedInstance];
}

- (void)rearrangeAccountModels {
   self.accountModels = [self.accountModels sortedArrayUsingComparator:^NSComparisonResult(CNCAccountModel *obj1, CNCAccountModel *obj2) {
        return (CNCUserDefaultsBoolForKey(kNewAccountSort)?[obj2.createTime compare:obj1.createTime]:[obj1.createTime compare:obj2.createTime]);
    }];
}

- (void)cnc_putToAccountSQLTableWithModel:(CNCAccountModel *)model {
    [model setValue:@"cookies" forKey:@"cookies"];
    [model setValue:[NSDate cnc_currentDateWithFormat:@"YYYY-MM-dd HH:mm:ss:ms"] forKey:@"createTime"];
    [self.accountStore putObject:model.yy_modelToJSONObject withId:model.email intoTable:kACCOUNTSQLTABLENAME];
    if (CNCUserDefaultsBoolForKey(kNewAccountSort)) {
        NSMutableArray *temp = [NSMutableArray arrayWithArray:self.accountModels];
        [temp insertObject:model atIndex:0];
        self.accountModels = [NSArray arrayWithArray:temp];
    }else {
        self.accountModels = [self.accountModels arrayByAddingObject:model];
    }
}

- (void)cnc_deleteForAccountSQLTableWithModel:(CNCAccountModel *)model {
    [self.accountStore deleteObjectById:model.email fromTable:kACCOUNTSQLTABLENAME];
    NSMutableArray<CNCAccountModel *> *arrM = [NSMutableArray arrayWithArray:self.accountModels];
    [arrM removeObject:model];
    self.accountModels = arrM;
    arrM = nil;
}

- (void)cnc_editForAccountSQLTableWithModel:(CNCAccountModel *)model {
    if (!model.createTime.isNotBlank || model.createTime.length < 20) {
        [model setValue:[NSDate cnc_currentDateWithFormat:@"YYYY-MM-dd HH:mm:ss:ms"] forKey:@"createTime"];
    }
    [self.accountStore putObject:model.yy_modelToJSONObject withId:model.email intoTable:kACCOUNTSQLTABLENAME];
    NSMutableArray <CNCAccountModel *>*temp = [NSMutableArray array];
    [self.accountModels enumerateObjectsUsingBlock:^(CNCAccountModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (ISEqualToString(obj.email, model.email)) {
            [temp addObject:model];
        }else {
            [temp addObject:obj];
        }
    }];
    self.accountModels = temp;
}

- (void)cnc_moveForAccountSQLTableWithFromModel:(CNCAccountModel *)fromModel toModel:(CNCAccountModel *)toModel {
    NSInteger from = [self.accountModels indexOfObject:fromModel];
    NSInteger to = [self.accountModels indexOfObject:toModel];
    NSMutableArray<NSString *> *createTimeArr = [NSMutableArray arrayWithArray:[CNCSQL.accountModels[to].createTime componentsSeparatedByString:@":"]];
    NSString *ms = createTimeArr.lastObject;
    if (from > to) {
        [createTimeArr replaceObjectAtIndex:createTimeArr.count-1 withObject:[NSString stringWithFormat:@"%ld", ms.integerValue-1]];
    }else {
        [createTimeArr replaceObjectAtIndex:createTimeArr.count-1 withObject:[NSString stringWithFormat:@"%ld", ms.integerValue+1]];
    }
    [fromModel setValue:[createTimeArr componentsJoinedByString:@":"] forKey:@"createTime"];
    [self.accountStore putObject:fromModel.yy_modelToJSONObject withId:fromModel.email intoTable:kACCOUNTSQLTABLENAME];
    NSMutableArray <CNCAccountModel *>*tempArr = [NSMutableArray arrayWithArray:self.accountModels];
    [tempArr removeObject:fromModel];
    [tempArr insertObject:fromModel atIndex:to];
    self.accountModels = tempArr;
    tempArr = nil;
}

- (void)cnc_putToIgnoreAppSQLTableWithModel:(CNCIgnoreAppModel *)model {
    [self.ignoreAppStore putObject:model.yy_modelToJSONObject withId:model.appid intoTable:kIGNOREAPPSQLTABLENAME];
    NSMutableArray<CNCIgnoreAppModel *> *arrM = [NSMutableArray arrayWithArray:self.ignoreAppModels];
    [arrM insertObject:model atIndex:0];
    self.ignoreAppModels = arrM;
    arrM = nil;
}

- (void)cnc_deleteForIgnoreAppSQLTableWithModel:(CNCIgnoreAppModel *)model {
    [self.ignoreAppStore deleteObjectById:model.appid fromTable:kIGNOREAPPSQLTABLENAME];
    NSMutableArray<CNCIgnoreAppModel *> *arrM = [NSMutableArray arrayWithArray:self.ignoreAppModels];
    [arrM removeObject:model];
    self.ignoreAppModels = arrM;
    arrM = nil;
}


- (NSArray<CNCAccountModel *> *)accountModels {
    if (!_accountModels) {
        NSMutableArray<CNCAccountModel *> *tempM = [NSMutableArray array];
        NSArray<YTKKeyValueItem *>*items = [self.accountStore getAllItemsFromTable:kACCOUNTSQLTABLENAME];
        [items enumerateObjectsUsingBlock:^(YTKKeyValueItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tempM addObject:[CNCAccountModel yy_modelWithJSON:obj.itemObject]];
        }];
        _accountModels = [tempM sortedArrayUsingComparator:^NSComparisonResult(CNCAccountModel *obj1, CNCAccountModel *obj2) {
            return (CNCUserDefaultsBoolForKey(kNewAccountSort)?[obj2.createTime compare:obj1.createTime]:[obj1.createTime compare:obj2.createTime]);
        }];
    }
    return _accountModels;
}

- (NSArray<CNCIgnoreAppModel *> *)ignoreAppModels {
    if (!_ignoreAppModels) {
        NSMutableArray<CNCIgnoreAppModel *> *tempM = [NSMutableArray array];
        NSArray<YTKKeyValueItem *>*items = [self.ignoreAppStore getAllItemsFromTable:kIGNOREAPPSQLTABLENAME];
        [items enumerateObjectsUsingBlock:^(YTKKeyValueItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [tempM insertObject:[CNCIgnoreAppModel yy_modelWithJSON:obj.itemObject] atIndex:0];
        }];
        _ignoreAppModels = [NSArray arrayWithArray:tempM];
    }
    return _ignoreAppModels;
}

- (YTKKeyValueStore *)accountStore {
    if (!_accountStore) {
        _accountStore = [[YTKKeyValueStore alloc] initDBWithName:kACCOUNTSQLDBNAME];
        [_accountStore createTableWithName:kACCOUNTSQLTABLENAME];
    }
    return _accountStore;
}

- (YTKKeyValueStore *)ignoreAppStore {
    if (!_ignoreAppStore) {
        _ignoreAppStore = [[YTKKeyValueStore alloc] initDBWithName:kIGNOREAPPSQLDBNAME];
        [_ignoreAppStore createTableWithName:kIGNOREAPPSQLTABLENAME];
    }
    return _ignoreAppStore;
}

@end


