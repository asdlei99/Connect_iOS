////  CNCIgnoreAppsCell.m
//  Connect
//
//  Created by Dwang on 2018/9/29.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCIgnoreAppsCell.h"

@implementation CNCIgnoreAppsCell

- (void)setCellINFO {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.contentView.backgroundColor = UIColorWhite;
    self.appIcon = [[UIImageView alloc] initWithImage:UIImageMake(@"logo2")];
    [self.contentView addSubview:self.appIcon];
    [self.appIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.mas_left).offset(15);
        make.size.equalTo(self.contentView.mas_height).offset(-15);
    }];
    
    self.appName = [[QMUILabel alloc] init];
    self.appName.font = UIFontMake(18);
    [self.contentView addSubview:self.appName];
    [self.appName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.appIcon.mas_top).offset(2.5);
        make.left.equalTo(self.appIcon.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    self.createTime = [[QMUILabel alloc] init];
    self.createTime.font = UIFontMake(12);
    self.createTime.textColor = UIColorGrayLighten;
    [self.contentView addSubview:self.createTime];
    [self.createTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.appName.mas_right);
        make.centerY.equalTo(self.contentView.mas_centerY).offset(2.5);
    }];
    
    self.account = [[QMUILabel alloc] init];
    self.account.font = UIFontMake(14);
    self.account.textColor = UIColorGrayLighten;
    [self.contentView addSubview:self.account];
    [self.account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.appName.mas_left);
        make.bottom.equalTo(self.appIcon.mas_bottom).offset(-2.5);
    }];
    
}

@end
