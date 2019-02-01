////  CNCQCLoginView.m
//  Connect
//
//  Created by Dwang on 2018/9/21.
//    QQ群:    577506623
//    GitHub:    https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCQCLoginView.h"
#import "CNCAsymptoticLabel.h"

@interface CNCQCLoginView ()

/** 用户名 */
@property(nonatomic, strong) QMUITextField *userName;

/** 密码 */
@property(nonatomic, strong) QMUITextField *password;

/** 登录按钮 */
@property(nonatomic, strong) QMUIButton *sigin;

@end

@implementation CNCQCLoginView

- (void)loadView {
    self.backgroundColor = UIColorWhite;
    
    CNCAsymptoticLabel *waringLab = [[CNCAsymptoticLabel alloc] init];
    waringLab.font = UIFontMake(20);
    waringLab.textColor = UIColorGray;
    waringLab.numberOfLines = 0;
    waringLab.textAlignment = NSTextAlignmentCenter;
    waringLab.message = @"由于平台规则限制,请输入对于此平台可用的用户名与密码";
    [self addSubview:waringLab];
    [waringLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(25);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    [waringLab cnc_show];
    
    self.userName = [[QMUITextField alloc] init];
    self.userName.userInteractionEnabled = NO;
    self.userName.keyboardType = UIKeyboardTypeEmailAddress;
    self.userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.userName.textAlignment = NSTextAlignmentCenter;
    self.userName.placeholder = @"请输入当前平台的用户名";
    [self.userName addTarget:self action:@selector(textFieldChange) forControlEvents:UIControlEventEditingChanged];
    [self.userName addTarget:self action:@selector(textFieldEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [self.userName addTarget:self action:@selector(textFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [self addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(waringLab.mas_bottom).offset(25);
        make.left.right.equalTo(waringLab);
        make.height.mas_offset(34);
    }];
    self.userName.qmui_borderPosition = QMUIViewBorderPositionBottom;
    self.userName.qmui_borderWidth = 1.f;
    self.userName.qmui_borderColor = UIColorGray;
    
    self.password = [[QMUITextField alloc] init];
    self.password.userInteractionEnabled = NO;
    self.password.textAlignment = NSTextAlignmentCenter;
    self.password.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.password.placeholder = @"请输入当前平台的密码";
    [self.password addTarget:self action:@selector(textFieldChange) forControlEvents:UIControlEventEditingChanged];
    [self.password addTarget:self action:@selector(textFieldEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [self.password addTarget:self action:@selector(textFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
    [self addSubview:self.password];
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userName.mas_bottom).offset(25);
        make.left.height.right.equalTo(self.userName);
    }];
    self.password.qmui_borderPosition = QMUIViewBorderPositionBottom;
    self.password.qmui_borderWidth = 1.f;
    self.password.qmui_borderColor = self.userName.qmui_borderColor;
    
    self.sigin = [[QMUIButton alloc] init];
    self.sigin.enabled = NO;
    self.sigin.backgroundColor = QMUICMI.navBarBarTintColor;
    [self.sigin setTitle:@"登录" forState:UIControlStateNormal];
    [self.sigin setTitleColor:UIColorWhite forState:UIControlStateNormal];
    [self.sigin addTarget:self action:@selector(siginDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.sigin];
    [self.sigin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.password.mas_bottom).offset(25);
        make.width.equalTo(self.password.mas_width).offset(-25);
        make.height.mas_offset(44);
    }];
    
    __weak __typeof(self)weakSelf = self;
    waringLab.cnc_endCallBack = ^(CNCAsymptoticLabel * _Nonnull asymptoticLabel) {
        weakSelf.userName.userInteractionEnabled = YES;
        weakSelf.password.userInteractionEnabled = YES;
        [weakSelf.userName becomeFirstResponder];
    };
    
}

- (void)textFieldBegin:(QMUITextField *)field {
    field.qmui_borderWidth = 2.5;
    field.qmui_borderColor = UIColorGreen;
}

- (void)textFieldEnd:(QMUITextField *)field {
    field.qmui_borderWidth = 1.f;
    field.qmui_borderColor = UIColorGray;
}

- (void)textFieldChange {
    self.sigin.enabled = (self.userName.text.qmui_trimAllWhiteSpace.length>3&&
                          self.password.text.qmui_trimAllWhiteSpace.length>=6);
}

- (void)siginDidClick:(QMUIButton *)sender {
    [self endEditing:NO];
    if (self.cnc_siginDidClick) {
        self.cnc_siginDidClick(@{@"userName":self.userName.text.qmui_trimAllWhiteSpace,
                                 @"password":self.password.text.qmui_trimAllWhiteSpace,
                                });
    }
}

@end


