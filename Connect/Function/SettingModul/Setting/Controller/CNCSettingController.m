////  CNCSettingController.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//    QQ群:    577506623
//    GitHub:    https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCIgnoreAppsController.h"
#import "CNCSettingController.h"
#import "CNCDIYViewController.h"
#import "CNCSettingHeaderView.h"
#import <MessageUI/MessageUI.h>
#import "NSDate+CNCExtension.h"
#import "CNCSettingFooter.h"
#import "CNCSettingModel.h"
#import "CNCSettingView.h"
#import "CNCSettingCell.h"
#import "CNCSQLManager.h"
#import <JPUSHService.h>
#import <sys/utsname.h>

@interface CNCSettingController ()<QMUITableViewDelegate, QMUITableViewDataSource, MFMailComposeViewControllerDelegate>

@property(nonatomic, strong) CNCSettingView *settingTableView;

@property(nonatomic, strong) CNCSettingModel *model;

@property(nonatomic, strong) MFMailComposeViewController *mailCompose;

@end

@implementation CNCSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.titleView.title = @"设置";
}

- (void)setUI {
    [self.view addSubview:self.settingTableView];
}

- (void)setNetwork {
    [JPUSHService setAlias:[UIDevice currentDevice].name completion:nil seq:[NSDate cnc_currentDateWithFormat:@"YYYYMMddhhmmss"].integerValue];
    [JPUSHService validTag:[UIDevice currentDevice].name completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq, BOOL isBind) {
        if (!isBind) {
            [JPUSHService addTags:[NSSet setWithObject:[UIDevice currentDevice].name] completion:nil seq:[NSDate cnc_currentDateWithFormat:@"YYYYMMddhhmmss"].integerValue];
        }
    } seq:[NSDate cnc_currentDateWithFormat:@"YYYYMMddhhmmss"].integerValue];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.model.models.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.models[section].count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    CNCSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CNCSettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    CNCSettingModel *model = self.model.models[indexPath.section][indexPath.row];
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.detail;
    cell.backgroundColor = UIColorWhite;
    cell.textLabel.textColor = UIColorBlack;
    cell.detailTextLabel.textColor = UIColorGray;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.enabled = YES;
    [self cnc_setBackgroundImageWithColor:UIColorGray forObj:cell.subviews[1]];
    if (ISEqualToString(model.title, @"清除缓存")) {
        cell.detailTextLabel.text = [model cnc_getCacheSize];
        if (ISEqualToString([model cnc_getCacheSize], @"暂无缓存")) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.enabled = NO;
        }
    }else if (ISEqualToString(model.title, @"打赏支持")) {
        cell.detailTextLabel.textColor = UIColorRed;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    __weak __typeof(self)weakSelf = self;
    CNCSettingModel *model = self.model.models[indexPath.section][indexPath.row];
    if (ISEqualToString(model.title, @"自定义设置")) {
        [self.navigationController pushViewController:[CNCDIYViewController new] animated:YES];
    }else if (ISEqualToString(model.title, @"清除缓存")) {
        [self.toastView showLoading];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.model cnc_clearCacheWithCallBack:^{
                [weakSelf.settingTableView reloadRowAtIndexPath:indexPath withRowAnimation:UITableViewRowAnimationFade];
                [weakSelf.toastView showSucceed:@"缓存清除完成" hideAfterDelay:1.25f];
            }];
        });
    }else if(ISEqualToString(model.title, @"查看隐藏")) {
        if (CNCSQL.ignoreAppModels.count) {
            [self.navigationController pushViewController:[CNCIgnoreAppsController new] animated:YES];
        }else {
            [self.toastView showInfo:@"您当前并未隐藏任何应用" hideAfterDelay:2.25f];
        }
    }else if (ISEqualToString(model.title, @"打赏支持")) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:aliPay]];
    }else if (ISEqualToString(model.title, @"加入QQ群")) {
        NSURL *joinQQGroup = [NSURL URLWithString:joinQQCroup];
        if ([[UIApplication sharedApplication] canOpenURL:joinQQGroup]) {
            [[UIApplication sharedApplication] openURL:joinQQGroup];
        }else {
            [self.toastView showInfo:@"您当前设备没有安装QQ" hideAfterDelay:1.25];
        }
    }else if (ISEqualToString(model.title, @"用户反馈")) {
        [self cnc_feedBack];
    }
}

