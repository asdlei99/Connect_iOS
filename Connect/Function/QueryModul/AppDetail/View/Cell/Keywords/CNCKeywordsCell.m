////  CNCKeywordsCell.m
//  Connect
//
//  Created by iizvv on 2018/11/23.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCKeywordsCell.h"

@implementation CNCKeywordsCell

- (void)setCellINFO {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.keywords = [[QMUILabel alloc] init];
    self.keywords.numberOfLines = 0;
    self.keywords.font = UIFontMake(14);
    self.keywords.canPerformCopyAction = YES;
    self.keywords.textColor = UIColorGrayDarken;
    [self.contentView addSubview:self.keywords];
    [self.keywords mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}

@end
