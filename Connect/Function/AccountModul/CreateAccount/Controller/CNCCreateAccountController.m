////  CNCCreateAccountController.m
//  Connect
//
//  Created by Dwang on 2018/9/3.
//    QQ群:    577506623
//    GitHub:    https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCCreateAccountController.h"
#import "CNCCreateAccountHeaderView.h"
#import "CNCCreateAccountModel.h"
#import "CNCCreateAccountView.h"
#import "CNCCreateAccountCell.h"
#import <AudioToolbox/AudioToolbox.h>
#import "CNCNotification.h"
#import "CNCSQLManager.h"

@interface CNCCreateAccountController ()<QMUITableViewDelegate, QMUITableViewDataSource>

@property(nonatomic, strong) CNCCreateAccountView *createTableView;

@property(nonatomic, strong) CNCCreateAccountModel *model;

@property(nonatomic, copy) NSArray<NSString *> *texts;

@end

@implementation CNCCreateAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setupNavigationItems {
    [super setupNavigationItems];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(cnc_saveDidClick)];
    if (self.navigationController.viewControllers.count == 1) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem qmui_backItemWithTarget:self action:@selector(cnc_dismissViewController)];
    }
}

- (void)setUI {
    [self.view addSubview:self.createTableView];
}

- (void)cnc_dismissViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cnc_saveDidClick {
    __block BOOL result = NO;
    __weak __typeof(self)weakSelf = self;
    CNCAccountModel *model = [CNCAccountModel new];
    [self.model.models enumerateObjectsUsingBlock:^(CNCCreateAccountModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CNCCreateAccountCell *cell = [weakSelf.createTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
        NSString *value = cell.content.text.qmui_trimAllWhiteSpace;
        result = value.length;
        if (result) {
            BOOL *b = stop;
            if (idx == 0 && !weakSelf.accountModel) {
                if ([[NSPredicate predicateWithFormat:@"SELF MATCHES %@", kEMailRegular] evaluateWithObject:value]) {
                    [CNCSQL.accountModels enumerateObjectsUsingBlock:^(CNCAccountModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if (ISEqualToString(value, obj.email)) {
                            *b = YES;
                            *stop = YES;
                            result = NO;
                            QMUIAlertController *alert = [[QMUIAlertController alloc] initWithTitle:nil message:@"当前输入的账号已存在" preferredStyle:QMUIAlertControllerStyleAlert];
                            [alert addCancelAction];
                            [alert showWithAnimated:YES];
                        }
                    }];
                }else {
                    *b = YES;
                    *stop = YES;
                    result = NO;
                    QMUIAlertController *alert = [[QMUIAlertController alloc] initWithTitle:nil message:@"请输入正确的邮箱信息" preferredStyle:QMUIAlertControllerStyleAlert];
                    [alert addCancelAction];
                    [alert showWithAnimated:YES];
                }
            }
            if (!*b) {
                [model setValue:value forKey:obj.key];
            }
        }else {
            *stop = YES;
            QMUIAlertController *alert = [[QMUIAlertController alloc] initWithTitle:nil message:@"请输入对应的内容" preferredStyle:QMUIAlertControllerStyleAlert];
            [alert addCancelAction];
            [alert showWithAnimated:YES];
        }
    }];
    if (result) {
        if (self.accountModel) {
            [model setValue:self.accountModel.createTime forKey:@"createTime"];
            [model setValue:self.accountModel.cookies forKey:@"cookies"];
            [CNCSQL cnc_editForAccountSQLTableWithModel:model];
        }else{
            [CNCSQL cnc_putToAccountSQLTableWithModel:model];
        }
        if (self.cnc_accountOperateTypeCallBack) {
            self.cnc_accountOperateTypeCallBack(self.accountModel?CNCAccountOperateTypeEdit:CNCAccountOperateTypeCreate);
            if (!self.accountModel) {
                if (CNCUserDefaultsBoolForKey(kCloseCreateAccountAlert)) {
                    [self cnc_dismissViewController];
                }else {
                    QMUIAlertController *alert = [QMUIAlertController alertControllerWithTitle:nil message:@"添加成功,是否继续添加" preferredStyle:QMUIAlertControllerStyleAlert];
                    [alert addAction:[QMUIAlertAction actionWithTitle:@"取消" style:QMUIAlertActionStyleCancel handler:^(__kindof QMUIAlertController *aAlertController, QMUIAlertAction *action) {
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }]];
                    [alert addAction:[QMUIAlertAction actionWithTitle:@"继续添加" style:QMUIAlertActionStyleDefault handler:^(__kindof QMUIAlertController *aAlertController, QMUIAlertAction *action) {
                        for (int i = 0; i < weakSelf.model.models.count; i ++) {
                            CNCCreateAccountCell *cell = [weakSelf.createTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                            cell.content.text = nil;
                        };
                        CNCCreateAccountCell *cell = [weakSelf.createTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                        [cell.content becomeFirstResponder];
                    }]];
                    [alert showWithAnimated:YES];
                }
            }else {
                [self cnc_dismissViewController];
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    CNCCreateAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[CNCCreateAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    CNCCreateAccountModel *model = self.model.models[indexPath.row];
    cell.content.tag = indexPath.row;
    [cell.content addTarget:self action:@selector(cnc_textFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [cell.content addTarget:self action:@selector(cnc_textFieldEnd:) forControlEvents:UIControlEventEditingDidEnd];
    if (ISEqualToString(model.key, @"email")) {
        cell.content.spellCheckingType = UITextSpellCheckingTypeNo;
        cell.content.autocorrectionType = UITextAutocorrectionTypeNo;
        cell.content.autocapitalizationType = UITextAutocapitalizationTypeNone;
        cell.content.keyboardType = UIKeyboardTypeEmailAddress;
        if (!self.accountModel) {
            [cell.content becomeFirstResponder];
            [UIView animateWithDuration:0.25 animations:^{
                cell.line.backgroundColor = UIColorGreen;
                cell.line.height = 2;
            }];
        }
    }else if (ISEqualToString(model.key, @"developer_password")) {
        cell.content.autocorrectionType = UITextAutocorrectionTypeNo;
        cell.content.keyboardType = UIKeyboardTypeASCIICapable;
        if (self.accountModel) {
            [cell.content becomeFirstResponder];
            [UIView animateWithDuration:0.25 animations:^{
                cell.line.backgroundColor = UIColorGreen;
                cell.line.height = 2;
            }];
        }
    }
    if (self.accountModel) {
        cell.content.enabled = indexPath.row;
        cell.content.text = self.texts[indexPath.row];
        UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] init];
        longPressGestureRecognizer.minimumPressDuration = 1.25f;
        [longPressGestureRecognizer addTarget:self action:@selector(cnc_copyToPasteboard:)];
        [cell addGestureRecognizer:longPressGestureRecognizer];
    }
    cell.title.text = [NSString stringWithFormat:@"%@:", model.title];
    cell.content.placeholder = [NSString stringWithFormat:@"请在当前位置输入%@内容", model.title];
    return cell;
}

- (void)cnc_copyToPasteboard:(UITapGestureRecognizer *)sender {
    CNCCreateAccountCell *cell = (CNCCreateAccountCell *)sender.view;
    if (!ISEqualToString([UIPasteboard generalPasteboard].string, cell.content.text)) {
        [UIPasteboard generalPasteboard].string = cell.content.text;
        AudioServicesPlaySystemSound(1519);
        [self.toastView showWithText:@"您已成功将账号内容复制到粘贴板" hideAfterDelay:2.25];
    }
}

- (void)cnc_textFieldBegin:(QMUITextField *)sender {
    CNCCreateAccountCell *cell = [self.createTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    [UIView animateWithDuration:0.25 animations:^{
        cell.line.backgroundColor = UIColorGreen;
        cell.line.height = 2;
    }];
}

- (void)cnc_textFieldEnd:(QMUITextField *)sender {
    CNCCreateAccountCell *cell = [self.createTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sender.tag inSection:0]];
    [UIView animateWithDuration:0.25 animations:^{
        cell.line.backgroundColor = UIColorHex(#efefef);
        cell.line.height = 1;
    }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView qmui_clearsSelection];
    
}

- (CNCCreateAccountView *)createTableView {
    if (!_createTableView) {
        _createTableView = [[CNCCreateAccountView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _createTableView.dataSource = self;
        _createTableView.delegate = self;
        CNCCreateAccountHeaderView *header = [[CNCCreateAccountHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*.4)];
        _createTableView.tableHeaderView = header;
    }
    return _createTableView;
}

- (CNCCreateAccountModel *)model {
    if (!_model) {
        _model = [CNCCreateAccountModel new];
    }
    return _model;
}

- (NSArray<NSString *> *)texts {
    if (!_texts) {
        _texts = @[
                   self.accountModel.email,
                   self.accountModel.developer_password,
                   self.accountModel.mark,
                   ];
    }
    return _texts;
}

@end


