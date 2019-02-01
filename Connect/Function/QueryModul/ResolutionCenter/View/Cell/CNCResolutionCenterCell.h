////  CNCResolutionCenterCell.h
//  Connect
//
//  Created by Dwang on 2018/10/5.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "QMUITableViewCell.h"
@class YYLabel;

NS_ASSUME_NONNULL_BEGIN

@interface CNCResolutionCenterCell : QMUITableViewCell

/** 简述/概要 */
@property(nonatomic, strong) QMUILabel *summary;

/** 来源/作者 */
@property(nonatomic, strong) YYLabel *author;

@end

NS_ASSUME_NONNULL_END
