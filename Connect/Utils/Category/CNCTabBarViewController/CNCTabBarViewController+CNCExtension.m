////  CNCTabBarViewController+CNCExtension.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//    QQ群:    577506623
//    GitHub:    https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCTabBarViewController+CNCExtension.h"
#import "CNCViewController.h"
#import "CNCNavigationController.h"

@interface CNCTabBarViewController ()

@end

@implementation CNCTabBarViewController (CNCExtension)

- (void)cnc_addChildViewController:(CNCViewController *)viewController tabBarImageName:(NSString *)imgName {
    NSString *defaultName = [NSString stringWithFormat:@"%@_default", imgName];
    NSString *selectName = [NSString stringWithFormat:@"%@_selected", imgName];
    viewController.tabBarItem.image = [UIImageMake(defaultName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [UIImageMake(selectName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    [self addChildViewController:[[CNCNavigationController alloc] initWithRootViewController:viewController]];
}

@end


