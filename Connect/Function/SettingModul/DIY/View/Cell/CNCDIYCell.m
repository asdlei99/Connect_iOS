////  CNCDIYCell.m
//  Connect
//
//  Created by Dwang on 2018/10/18.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCDIYCell.h"

@implementation CNCDIYCell

- (void)setCellINFO {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.funSwitch = [[UISwitch alloc] init];
    [self.contentView addSubview:self.funSwitch];
    [self.funSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
}

@end
