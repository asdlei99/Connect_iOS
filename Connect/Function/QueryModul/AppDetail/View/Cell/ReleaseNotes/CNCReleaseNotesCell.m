////  CNCReleaseNotesCell.m
//  Connect
//
//  Created by iizvv on 2018/11/24.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCReleaseNotesCell.h"

@implementation CNCReleaseNotesCell

- (void)setCellINFO {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.releaseNotes = [[QMUILabel alloc] init];
    self.releaseNotes.textColor = UIColorGrayDarken;
    self.releaseNotes.font = UIFontMake(16);
    self.releaseNotes.canPerformCopyAction = YES;
    [self.contentView addSubview:self.releaseNotes];
    [self.releaseNotes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}

@end
