////  CNCQueryCell.m
//  Connect
//
//  Created by Dwang on 2018/9/10.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCQueryCell.h"

@implementation CNCQueryCell

- (void)setCellINFO {
    [super setCellINFO];
    self.animated = YES;
    self.emailLabel = [[QMUILabel alloc] init];
    [self.contentView addSubview:self.emailLabel];
    self.emailLabel.font = CNCAmericanTypewriterBold;
    [self.emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(12);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-5);
    }];
    
    self.markLabel = [[QMUILabel alloc] init];
    self.markLabel.font = UIFontMake(16.f);
    self.markLabel.textColor = UIColorGray;
    [self.contentView addSubview:self.markLabel];
    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.emailLabel);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.right.equalTo(self.emailLabel);
    }];
    
    self.lastQuery = [[UIImageView alloc] initWithImage:UIImageMake(@"lastQuery")];
    [self.contentView addSubview:self.lastQuery];
    [self.lastQuery mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.size.mas_offset(self.lastQuery.image.size);
    }];
    
}

@end
