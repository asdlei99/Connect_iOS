////  CNCIgnoreAppsController.m
//  Connect
//
//  Created by Dwang on 2018/9/3.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCIgnoreAppsController.h"
#import "CNCIgnoreAppsView.h"
#import "CNCIgnoreAppsCell.h"
#import "CNCSQLManager.h"

@interface CNCIgnoreAppsController ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) CNCIgnoreAppsView *ignoreAppsView;

@end

@implementation CNCIgnoreAppsController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"隐藏的应用程序";
}

- (void)setUI {
    [self.view addSubview:self.ignoreAppsView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return CNCSQL.ignoreAppModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    CNCIgnoreAppsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CNCIgnoreAppsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    CNCIgnoreAppModel *model = CNCSQL.ignoreAppModels[indexPath.section];
    cell.appIcon.image = [UIImage imageWithData:[NSData dataWithBase64EncodedString:model.appIcon]];
    cell.appName.text = model.appName;
    cell.createTime.text = model.creatTime;
    cell.account.text = model.account;
    return cell;
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak __typeof(self)weakSelf = self;
    UITableViewRowAction *delete = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [CNCSQL cnc_deleteForIgnoreAppSQLTableWithModel:CNCSQL.ignoreAppModels[indexPath.section]];
        [tableView deleteSection:indexPath.section withRowAnimation:UITableViewRowAnimationMiddle];
        if (!CNCSQL.ignoreAppModels.count) {
            [weakSelf.toastView showWithText:@"应用已被全部清除" hideAfterDelay:1.25];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }
    }];
    return @[delete];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
}

- (CNCIgnoreAppsView *)ignoreAppsView {
    if (!_ignoreAppsView) {
        _ignoreAppsView = [[CNCIgnoreAppsView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _ignoreAppsView.dataSource = self;
        _ignoreAppsView.delegate = self;
        _ignoreAppsView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
    return _ignoreAppsView;
}

@end
