////  CNCAppDetailController.m
//  Connect
//
//  Created by Dwang on 2018/9/21.
//    QQ群:    577506623
//    GitHub:    https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCAppDetailController.h"
#import "CNCAppDetailHeaderView.h"
#import "CNCAppDetailModel.h"
#import "CNCAppDetailView.h"
#import "CNCDetailModel.h"
#import "NSString+CNCExtension.h"
#import <MJRefresh.h>
#import "CNCReleaseNotesCell.h"
#import "CNCKeywordsCell.h"
#import "CNCScreenshotsCell.h"
#import "CNCLanguageModel.h"

@interface CNCAppDetailController ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) CNCAppDetailModel *model;

@property(nonatomic, strong) CNCAppDetailView *detailView;

@property(nonatomic, strong) CNCAppDetailHeaderView *headerView;

@property(nonatomic, copy) NSArray<NSString *> *sectionTitles;

@property(nonatomic, strong) QMUIPopupMenuView *popView;

@end

@implementation CNCAppDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"详情";
}

- (void)setUI {
    [self.view addSubview:self.detailView];
}

- (void)setNetwork {
    [self showEmptyViewWithLoading];
    __weak __typeof(self)weakSelf = self;
    [self.model cnc_requestApplicationDetailWithAppid:self.appid];
    self.model.cnc_applicationDetailCallBack = ^{
        weakSelf.sectionTitles = [NSArray array];
        if (weakSelf.detailView.isHidden) {
            [weakSelf hideEmptyView];
            weakSelf.detailView.hidden = NO;
        }else {
            [weakSelf.toastView hideAnimated:YES];
            [weakSelf.detailView.mj_header endRefreshing];
        }
        if (weakSelf.model.releaseNotes.value) {
            weakSelf.sectionTitles = [weakSelf.sectionTitles arrayByAddingObject:@"ReleaseNotes"];
        }
        if (weakSelf.model.keywords.value) {
            weakSelf.sectionTitles = [weakSelf.sectionTitles arrayByAddingObject:@"Keywords"];
        }
        if (weakSelf.model.screenshots.count && weakSelf.model.screenshotNames.count) {
            weakSelf.sectionTitles = [weakSelf.sectionTitles arrayByAddingObject:@"Screenshots"];
        }
        [weakSelf.detailView reloadData];
        weakSelf.headerView.icon.placeholder = weakSelf.model.iconUrl;
        weakSelf.headerView.appName.text = weakSelf.model.appName;
        weakSelf.headerView.status.backgroundColor = weakSelf.model.statusColor;
        weakSelf.headerView.version.text = [NSString stringWithFormat:@"%@  %@", weakSelf.model.version.value, weakSelf.model.statusStr];
        if (weakSelf.model.desc.value) {
            [weakSelf.headerView.desc setTitle:[weakSelf.model.desc.value stringByReplacingOccurrencesOfString:@"\n" withString:@""] forState:UIControlStateNormal];
            [weakSelf.headerView.desc addTarget:weakSelf action:@selector(cnc_getMoreDes) forControlEvents:UIControlEventTouchUpInside];
        }else {
            weakSelf.headerView.height = 80;
        }
        weakSelf.navigationItem.rightBarButtonItem = [UIBarButtonItem qmui_itemWithTitle:weakSelf.model.language target:weakSelf action:@selector(cnc_changeCountry)];
    };
}

- (void)cnc_changeCountry {
//    if (self.popView.isShowing) {
//        [self.popView hideWithAnimated:YES];
//    } else {
//        [self.popView layoutWithTargetView:self.navigationItem.rightBarButtonItem.qmui_view];
//        [self.popView showWithAnimated:YES];
//    }
}

- (void)cnc_getMoreDes {
    QMUIDialogViewController *dialog = [[QMUIDialogViewController alloc] init];
    dialog.title = @"介绍";
    QMUILabel *des = [[QMUILabel alloc] init];
    des.numberOfLines = 0;
    des.font = UIFontMake(14);
    des.contentEdgeInsets = UIEdgeInsetsMake(10, 15, 20, 15);
    des.text = self.model.desc.value;
    dialog.contentView = des;
    __weak __typeof(self)weakSelf = self;
    [dialog addCancelButtonWithText:@"取消" block:nil];
    [dialog addSubmitButtonWithText:@"复制" block:^(__kindof QMUIDialogViewController *aDialogViewController) {
        [UIPasteboard generalPasteboard].string = weakSelf.model.desc.value;
        [aDialogViewController hide];
        [weakSelf.toastView showWithText:@"您已成功将应用介绍复制到粘贴板" hideAfterDelay:2.25];
    }];
    [dialog show];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] init];
    QMUILabel *msg = [[QMUILabel alloc] init];
    msg.textColor = UIColorGray;
    [header addSubview:msg];
    [msg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(header.mas_centerX);
        make.bottom.equalTo(header.mas_bottom);
    }];
    msg.text = self.sectionTitles[section];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.sectionTitles[indexPath.section] isEqualToString:@"ReleaseNotes"] &&
        self.model.releaseNotes.value.isNotBlank) {
        static NSString *identifier = @"releaseNotes";
        CNCReleaseNotesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[CNCReleaseNotesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.releaseNotes.text = self.model.releaseNotes.value;
        return cell;
    }
    if ([self.sectionTitles[indexPath.section] isEqualToString:@"Keywords"] &&
        self.model.keywords.value.isNotBlank) {
        static NSString *identifier = @"keywords";
        CNCKeywordsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[CNCKeywordsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.keywords.text = self.model.keywords.value;
        return cell;
    }
    if ([self.sectionTitles[indexPath.section] isEqualToString:@"Screenshots"] &&
        self.model.screenshots.count) {
        static NSString *identifier = @"screenshots";
        CNCScreenshotsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[CNCScreenshotsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.titles = self.model.screenshotNames;
        cell.imgUrls = self.model.screenshots;
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
}

- (CNCAppDetailModel *)model {
    if (!_model) {
        _model = [[CNCAppDetailModel alloc] init];
    }
    return _model;
}

- (CNCAppDetailView *)detailView {
    if (!_detailView) {
        _detailView = [[CNCAppDetailView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _detailView.dataSource = self;
        _detailView.delegate = self;
        _detailView.tableHeaderView = self.headerView;
        _detailView.tableFooterView = [[UIView alloc] qmui_initWithSize:CGSizeMake(SCREEN_WIDTH, 25)];
        __weak __typeof(self)weakSelf = self;
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf.toastView showLoading];
            [weakSelf.model cnc_reloadData];
        }];
        [header setTitle:@"数据来源于Apple" forState:MJRefreshStateWillRefresh];
        [header setTitle:@"数据来源于Apple" forState:MJRefreshStateIdle];
        _detailView.mj_header = header;
        _detailView.hidden = YES;
    }
    return _detailView;
}

- (CNCAppDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[CNCAppDetailHeaderView alloc] qmui_initWithSize:CGSizeMake(SCREEN_WIDTH, 150)];
    }
    return _headerView;
}

- (QMUIPopupMenuView *)popView {
    if (!_popView) {
        _popView = [[QMUIPopupMenuView alloc] init];
        _popView.automaticallyHidesWhenUserTap = YES;// 点击空白地方消失浮层
        _popView.maximumWidth = 180;
        _popView.shouldShowItemSeparator = YES;
        _popView.items = @[[QMUIPopupMenuButtonItem itemWithImage:UIImageMake(@"") title:@"123" handler:NULL]];
    }
    return _popView;
}

@end

