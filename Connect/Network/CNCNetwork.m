////  CNCNetwork.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCNetwork.h"
#import <DWNetworking.h>
#import "CNCNotification.h"

@implementation CNCNetwork

/** 设置开发者中心登录求头 */
+ (void)cnc_setAppleDevSiginHeader {
    [DWNetworking setHttpHeaderConfig:@{@"Accept":@"application/json, text/javascript, */*; q=0.01",
                                        @"Accept-Encoding":@"gzip, deflate, br",
                                        @"Accept-Language":@"zh-CN,zh;q=0.9",
                                        @"Connection":@"keep-alive",
                                        @"Content-Type":@"application/json",
                                        @"Host":@"idmsa.apple.com",
                                        @"Origin":@"https://idmsa.apple.com",
                                        @"Referer":@"https://idmsa.apple.com/appleauth/auth/signin?widgetKey=e0b80c3bf78523bfe80974d320935bfa30add02e1bff88ec2166c6bd5a706c42&widgetDomain=https://appstoreconnect.apple.com:443&font=sf",
                                        @"X-Apple-Widget-Key":@"e0b80c3bf78523bfe80974d320935bfa30add02e1bff88ec2166c6bd5a706c42",
                                        @"X-Requested-With":@"XMLHttpRequest",
                                        }];
}

/** 设置查询应用状态请求头 */
+ (void)cnc_setQueryApplicationStatusHeaderHeader {
    [DWNetworking setHttpHeaderConfig:@{@"Accept":@"application/json, text/plain, */*",
                                        @"Accept-Encoding":@"gzip, deflate, br",
                                        @"Accept-Language":@"zh-CN,zh;q=0.9",
                                        @"Connection":@"keep-alive",
                                        @"Referer":@"https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app",
                                        @"x-csrf-itc":@"itc"
                                        }];
}

/** POST */
+ (void)postUrl:(NSString *)url params:(NSDictionary *)params callBack:(void(^)(id success))callBack {
    [DWNetworking postUrlString:url params:params resultCallBack:^(id success, NSError *error, BOOL isCache) {
        if (error) {
            [self cnc_requestError:error];
        }else {
            callBack(success);
        }
    }];
}

/** GET */
+ (void)getUrl:(NSString *)url callBack:(void(^)(id success))callBack {
    [self getUrl:url params:@{} callBack:^(id success) {
        if (callBack) {
            callBack(success);
        }
    }];
}

+ (void)getUrl:(NSString *)url params:(NSDictionary *)params callBack:(void(^)(id success))callBack {
    [DWNetworking getUrlString:url params:params resultCallBack:^(id success, NSError *error, BOOL isCache) {
        if (error) {
            [self cnc_requestError:error];
        }else {
            callBack(success);
        }
    }];
}

/** 请求失败 */
+ (void)cnc_requestError:(NSError *)error {
    NSLog(@"%@", error);
    //当错误码为3840,且错误的请求地址为查询状态地址时则认为cookie失效,需要重新请求登录接口
    if (error.code == 3840 &&
        [error.userInfo.description containsString:appleApplicationStatusUrlHost]) {
        [CNCNotification cnc_postNotificationName:kREQUESTQUERYAPPLICATIONERRORCALLBACK];
    }else {
        [CNCNotification cnc_postNotificationName:kREQUESTERROR object:error.userInfo[@"NSLocalizedDescription"]];
    }
}

@end
