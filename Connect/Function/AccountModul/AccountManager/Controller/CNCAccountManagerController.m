////  CNCAccountManagerController.m
//  Connect
//
//  Created by Dwang on 2018/9/3.
//    QQ群:    577506623
//    GitHub:    https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCAccountManagerController.h"
#import "CNCCreateAccountController.h"
#import "CNCCollectionNormalLayout.h"
#import <AudioToolbox/AudioToolbox.h>
#import "CNCAccountManagerView.h"
#import "CNCAccountManagerCell.h"
#import "CNCNotification.h"
#import "CNCSQLManager.h"

@interface CNCAccountManagerController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) CNCAccountManagerView *managerTableView;

@property(nonatomic, strong) UILongPressGestureRecognizer *longPress;

@end

@implementation CNCAccountManagerController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak __typeof(self)weakSelf = self;
    self.tabBarItem.qmui_doubleTapBlock = ^(UITabBarItem *tabBarItem, NSInteger index) {
        if (tabBarItem == weakSelf.tabBarItem &&
            index == 1) {
            [weakSelf cnc_addAccountDidClick];
        }
    };
    [CNCNotification cnc_addObserver:self selector:@selector(cnc_accountsSort) name:kNewAccountSort];
}

- (void)cnc_accountsSort {
    [self.managerTableView reloadData];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.titleView.title = @"账号管理";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(cnc_addAccountDidClick)];
}

- (void)setUI {
    [self.view addSubview:self.managerTableView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return CNCSQL.accountModels.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CNCAccountManagerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    CNCAccountModel *model = CNCSQL.accountModels[indexPath.section];
    cell.emailLabel.text = [NSString stringWithFormat:@"账号:%@", model.email];
    cell.markLabel.text = [NSString stringWithFormat:@"%@:%@", @"备注", model.mark];
    cell.deleteBtn.tag = indexPath.section;
    cell.shareBtn.tag = indexPath.section;
    [cell.deleteBtn addTarget:self action:@selector(cnc_deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shareBtn addTarget:self action:@selector(cnc_shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView qmui_clearsSelection];
    [self cnc_pushCreateAccountViewControllerForRowAtIndexPath:indexPath];
}

- (void)cnc_addAccountDidClick {
    [self cnc_pushCreateAccountViewControllerForRowAtIndexPath:nil];
}

- (void)cnc_deleteBtnClick:(QMUIButton *)sender {
    if (CNCUserDefaultsBoolForKey(kCloseDeleteAccountAlert)) {
        [self cnc_deleteAccountModelWithIndex:sender.tag];
    }else {
        __weak __typeof(self)weakSelf = self;
        QMUIAlertController *alert = [QMUIAlertController alertControllerWithTitle:nil message:@"是否确定删除此账号?" preferredStyle:QMUIAlertControllerStyleAlert];
        [alert addAction:[QMUIAlertAction actionWithTitle:@"确定" style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController *aAlertController, QMUIAlertAction *action) {
            [weakSelf cnc_deleteAccountModelWithIndex:sender.tag];
        }]];
        [alert addCancelAction];
        [alert showWithAnimated:YES];
    }
}

- (void)cnc_shareBtnClick:(QMUIButton *)sender {
    CNCAccountModel *model = CNCSQL.accountModels[sender.tag];
    if (![[UIPasteboard generalPasteboard].string containsString:model.email]) {
        [UIPasteboard generalPasteboard].string = [NSString stringWithFormat:@"账号:%@   密码:%@", model.email, model.developer_password];
        if ([[UIPasteboard generalPasteboard].string containsString:model.email]) {
            [self.toastView showWithText:@"您已成功将账号信息复制至粘贴板" hideAfterDelay:1.25];
        }
    }else {
        [self.toastView showWithText:@"请勿重复执行此操作" hideAfterDelay:1.25];
    }
}

- (void)cnc_deleteAccountModelWithIndex:(NSInteger)index {
    CNCAccountModel *model = CNCSQL.accountModels[index];
    [CNCSQL cnc_deleteForAccountSQLTableWithModel:model];
    [CNCNotification cnc_postNotificationName:kACCOUNTDATACHANGE object:[NSIndexPath indexPathForRow:0 inSection:index]];
    [self.managerTableView reloadData];//由于删除按钮属于外部控件,无法实时获取indexPath,所有需要重新刷新全部数据
}

- (void)cnc_pushCreateAccountViewControllerForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak __typeof(self)weakSelf = self;
    CNCCreateAccountController *create = [[CNCCreateAccountController alloc] init];
    create.cnc_accountOperateTypeCallBack = ^(CNCAccountOperateType operateType) {
        if (operateType == CNCAccountOperateTypeCreate) {
            [weakSelf.managerTableView reloadData];
            [CNCNotification cnc_postNotificationName:kACCOUNTDATACHANGE];
        }else {
            [weakSelf.managerTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]];
            [CNCNotification cnc_postNotificationName:kACCOUNTDATACHANGE object:@(indexPath.section)];
        }
    };
    if (indexPath) {
        create.title = @"编辑账号信息";
        create.accountModel = CNCSQL.accountModels[indexPath.section];
    }else {
        create.title = @"新建账号";
        create.accountModel = nil;
    }
    [self.navigationController pushViewController:create animated:YES];
}

- (void)cnc_lonePressMoving:(UILongPressGestureRecognizer *)longPress {
    if (@available(iOS 9.0, *)) {
       CGPoint poit = [longPress locationInView:self.managerTableView];
        switch (longPress.state) {
            case UIGestureRecognizerStateBegan: {
                {
                    NSIndexPath *indexPath = [self.managerTableView indexPathForItemAtPoint:poit];
                    if (indexPath) {
                       [self.managerTableView beginInteractiveMovementForItemAtIndexPath:indexPath];
                    }
                }
                break;
            }
            case UIGestureRecognizerStateChanged: {
                [self.managerTableView updateInteractiveMovementTargetPosition:poit];
                break;
            }
            case UIGestureRecognizerStateEnded: {
                [self.managerTableView endInteractiveMovement];
                break;
            }
            default: [self.managerTableView cancelInteractiveMovement];
                break;
        }
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath {
    [CNCSQL cnc_moveForAccountSQLTableWithFromModel:CNCSQL.accountModels[sourceIndexPath.section] toModel:CNCSQL.accountModels[destinationIndexPath.section]];
    self.managerTableView.userInteractionEnabled = NO;
    __weak __typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.managerTableView reloadData];
        weakSelf.managerTableView.userInteractionEnabled = YES;
    });
    [CNCNotification cnc_postNotificationName:kACCOUNTDATACHANGE object:@"move"];
}

- (CNCAccountManagerView *)managerTableView {
    if (!_managerTableView) {
        _managerTableView = [[CNCAccountManagerView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[CNCCollectionNormalLayout alloc] initWithSize:CGSizeMake(SCREEN_WIDTH-20, 72)]];
        [_managerTableView registerClass:[CNCAccountManagerCell class] forCellWithReuseIdentifier:@"cell"];
        self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cnc_lonePressMoving:)];
        [_managerTableView addGestureRecognizer:self.longPress];
        _managerTableView.dataSource = self;
        _managerTableView.delegate = self;
    }
    return _managerTableView;
}

- (void)dealloc {
    [CNCNotification cnc_removeObserver:self name:kNewAccountSort];
}

@end


