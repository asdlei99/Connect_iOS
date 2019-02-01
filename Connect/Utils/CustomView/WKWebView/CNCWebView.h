////  CNCWebView.h
//  Connect
//
//  Created by Dwang on 2018/9/23.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCWebView : UIView

/**
 初始化

 @param urlString 请求地址
 @return self
 */
- (instancetype)initWithRequestURLString:(NSString *)urlString;

/**
 初始化

 @param htmlString 加载的html
 @return self
 */
- (instancetype)initWithHtmlString:(NSString *)htmlString;

@end

NS_ASSUME_NONNULL_END
