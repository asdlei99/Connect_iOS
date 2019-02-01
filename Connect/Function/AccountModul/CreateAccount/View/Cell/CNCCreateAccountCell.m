////  CNCCreateAccountCell.m
//  Connect
//
//  Created by Dwang on 2018/9/5.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCCreateAccountCell.h"

@implementation CNCCreateAccountCell

- (void)setCellINFO {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.title = [[QMUILabel alloc] init];
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.width.mas_offset(40);
    }];
    
    self.content = [[QMUITextField alloc] init];
    self.content.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.contentView addSubview:self.content];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-15);
        make.left.equalTo(self.title.mas_right).offset(5);
    }];
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = UIColorHex(#efefef);
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.content.mas_bottom);
        make.left.equalTo(self.title.mas_left);
        make.right.equalTo(self.content.mas_right);
        make.height.mas_offset(1);
    }];
    
}

@end
