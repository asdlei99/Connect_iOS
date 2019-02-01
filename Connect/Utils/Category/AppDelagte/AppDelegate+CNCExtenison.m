////  AppDelegate+CNCExtenison.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "AppDelegate+CNCExtenison.h"
#import <DWNetworking.h>
#import <IQKeyboardManager.h>
#import <AFNetworkActivityIndicatorManager.h>
#import "CNCTabBarViewController.h"
#import <JPUSHService.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>
#import <LSSafeProtector.h>

@interface AppDelegate ()<JPUSHRegisterDelegate>
@end

@implementation AppDelegate (CNCExtenison)

- (void)cnc_applyConfigurationWithOptions:(NSDictionary *)launchOptions {
    [self safeProtector];
    if (!IS_DEBUG)
        [self pgyConfig];
    [self networkConfig];
    [self keyboardConfig];
    [self jpushConfig:launchOptions];
    [self rootViewControllerConfig];
}

- (void)safeProtector {
    [LSSafeProtector openSafeProtectorWithIsDebug:IS_DEBUG block:^(NSException *exception, LSSafeProtectorCrashType crashType) {
        
    }];
    [LSSafeProtector setLogEnable:YES];
}

- (void)networkConfig {
    [DWNetworking setTimeoutInterval:30.f];
    [DWNetworking setAutoUseCache:NO];
    [DWNetworking setConfigRequestType:DWRequestTypeJSON responseType:DWResponseTypeJSON];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

- (void)keyboardConfig {
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

- (void)jpushConfig:(NSDictionary *)launchOptions {
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:kJPushKey
                          channel:@"App Store"
                 apsForProduction:(!IS_DEBUG)];
}

- (void)pgyConfig {
    [PgyManager sharedPgyManager].enableFeedback = NO;
    [[PgyManager sharedPgyManager] startManagerWithAppId:kPGYKey];
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:kPGYKey];
}

- (void)rootViewControllerConfig {
    self.window = UIWindow.alloc.init;
    self.window.rootViewController = CNCTabBarViewController.alloc.init;
    [self.window makeKeyAndVisible];
}

- (void)startAnimation {
    if (!CNCUserDefaultsBoolForKey(kCloseLaunchScreenAnimation)) {
        return;
    }
   UIView *launchScreenView = [[NSBundle mainBundle] loadNibNamed:@"LaunchScreen" owner:self options:nil].firstObject;
    launchScreenView.frame = self.window.bounds;
    [self.window addSubview:launchScreenView];
    [launchScreenView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (ISEqualToString(obj.restorationIdentifier, @"icon")) {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
            animation.duration = 2.25f;
            NSMutableArray *values = [NSMutableArray array];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
            [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(5.0, 5.0, 5.0)]];
            animation.values = values;
            [obj.layer addAnimation:animation forKey:nil];
            [UIView animateWithDuration:animation.duration animations:^{
                launchScreenView.alpha = .0f;
            } completion:^(BOOL finished) {
                [launchScreenView removeFromSuperview];
            }];
        }
    }];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler   API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert);
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    
    completionHandler();
}
#pragma clang diagnostic pop

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (!IS_DEBUG)
        [[PgyUpdateManager sharedPgyManager] checkUpdate];
    [JPUSHService resetBadge];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication].keyWindow.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIVisualEffectView class]]) {
            [obj removeFromSuperview];
        }
    }];
}

#pragma mark - 进入后台
- (void)applicationWillResignActive:(UIApplication *)application {
    [UIView animateWithDuration:0.25 animations:^{
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        visualEffectView.frame = [UIScreen mainScreen].bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:visualEffectView];
    }];
}

@end