- (void)cnc_feedBack {
    if ([MFMailComposeViewController canSendMail]) {
        [self presentViewController:self.mailCompose animated:YES completion:nil];
    }else{
        [self.toastView showError:@"您当前设备未开启邮件服务,请开启服务后再次尝试反馈" hideAfterDelay:1.25f];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error {
    switch (result) {
        case MFMailComposeResultCancelled:
            [self.toastView showInfo:@"您取消了反馈邮件" hideAfterDelay:1.25];
            break;
        case MFMailComposeResultSaved:
            [self.toastView showInfo:@"您已将反馈邮件保存" hideAfterDelay:1.25];
            break;
        case MFMailComposeResultSent:
            [self.toastView showSucceed:@"您已成功发送反馈邮件,此问题将会尽快解决" hideAfterDelay:1.25];
            break;
        case MFMailComposeResultFailed:
            [self.toastView showInfo:@"反馈失败" hideAfterDelay:1.25f];
            break;
        default:
            break;
    }
    [self.mailCompose dismissViewControllerAnimated:YES completion:nil];
    self.mailCompose = nil;
}

- (void)cnc_setBackgroundImageWithColor:(UIColor *)color forObj:(id)obj {
    if ([obj isKindOfClass:[UIButton class]]) {
        UIButton *indicator = obj;
        [indicator setBackgroundImage:[UIImage qmui_imageWithShape:QMUIImageShapeDisclosureIndicator size:indicator.currentBackgroundImage.size tintColor:color] forState:UIControlStateNormal];
    }
}

- (CNCSettingView *)settingTableView {
    if (!_settingTableView) {
        _settingTableView = [[CNCSettingView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _settingTableView.dataSource = self;
        _settingTableView.delegate = self;
        _settingTableView.tableHeaderView = [[CNCSettingHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*.34)];
        CNCSettingFooter *tableFooterView = [[CNCSettingFooter alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        tableFooterView.version.text = [NSString stringWithFormat:@"Verison %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]];
        _settingTableView.tableFooterView = tableFooterView;
        _settingTableView.sectionHeaderHeight = CGFLOAT_MIN;
        _settingTableView.sectionFooterHeight = 10.f;
    }
    return _settingTableView;
}

- (CNCSettingModel *)model {
    if (!_model) {
        _model = [CNCSettingModel new];
    }
    return _model;
}

- (MFMailComposeViewController *)mailCompose {
    if (!_mailCompose) {
        _mailCompose = [[MFMailComposeViewController alloc] init];
        _mailCompose.navigationBar.tintColor = QMUICMI.navBarTintColor;
        _mailCompose.navigationBar.barTintColor = QMUICMI.navBarTintColor;
        _mailCompose.mailComposeDelegate = self;
        [_mailCompose setToRecipients:@[kEMail]];
//        [_mailCompose setCcRecipients:@[kCopyEMail]];
        [_mailCompose setSubject:@"Connect问题反馈"];
        UIDevice *device = [UIDevice currentDevice];
        struct utsname systemInfo;
        uname(&systemInfo);
        [_mailCompose setMessageBody:[NSString stringWithFormat:@"设备名称: %@\n设备型号: %@\n系统版本: %@\n应用版本:v %@", device.name, [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding], device.systemVersion, [NSString stringWithFormat:@"%@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]] isHTML:NO];
    }
    return _mailCompose;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.settingTableView reloadRow:0 inSection:1 withRowAnimation:UITableViewRowAnimationFade];
}

@end

