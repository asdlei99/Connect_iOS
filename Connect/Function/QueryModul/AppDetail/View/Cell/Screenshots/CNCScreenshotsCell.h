////  CNCScreenshotsCell.h
//  Connect
//
//  Created by iizvv on 2018/11/27.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "QMUITableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CNCScreenshotsCell : QMUITableViewCell

/** 标题 */
@property(nonatomic, copy) NSArray<NSString *> *titles;

/** 下载地址 */
@property(nonatomic, copy) NSArray<NSArray <NSString *>*> *imgUrls;

@end

NS_ASSUME_NONNULL_END
