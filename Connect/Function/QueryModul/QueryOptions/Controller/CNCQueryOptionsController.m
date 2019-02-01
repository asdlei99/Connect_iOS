////  CNCQueryOptionsController.m
//  Connect
//
//  Created by Dwang on 2018/9/21.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCResolutionCenterController.h"
#import "CNCQueryOptionsController.h"
#import "CNCAppDetailController.h"
#import "CNCCollectionNormalLayout.h"
#import "CNCAllOptionsController.h"
#import "CNCQueryOptionsModel.h"
#import "CNCQueryOptionsCell.h"
#import "CNCApplicationModel.h"
#import "CNCQueryOptionView.h"
#import "CNCAnimationLabel.h"

static NSString *const kIdentifier = @"cell";
@interface CNCQueryOptionsController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic, strong) CNCQueryOptionView *queryOptionView;

@property(nonatomic, strong) CNCApplicationModel *applicationModel;

@end

@implementation CNCQueryOptionsController

- (instancetype)initWithApplicationModel:(CNCApplicationModel *)model {
    self = [super init];
    if (self) {
        self.applicationModel = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"操作类型";
}

- (void)setUI {
    [self.view addSubview:self.queryOptionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.applicationModel.versionSets[0].optionsModel.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CNCQueryOptionsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentifier forIndexPath:indexPath];
    cell.title.text = self.applicationModel.versionSets[0].optionsModel.models[indexPath.row].title;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView qmui_clearsSelection];
    NSString *title = self.applicationModel.versionSets[0].optionsModel.models[indexPath.row].title;
    if (ISEqualToString(title, @"查看详情")) {
        CNCAppDetailController *detail = [[CNCAppDetailController alloc] init];
        detail.appid = self.applicationModel.adamId;
        detail.versionid = self.applicationModel.versionSets[0].inFlightVersion.version;
        [self.navigationController pushViewController:detail animated:YES];
    }else if (ISEqualToString(title, @"反馈中心")) {
        CNCResolutionCenterController *resolutionCenter = [[CNCResolutionCenterController alloc] init];
        resolutionCenter.appid = self.applicationModel.adamId;
        [self.navigationController pushViewController:resolutionCenter animated:YES];
    }else if (ISEqualToString(title, @"AppStore")) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:CNCJumpAppStore(self.applicationModel.adamId)]];
    }else if (ISEqualToString(title, @"全部选项")) {
        [self.navigationController pushViewController:[CNCAllOptionsController new] animated:YES];
    }
}

- (CNCQueryOptionView *)queryOptionView {
    if (!_queryOptionView) {
        _queryOptionView = [[CNCQueryOptionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[CNCCollectionNormalLayout alloc] initWithSize:CGSizeMake(SCREEN_WIDTH-15, SCREEN_WIDTH*.28)]];
        _queryOptionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _queryOptionView.showsVerticalScrollIndicator = NO;
        _queryOptionView.dataSource = self;
        _queryOptionView.delegate = self;
        _queryOptionView.alwaysBounceVertical = YES;
        _queryOptionView.contentInset = UIEdgeInsetsMake(10, 0, 25, 0);
        [_queryOptionView registerClass:[CNCQueryOptionsCell class] forCellWithReuseIdentifier:kIdentifier];
    }
    return _queryOptionView;
}
@end
