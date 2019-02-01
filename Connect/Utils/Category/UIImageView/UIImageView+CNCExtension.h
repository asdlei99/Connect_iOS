////  UIImageView+CNCExtension.h
//  Connect
//
//  Created by Dwang on 2018/9/26.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (CNCExtension)

/** 渐进 */
@property(nonatomic, copy) NSString *url;

/** 默认图 */
@property(nonatomic, copy) NSString *placeholder;

/** 活动指示器 */
@property(nonatomic, copy) NSString *activity;

/** 圆角 */
@property(nonatomic, assign) CGFloat cornerRadius;

@end

NS_ASSUME_NONNULL_END
