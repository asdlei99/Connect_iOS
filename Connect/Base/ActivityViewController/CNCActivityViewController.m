////  CNCActivityViewController.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCActivityViewController.h"

@interface CNCActivityViewController ()

@end

@implementation CNCActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.dismissHUD) {
        self.dismissHUD();
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end
