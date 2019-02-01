////  CNCApplicationController.m
//  Connect
//
//  Created by Dwang on 2018/9/11.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCQueryOptionsController.h"
#import "CNCApplicationController.h"
#import "CNCCollectionNormalLayout.h"
#import "CNCApplicationModel.h"
#import "NSDate+CNCExtension.h"
#import "CNCApplicationsCell.h"
#import "CNCApplicationView.h"
#import "CNCAnimationLabel.h"
#import "CNCSQLManager.h"
#import <MJRefresh.h>

@interface CNCApplicationController ()<UICollectionViewDelegate, UICollectionViewDataSource, QMUINavigationTitleViewDelegate>

@property(nonatomic, strong) CNCApplicationView *applicationView;

@property(nonatomic, strong) CNCApplicationModel *model;

@property(nonatomic, strong) QMUIPopupContainerView *popupContainerView;

@end

static NSString *const kIdentifier = @"cell";
@implementation CNCApplicationController

- (void)initSubviews {
    [super initSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"应用程序";
    self.titleView.delegate = self;
//    self.titleView.userInteractionEnabled = YES;
    self.titleView.subtitle = self.accountModel.email;
    self.titleView.verticalTitleFont = UIFontMake(18);
    self.titleView.verticalSubtitleFont = UIFontMake(12);
    self.titleView.style = QMUINavigationTitleViewStyleSubTitleVertical;
//    self.titleView.accessoryType = QMUINavigationTitleViewAccessoryTypeDisclosureIndicator;
}

- (void)setUI {
    [self.view addSubview:self.applicationView];
    __weak __typeof(self)weakSelf = self;
    self.applicationView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf setNetwork];
    }];
}

- (void)setNetwork {
    __weak __typeof(self)weakSelf = self;
    [self.model cnc_getApplicationStatusWithAccountModel:self.accountModel index:self.index];
    self.model.cnc_queryApplicationStatusCallBack = ^{
        weakSelf.loading = YES;
        [weakSelf.applicationView reloadData];
        [weakSelf.applicationView.mj_header endRefreshing];
        if (!ISEqualToString(weakSelf.accountModel.email, CNCUserDefaultsObjectForKey(kLastQueryAccount))) {
            CNCUserDefaultsWithObjectForKey(weakSelf.accountModel.email, kLastQueryAccount);
            if (weakSelf.cnc_reloadLastQueryCell) {
                weakSelf.cnc_reloadLastQueryCell(weakSelf.lastQueryIndex);
            }
        }
    };
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.isLoading?self.model.models.count:30;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CNCApplicationsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentifier forIndexPath:indexPath];
    if (self.isLoading) {
        CNCApplicationModel *model = self.model.models[indexPath.section];
        cell.appVerison2Activity.backgroundColor = UIColorClear;
        cell.appVersion2.text = nil;
        cell.ignore.tag = indexPath.section;
        cell.appIcon.activity = model.iconUrl;
        cell.appName.text = model.name;
        [cell.lastTime setTitle:model.lastModifiedFifferenceDate forState:UIControlStateNormal];
        cell.lastTime.tag = indexPath.section;
        cell.apv1.enabled = NO;
        cell.apv2.enabled = NO;
        [cell.lastTime addTarget:self action:@selector(cnc_lastTimeDidClick:) forControlEvents:UIControlEventTouchUpInside];
        CNCAVersionSetsModel *setsModel = model.versionSets[0];
        if (setsModel.deliverableVersion.state.length) {
            cell.appVerison1Activity.backgroundColor = setsModel.deliverableVersion.stateColor;
            cell.appVersion1.text = setsModel.deliverableVersion.version;
            if (setsModel.inFlightVersion.state.length) {
                cell.appVerison2Activity.backgroundColor = setsModel.inFlightVersion.stateColor;
                cell.appVersion2.text = [NSString stringWithFormat:@"%@  %@", setsModel.inFlightVersion.version, setsModel.inFlightVersion.stateStr];
                //            [cell.apv2 addTarget:self action:@selector(cnc_apv2DidClick:) forControlEvents:UIControlEventTouchUpInside];
            }else {
                cell.appVersion1.text = [NSString stringWithFormat:@"%@  %@", setsModel.deliverableVersion.version, setsModel.deliverableVersion.stateStr];
            }
        }else {
            cell.appVerison1Activity.backgroundColor = setsModel.inFlightVersion.stateColor;
            cell.appVersion1.text = [NSString stringWithFormat:@"%@  %@", setsModel.inFlightVersion.version, setsModel.inFlightVersion.stateStr];
        }
        cell.apv1.tag = indexPath.section;
        cell.apv2.tag = indexPath.section;
        //    [cell.apv1 addTarget:self action:@selector(cnc_apv1DidClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.ignore addTarget:self action:@selector(cnc_ignoreDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    ((CNCApplicationsCell *)cell).shouldLoading = self.isLoading;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView qmui_clearsSelection];
    [self.navigationController pushViewController:[[CNCQueryOptionsController alloc] initWithApplicationModel:self.model.models[indexPath.section]] animated:YES];
}

