////  CNCIgnoreAppsCell.h
//  Connect
//
//  Created by Dwang on 2018/9/29.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "QMUITableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CNCIgnoreAppsCell : QMUITableViewCell

/** icon */
@property(nonatomic, strong) UIImageView *appIcon;

/** 名称 */
@property(nonatomic, strong) QMUILabel *appName;

/** 创建时间 */
@property(nonatomic, strong) QMUILabel *createTime;

@property(nonatomic, strong) QMUILabel *account;

@end

NS_ASSUME_NONNULL_END
