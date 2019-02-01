////  CNCAppDetailHeaderView.m
//  Connect
//
//  Created by iizvv on 2018/11/21.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCAppDetailHeaderView.h"
#import "UIView+CNCExtension.h"

@implementation CNCAppDetailHeaderView

- (void)loadView {
    self.backgroundColor = UIColorWhite;
    self.icon = [[UIImageView alloc] initWithImage:UIImageMake(@"default")];
    [self addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(8);
        make.left.equalTo(self.mas_left).offset(10);
        make.size.mas_offset(60);
    }];
    self.icon.cornerRadius = 10;
    
    self.appName = [[QMUILabel alloc] init];
    self.appName.numberOfLines = 0;
    self.appName.font = UIFontMake(18);
    [self addSubview:self.appName];
    [self.appName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_top);
        make.left.equalTo(self.icon.mas_right).offset(10);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    self.desc = [[QMUIButton alloc] init];
    self.desc.backgroundColor = UIColorClear;
    [self addSubview:self.desc];
    [self.desc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon.mas_bottom).offset(8);
        make.left.equalTo(self.icon.mas_left);
        make.right.equalTo(self.mas_right).offset(-15);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    self.desc.titleLabel.numberOfLines = 0;
    self.desc.titleLabel.font = UIFontMake(14);
    [self.desc setTitleColor:UIColorGrayDarken forState:UIControlStateNormal];
    
    self.status = [[UIView alloc] init];
    [self addSubview:self.status];
    [self.status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(10);
        make.left.equalTo(self.appName.mas_left);
        make.bottom.equalTo(self.icon.mas_bottom).offset(-2.5);
    }];
    self.status.round = YES;
    
    self.version = [[QMUILabel alloc] init];
    self.version.textColor = UIColorGrayDarken;
    self.version.font = UIFontMake(14);
    [self addSubview:self.version];
    [self.version mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.status.mas_centerY);
        make.left.equalTo(self.status.mas_right).offset(3.5);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
}

@end
