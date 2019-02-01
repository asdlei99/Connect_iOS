////  CNCQueryController.m
//  Connect
//
//  Created by Dwang on 2018/9/10.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCApplicationController.h"
#import "CNCCollectionNormalLayout.h"
#import "CNCAccountManagerController.h"
#import "CNCQueryController.h"
#import "CNCNotification.h"
#import "CNCSQLManager.h"
#import "CNCQueryView.h"
#import "CNCQueryCell.h"

@interface CNCQueryController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) CNCQueryView *queryView;

/** 暂存最后操作的账号模型索引 */
@property(nonatomic, assign) NSInteger lastQueryIndex;

@end

@implementation CNCQueryController

- (void)viewDidLoad {
    [super viewDidLoad];
    [CNCNotification cnc_addObserver:self selector:@selector(cnc_accountDataChange:) name:kACCOUNTDATACHANGE];
     [CNCNotification cnc_addObserver:self selector:@selector(cnc_accountsSort) name:kNewAccountSort];
    if (CNCSQL.accountModels.count) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(cnc_rightBarButtonItemDidClick)];
    }else {
        self.tabBarController.selectedIndex = 1;
    }
}

- (void)cnc_accountsSort {
    [self.queryView reloadData];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.titleView.title = @"查询";
}

- (void)cnc_rightBarButtonItemDidClick {
    [self.navigationController pushViewController:[CNCAccountManagerController new] animated:YES];
}

- (void)setUI {
    [self.view addSubview:self.queryView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return CNCSQL.accountModels.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CNCQueryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        CNCAccountModel *model = CNCSQL.accountModels[indexPath.section];
        cell.emailLabel.text = [NSString stringWithFormat:@"账号: %@", model.email];
        cell.markLabel.text = [NSString stringWithFormat:@"备注: %@", model.mark];
        cell.lastQuery.hidden = YES;
        if (ISEqualToString(model.email, CNCUserDefaultsObjectForKey(kLastQueryAccount))) {
            if (CNCUserDefaultsBoolForKey(kOpenLastQueryAccountMark)) {
                cell.lastQuery.hidden = NO;
            }
            self.lastQueryIndex = indexPath.section+10086;
        }
//        if (@available(iOS 9.0, *)) {
//            if ([self respondsToSelector:@selector(traitCollection)]) {
//                if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
//                    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
//                        [self registerForPreviewingWithDelegate:(id)self sourceView:cell];
//                    }
//                }
//            }
//        }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView qmui_clearsSelection];
    [self.navigationController pushViewController:[self cnc_getApplicationControllerWithIndexPath:indexPath] animated:YES];
}

//- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location NS_AVAILABLE_IOS(9_0) {
//    NSIndexPath *indexPath = [self.queryView indexPathForCell:(CNCQueryCell *)[previewingContext sourceView]];
//    return [self cnc_getApplicationControllerWithIndexPath:indexPath];
//}
//
//- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(CNCViewController *)viewControllerToCommit NS_AVAILABLE_IOS(9_0) {
//    viewControllerToCommit.navigationBar.hidden = NO;
//    [self showViewController:viewControllerToCommit sender:self];
//}

- (CNCApplicationController *)cnc_getApplicationControllerWithIndexPath:(NSIndexPath *)indexPath {
    CNCApplicationController *application = [[CNCApplicationController alloc] init];
    application.accountModel = CNCSQL.accountModels[indexPath.section];
    application.index = indexPath.section;
    application.lastQueryIndex = self.lastQueryIndex;
    __weak __typeof(self)weakSelf = self;
    application.cnc_reloadLastQueryCell = ^(NSInteger lastQueryIndex) {
        weakSelf.lastQueryIndex = lastQueryIndex;
        if (lastQueryIndex < 10086) {
            [weakSelf.queryView reloadItemsAtIndexPaths:@[indexPath]];
        }else {
            [weakSelf.queryView reloadItemsAtIndexPaths:@[indexPath, [NSIndexPath indexPathWithIndex:lastQueryIndex-10086]]];
        }
    };
    return application;
}

- (void)cnc_accountDataChange:(NSNotification *)cation {
    if (!cation.object) {
        [self.queryView reloadData];
    }else if ([cation.object isKindOfClass:[NSIndexPath class]]) {
        [self.queryView deleteSections:[NSIndexSet indexSetWithIndex:[cation.object section]]];
    }else if ([cation.object isKindOfClass:[NSNumber class]]) {
        [self.queryView reloadSections:[NSIndexSet indexSetWithIndex:[cation.object integerValue]]];
    }else if ([cation.object isKindOfClass:[NSString class]] && ISEqualToString(cation.object, @"move")) {
        [self.queryView reloadData];
    }else if ([cation.object isKindOfClass:[NSString class]] && ISEqualToString(cation.object, kOpenLastQueryAccountMark)) {
        if (self.lastQueryIndex>=10086) {
            [self.queryView reloadSections:[NSIndexSet indexSetWithIndex:self.lastQueryIndex-10086]];
        }
    }
}

- (CNCQueryView *)queryView {
    if (!_queryView) {
        _queryView = [[CNCQueryView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[CNCCollectionNormalLayout alloc] initWithSize:CGSizeMake(SCREEN_WIDTH-30, 72)]];
        _queryView.dataSource = self;
        _queryView.delegate = self;
        [_queryView registerClass:[CNCQueryCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _queryView;
}

- (void)dealloc {
    [CNCNotification cnc_removeObserver:self name:kACCOUNTDATACHANGE];
    [CNCNotification cnc_removeObserver:self name:kNewAccountSort];
}

@end
