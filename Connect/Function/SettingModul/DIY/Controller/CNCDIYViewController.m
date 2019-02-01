////  CNCDIYViewController.m
//  Connect
//
//  Created by Dwang on 2018/10/18.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCDIYViewController.h"
#import "CNCNotification.h"
#import "CNCSQLManager.h"
#import "CNCDIYModel.h"
#import "CNCDIYView.h"
#import "CNCDIYCell.h"

@interface CNCDIYViewController ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) CNCDIYView *diyView;

@property(nonatomic, strong) CNCDIYModel *model;

@end

@implementation CNCDIYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.title = @"DIY";
}

- (void)setUI {
    [self.view addSubview:self.diyView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.model.models.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.f;
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
    CNCDIYCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CNCDIYCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    CNCDIYModel *model = self.model.models[indexPath.section];
    cell.textLabel.text = model.title;
    cell.funSwitch.on = model.status;
    cell.funSwitch.tag = indexPath.section;
    [cell.funSwitch addTarget:self action:@selector(funSwitchStatusChange:) forControlEvents:UIControlEventValueChanged];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)funSwitchStatusChange:(UISwitch *)sender {
    CNCDIYModel *model = self.model.models[sender.tag];
    if (ISEqualToString(model.title, @"使用启动动画")) {
        CNCUserDefaultsWithBoolForKey(!model.status, kCloseLaunchScreenAnimation);
    }else if (ISEqualToString(model.title, @"使用TabBarItem点击动画")) {
        CNCUserDefaultsWithBoolForKey(!model.status, kCloseTabBarItemAnimation);
    }else if (ISEqualToString(model.title, @"隐藏等待提交状态的应用")) {
        CNCUserDefaultsWithBoolForKey(!model.status, kHiddenPrepareForUpload);
    }else if (ISEqualToString(model.title, @"账号添加完成后不再提示")) {
        CNCUserDefaultsWithBoolForKey(!model.status, kCloseCreateAccountAlert);
    }else if (ISEqualToString(model.title, @"账号按照倒序排序")) {
        CNCUserDefaultsWithBoolForKey(!model.status, kNewAccountSort);
        [CNCSQL rearrangeAccountModels];
        [CNCNotification cnc_postNotificationName:kNewAccountSort];
    }else if (ISEqualToString(model.title, @"删除账号时不再提示")) {
        CNCUserDefaultsWithBoolForKey(!model.status, kCloseDeleteAccountAlert);
    }else if (ISEqualToString(model.title, @"隐藏应用时不再提示")) {
        CNCUserDefaultsWithBoolForKey(!model.status, kCloseHiddenApplicationAlert);
    }else if (ISEqualToString(model.title, @"最后查询的账号增加标记")) {
        CNCUserDefaultsWithBoolForKey(!model.status, kOpenLastQueryAccountMark);
        [CNCNotification cnc_postNotificationName:kACCOUNTDATACHANGE object:kOpenLastQueryAccountMark];
    }
}

- (CNCDIYView *)diyView {
    if (!_diyView) {
        _diyView = [[CNCDIYView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _diyView.dataSource = self;
        _diyView.delegate = self;
        _diyView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    }
    return _diyView;
}

- (CNCDIYModel *)model {
    if (!_model) {
        _model = [[CNCDIYModel alloc] init];
    }
    return _model;
}

@end
