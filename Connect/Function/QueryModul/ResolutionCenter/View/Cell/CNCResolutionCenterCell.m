////  CNCResolutionCenterCell.m
//  Connect
//
//  Created by Dwang on 2018/10/5.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCResolutionCenterCell.h"
#import <YYLabel.h>

@implementation CNCResolutionCenterCell

- (void)setCellINFO {
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.summary = [[QMUILabel alloc] init];
    self.summary.textColor = UIColorGray;
    self.summary.numberOfLines = 2;
    self.summary.font = UIFontMake(16.f);
    [self.contentView addSubview:self.summary];
    [self.summary mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.right.equalTo(self.contentView.mas_right);
    }];
    
    YYTextSimpleEmoticonParser *parser = [[YYTextSimpleEmoticonParser alloc] init];
    parser.emoticonMapper = @{@":author:":UIImageMake(@"author")};
    self.author = [[YYLabel alloc] init];
    self.author.font = UIFontMake(16.f);
    self.author.textColor = UIColorGrayDarken;
    self.author.textParser = parser;
    [self.contentView addSubview:self.author];
    [self.author mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.summary.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-2.5f);
    }];
    
}

@end
