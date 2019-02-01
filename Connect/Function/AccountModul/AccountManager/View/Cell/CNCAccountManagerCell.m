////  CNCAccountManagerCell.m
//  Connect
//
//  Created by Dwang on 2018/9/8.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCAccountManagerCell.h"

@implementation CNCAccountManagerCell

- (void)setCellINFO {
    [super setCellINFO];
    self.emailLabel = [[QMUILabel alloc] init];
    self.emailLabel.font = CNCAmericanTypewriterBold;
    [self.contentView addSubview:self.emailLabel];
    [self.emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
    }];

    self.markLabel = [[QMUILabel alloc] init];
    self.markLabel.font = UIFontMake(16.f);
    self.markLabel.textColor = UIColorGray;
    [self.contentView addSubview:self.markLabel];
    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.emailLabel);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.right.equalTo(self.emailLabel);
    }];
    
    self.deleteBtn = [[QMUIButton alloc] init];
    [self.deleteBtn setImage:UIImageMake(@"delete") forState:UIControlStateNormal];
    [self.contentView addSubview:self.deleteBtn];
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.size.mas_offset(self.deleteBtn.currentImage.size);
    }];
    
    self.shareBtn = [[QMUIButton alloc] init];
    [self.shareBtn setImage:UIImageMake(@"share") forState:UIControlStateNormal];
    [self.contentView addSubview:self.shareBtn];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.deleteBtn.mas_centerY);
        make.right.equalTo(self.deleteBtn.mas_left).offset(-20);
        make.size.equalTo(self.deleteBtn);
    }];
    
}

@end
