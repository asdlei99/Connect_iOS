////  CNCNetwork.h
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CNCNetwork : NSObject

/** 设置开发者中心登录请求头 */
+ (void)cnc_setAppleDevSiginHeader;

/** 设置开发者中心查询请求头 */
+ (void)cnc_setQueryApplicationStatusHeaderHeader;

/**
 POST

 @param url 请求地址
 @param params 请求参数
 @param callBack 返回结果
 */
+ (void)postUrl:(NSString *)url params:(NSDictionary *)params callBack:(void(^)(id success))callBack;

/**
 GET

 @param url 请求地址
 @param callBack 返回结果
 */
+ (void)getUrl:(NSString *)url callBack:(void(^)(id success))callBack;

+ (void)getUrl:(NSString *)url params:(NSDictionary *)params callBack:(void(^)(id success))callBack;

@end
