////  CNCAppDetailHeaderView.h
//  Connect
//
//  Created by iizvv on 2018/11/21.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCAppDetailHeaderView : UIView

/** icon */
@property(nonatomic, strong) UIImageView *icon;

/** appName */
@property(nonatomic, strong) QMUILabel *appName;

/** 状态 */
@property(nonatomic, strong) UIView *status;

/** 版本 */
@property(nonatomic, strong) QMUILabel *version;

/** 介绍 */
@property(nonatomic, strong) QMUIButton *desc;

@end

NS_ASSUME_NONNULL_END
