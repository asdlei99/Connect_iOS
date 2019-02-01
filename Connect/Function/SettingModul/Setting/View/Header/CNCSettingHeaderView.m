////  CNCSettingHeaderView.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCSettingHeaderView.h"

@implementation CNCSettingHeaderView

- (void)loadView {
    UIImageView *img = [[UIImageView alloc] initWithImage:UIImageMake(@"settingHeader")];
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
