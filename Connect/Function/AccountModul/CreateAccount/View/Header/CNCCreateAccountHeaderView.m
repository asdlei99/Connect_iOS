////  CNCCreateAccountHeaderView.m
//  Connect
//
//  Created by Dwang on 2018/10/18.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCCreateAccountHeaderView.h"

@implementation CNCCreateAccountHeaderView

- (void)loadView {
    UIImageView *img = [[UIImageView alloc] initWithImage:UIImageMake(@"developer")];
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
