////  CNCQueryOptionsCell.m
//  Connect
//
//  Created by Dwang on 2018/9/21.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCQueryOptionsCell.h"
#import "CNCAnimationLabel.h"

@implementation CNCQueryOptionsCell

- (void)setCellINFO {
    [super setCellINFO];
    self.title = [[CNCAnimationLabel alloc] init];
    self.title.fontSize = 64;
    self.title.lineWidth = 3;
    self.title.strokeColor = UIColorGrayDarken;
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
}

@end
