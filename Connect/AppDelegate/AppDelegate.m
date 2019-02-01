////  AppDelegate.m
//  Connect
//
//  Created by Dwang on 2018/8/31.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+CNCExtenison.h"
#import "CNCCreateAccountController.h"
#import "CNCNavigationController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self cnc_applyConfigurationWithOptions:launchOptions];
    [self startAnimation];
    if (@available(iOS 9.0, *)) {
        NSMutableArray *shortcutItems = (NSMutableArray *)[UIApplication sharedApplication].shortcutItems;
         UIApplicationShortcutItem *createAccount = [[UIApplicationShortcutItem alloc] initWithType:kCreateAccount localizedTitle:@"添加新账号" localizedSubtitle:nil icon:[UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd] userInfo:nil];
        if (![shortcutItems containsObject:createAccount]) {
            [shortcutItems addObject:createAccount];
            [UIApplication sharedApplication].shortcutItems = shortcutItems;
        }
    }
    return YES;
}

-(void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler  API_AVAILABLE(ios(9.0)){
    if(ISEqualToString(shortcutItem.type, kCreateAccount)) {
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:[[CNCNavigationController alloc] initWithRootViewController:[CNCCreateAccountController new]] animated:YES completion:nil];
    }
}

@end