- (void)cnc_lastTimeDidClick:(QMUIButton *)sender {
    CNCApplicationModel *model = self.model.models[sender.tag];
//    self.popupContainerView.textLabel.text = model.lastModifiedFormatDate;
    if (ISEqualToString(sender.currentTitle, model.lastModifiedFormatDate)) {
        [sender setTitle:model.lastModifiedFifferenceDate forState:UIControlStateNormal];
    }else {
        [sender setTitle:model.lastModifiedFormatDate forState:UIControlStateNormal];
    }
//    [self.popupContainerView layoutWithTargetView:sender];
//    [self.popupContainerView showWithAnimated:YES];
}

- (void)cnc_apv1DidClick:(QMUIButton *)sender {
    CNCApplicationModel *model = self.model.models[sender.tag];
    NSString *deliverableState = model.versionSets[0].deliverableVersion.state;
    if (deliverableState.length) {
        NSString *message = @"";
        if (ISEqualToString(deliverableState, @"inReview") ||
            ISEqualToString(deliverableState, @"waitingForReview") ||
            ISEqualToString(deliverableState, @"readyForSale") ||
            ISEqualToString(deliverableState, @"pendingDeveloperRelease")) {
            message = [NSString stringWithFormat:@"版本号:%@\n当前状态:%@",
                       model.versionSets[0].deliverableVersion.version,
                       model.versionSets[0].deliverableVersion.stateStr];
        }else {
            message = [NSString stringWithFormat:@"版本号:%@\n问题数:%@\n当前状态:%@",
                       model.versionSets[0].deliverableVersion.version,
                       model.issuesCount,
                       model.versionSets[0].deliverableVersion.stateStr];
        }
        self.popupContainerView.textLabel.text = [NSString stringWithFormat:@"%@\n最后修改时间:%@", message, model.lastModifiedFormatDate];
        [self.popupContainerView layoutWithTargetView:sender];
        [self.popupContainerView showWithAnimated:YES];
    }else{
        [self cnc_apv2DidClick:sender];
    }
}

- (void)cnc_apv2DidClick:(QMUIButton *)sender {
    CNCApplicationModel *model = self.model.models[sender.tag];
    if (model.versionSets[0].inFlightVersion.state.isNotBlank) {
        NSString *message = @"";
        if (!model.issuesCount.qmui_trimAllWhiteSpace.intValue) {
            message = [NSString stringWithFormat:@"版本号:%@\n当前状态:%@",
            model.versionSets[0].inFlightVersion.version,
            model.versionSets[0].inFlightVersion.stateStr];
        }else {
            message = [NSString stringWithFormat:@"版本号:%@\n问题数:%@\n当前状态:%@",
                       model.versionSets[0].inFlightVersion.version,
                       model.issuesCount,
                       model.versionSets[0].inFlightVersion.stateStr];
        }
        self.popupContainerView.textLabel.text = [NSString stringWithFormat:@"%@\n最后修改时间:%@", message, model.lastModifiedFormatDate];
        [self.popupContainerView layoutWithTargetView:sender];
        [self.popupContainerView showWithAnimated:YES];
    }else {
        [self collectionView:self.applicationView didSelectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:sender.tag]];
    }
}

