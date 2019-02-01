////  CNCQCLoginController.m
//  Connect
//
//  Created by Dwang on 2018/9/21.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCQCLoginController.h"
#import "CNCQCLoginView.h"

@interface CNCQCLoginController ()<UIGestureRecognizerDelegate>

@property(nonatomic, strong) CNCQCLoginView *qcLoginView;

@end

@implementation CNCQCLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorMakeWithRGBA(255, 255, 255, 0.5);
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cnc_popDidClick)];
    gesture.delegate = self;
    [self.view addGestureRecognizer:gesture];
}

- (void)setUI {
    [self.view addSubview:self.qcLoginView];
    __weak __typeof(self)weakSelf = self;
    self.qcLoginView.cnc_siginDidClick = ^(NSDictionary * _Nonnull params) {
        if (weakSelf.cnc_qcloginDidClick) {
            weakSelf.cnc_qcloginDidClick(params);
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }
    };
    [self.qcLoginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(SCREEN_WIDTH*.3f);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)cnc_popDidClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return ![touch.view isKindOfClass:[CNCQCLoginView class]];
}

- (CNCQCLoginView *)qcLoginView {
    if (!_qcLoginView) {
        _qcLoginView = [[CNCQCLoginView alloc] init];
    }
    return _qcLoginView;
}

@end
