////  CNCSettingFooter.m
//  Connect
//
//  Created by Dwang on 2018/10/10.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCSettingFooter.h"

@implementation CNCSettingFooter

- (void)loadView {
    self.version = [[QMUILabel alloc] init];
    self.version.font = UIFontMake(14);
    self.version.textColor = UIColorGrayLighten;
    self.version.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.version];
    [self.version mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