- (void)cnc_ignoreDidClick:(QMUIButton *)sender {
    if (CNCUserDefaultsBoolForKey(kCloseHiddenApplicationAlert)) {
        [self cnc_hiddenApplicationWithIndex:sender.tag];
    }else {
        QMUIAlertController *alert = [QMUIAlertController alertControllerWithTitle:@"您是否要隐藏此App" message:@"当您选择隐藏后,下次查询时此App将不会出现在您的App列表中,但是您可以通过设置中的选项来使被隐藏的App再次显示." preferredStyle:QMUIAlertControllerStyleAlert];
        __weak __typeof(self)weakSelf = self;
        [alert addAction:[QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController *aAlertController, QMUIAlertAction *action)
                          {
                              [weakSelf cnc_hiddenApplicationWithIndex:sender.tag];
                          }]];
        [alert addCancelAction];
        [alert showWithAnimated:YES];
    }
}

- (void)cnc_hiddenApplicationWithIndex:(NSInteger)index {
    CNCApplicationsCell *cell = (CNCApplicationsCell *)[self.applicationView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]];
    CNCApplicationModel *aModel = self.model.models[index];
    CNCIgnoreAppModel *imodel = [[CNCIgnoreAppModel alloc] init];
    [imodel setValue:[NSDate cnc_currentDateWithFormat:@"YYYY-MM-dd hh:mm"] forKey:@"creatTime"];
    [imodel setValue:aModel.adamId forKey:@"appid"];
    [imodel setValue:[UIImageJPEGRepresentation(cell.appIcon.image, 1.f) base64EncodedString] forKey:@"appIcon"];
    [imodel setValue:aModel.name forKey:@"appName"];
    [imodel setValue:self.accountModel.email forKey:@"account"];
    [CNCSQL cnc_putToIgnoreAppSQLTableWithModel:imodel];
    NSMutableArray *arrM = [NSMutableArray arrayWithArray:self.model.models];
    [arrM removeObjectAtIndex:index];
    [self.model setValue:arrM forKey:@"models"];
    [self.applicationView deleteSections:[NSIndexSet indexSetWithIndex:index]];
    if (index != self.model.models.count) {
        //当删除的cell不是最后一条时,需要刷新继位cell的数据,防止获取数据不正确
        [self.applicationView reloadSections:[NSIndexSet indexSetWithIndex:index]];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

//- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
//    UIPreviewAction *cancel = [UIPreviewAction actionWithTitle:@"取消" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {}];
//    return @[cancel];
//}

- (QMUIPopupContainerView *)popupContainerView {
    if (!_popupContainerView) {
        _popupContainerView = [[QMUIPopupContainerView alloc] init];
        _popupContainerView.automaticallyHidesWhenUserTap = YES;
    }
    return _popupContainerView;
}

- (CNCApplicationView *)applicationView {
    if (!_applicationView) {
        _applicationView = [[CNCApplicationView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[CNCCollectionNormalLayout alloc] initWithSize:CGSizeMake(SCREEN_WIDTH-15, 84)]];
        _applicationView.alwaysBounceVertical = YES;
        [_applicationView registerClass:[CNCApplicationsCell class] forCellWithReuseIdentifier:kIdentifier];
        _applicationView.dataSource = self;
        _applicationView.delegate = self;
    }
    return _applicationView;
}

- (CNCApplicationModel *)model {
    if (!_model) {
        _model = [[CNCApplicationModel alloc] init];
    }
    return _model;
}

@end
