////  CNCResolutionCenterController.m
//  Connect
//
//  Created by Dwang on 2018/10/5.
//    QQ群:    577506623
//    GitHub:    https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCResolutionCenterMsgController.h"
#import "CNCResolutionCenterController.h"
#import "CNCResolutionCenterHeader.h"
#import "CNCResolutionCenterModel.h"
#import "CNCResolutionCenterView.h"
#import "CNCResolutionCenterCell.h"
#import "NSString+CNCExtension.h"
#import <MJRefresh.h>
#import <YYLabel.h>

@interface CNCResolutionCenterController ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) CNCResolutionCenterModel *model;

@property(nonatomic, strong) CNCResolutionCenterView *resolutionCenterView;

@end

@implementation CNCResolutionCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"反馈中心";
}

- (void)setUI {
    [self.view addSubview:self.resolutionCenterView];
}

- (void)setNetwork {
    [self.toastView showLoading];
    __weak __typeof(self)weakSelf = self;
    [self.model cnc_requestResolutionCenterWithAppid:self.appid];
    self.model.cnc_requestResolutionCenterCallBack = ^{
        [weakSelf.toastView hideAnimated:YES];
        [weakSelf.resolutionCenterView.mj_header endRefreshing];
        [weakSelf.resolutionCenterView reloadData];
    };
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.model.messages.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 78.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 15.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *identifier = @"sectionHeaderView";
    CNCResolutionCenterMsgModel *msgModel = self.model.messages[section];
    QMUITableViewHeaderFooterView *header = [[QMUITableViewHeaderFooterView alloc] initWithReuseIdentifier:identifier];
    header.titleLabel.textAlignment = NSTextAlignmentCenter;
    header.titleLabel.textColor = UIColorGrayDarken;
    header.titleLabel.text = msgModel.dateFormat;
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    CNCResolutionCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CNCResolutionCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    CNCResolutionCenterMsgModel *msgModel = self.model.messages[indexPath.section];
    cell.summary.text = msgModel.body.trimAllHtmlTag;
    cell.author.text = [NSString stringWithFormat:@":author:%@", msgModel.from];
//    if (@available(iOS 9.0, *)) {
//        if ([self respondsToSelector:@selector(traitCollection)]) {
//            if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
//                if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
//                    [self registerForPreviewingWithDelegate:(id)self sourceView:cell];
//                }
//            }
//        }
//    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    [self.navigationController pushViewController:[self cnc_getResolutionCenterMsgController:indexPath] animated:YES];
}

//- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location NS_AVAILABLE_IOS(9_0) {
//    NSIndexPath *indexPath = [self.resolutionCenterView indexPathForCell:(UITableViewCell *)[previewingContext sourceView]];
//    return [self cnc_getResolutionCenterMsgController:indexPath];
//}
//
//- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit NS_AVAILABLE_IOS(9_0) {
//    [self showViewController:viewControllerToCommit sender:self];
//}

- (CNCResolutionCenterMsgController *)cnc_getResolutionCenterMsgController:(NSIndexPath *)indexPath {
    CNCResolutionCenterMsgController *msg = [[CNCResolutionCenterMsgController alloc] init];
    CNCResolutionCenterMsgModel *msgModel = self.model.messages[indexPath.section];
    msg.htmlString = msgModel.body;
    msg.author = msgModel.from;
    [self.model.messages enumerateObjectsUsingBlock:^(CNCResolutionCenterMsgModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (ISEqualToString(obj.from, @"Apple")) {
            msg.reply = (msgModel == obj);
            *stop = YES;
        }
    }];
    return msg;
}

- (CNCResolutionCenterModel *)model {
    if (!_model) {
        _model = [[CNCResolutionCenterModel alloc] init];
    }
    return _model;
}

- (CNCResolutionCenterView *)resolutionCenterView {
    if (!_resolutionCenterView) {
        _resolutionCenterView = [[CNCResolutionCenterView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _resolutionCenterView.dataSource = self;
        _resolutionCenterView.delegate = self;
        _resolutionCenterView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 15.f)];
        __weak __typeof(self)weakSelf = self;
        _resolutionCenterView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf setNetwork];
        }];
    }
    return _resolutionCenterView;
}

@end

