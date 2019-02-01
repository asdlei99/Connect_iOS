////  CNCQCLoginView.h
//  Connect
//
//  Created by Dwang on 2018/9/21.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCQCLoginView : UIView

/** 点击了登录按钮 */
@property(nonatomic, copy) void (^cnc_siginDidClick)(NSDictionary *params);

@end

NS_ASSUME_NONNULL_END
