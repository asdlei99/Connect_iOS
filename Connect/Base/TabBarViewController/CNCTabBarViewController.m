////  CNCTabBarViewController.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//    QQ群:    577506623
//    GitHub:    https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCQueryController.h"
#import "CNCTabBarViewController.h"
#import "CNCSettingController.h"
#import "CNCAccountManagerController.h"
#import "CNCTabBarViewController+CNCExtension.h"


@interface CNCTabBarViewController ()

@property(nonatomic, assign) NSInteger idx;

@end

@implementation CNCTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.idx = 0;
    [self cnc_addChildViewController:CNCQueryController.new tabBarImageName:@"query"];
    [self cnc_addChildViewController:CNCAccountManagerController.new tabBarImageName:@"create"];
    [self cnc_addChildViewController:CNCSettingController.new tabBarImageName:@"setting"];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
//    __weak __typeof(self)weakSelf = self;
//    item.qmui_doubleTapBlock = ^(UITabBarItem *tabBarItem, NSInteger index) {
//        weakSelf.idx+=1;
//    };
    if (!CNCUserDefaultsBoolForKey(kCloseTabBarItemAnimation)) {
        return;
    }
    NSInteger idx = [tabBar.items indexOfObject:item];
    if (self.idx != idx) {
        self.idx = idx;
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.duration = 0.2;
        animation.repeatCount = 1;
        animation.autoreverses = YES;
        animation.fromValue = @(0.7);
        animation.toValue = @(1.3);
        [item.qmui_imageView.layer addAnimation:animation forKey:nil];
    }
}
@end


