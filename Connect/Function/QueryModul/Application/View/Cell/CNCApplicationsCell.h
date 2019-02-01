////  CNCApplicationsCell.h
//  Connect
//
//  Created by Dwang on 2018/10/18.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCCollectionNormalCell.h"
#import <Somo.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCApplicationsCell : CNCCollectionNormalCell<SomoSkeletonLayoutProtocol>

/** 是否使用Skeleton */
@property(nonatomic, assign) BOOL shouldLoading;

/** 应用logo */
@property(nonatomic, strong) UIImageView *appIcon;

/** 应用名称 */
@property(nonatomic, strong) QMUILabel *appName;

/** 最后操作时间 */
@property(nonatomic, strong) QMUIButton *lastTime;

/** 应用版本1 */
@property(nonatomic, strong) QMUILabel *appVersion1;

/** 应用版本状态指示器1 */
@property(nonatomic, strong) UIView *appVerison1Activity;

/** 应用版本1按钮 */
@property(nonatomic, strong) QMUIButton *apv1;

/** 应用版本2 */
@property(nonatomic, strong) QMUILabel *appVersion2;

/** 应用版本状态指示器2 */
@property(nonatomic, strong) UIView *appVerison2Activity;

/** 应用版本2按钮 */
@property(nonatomic, strong) QMUIButton *apv2;

/** 忽略/隐藏此App */
@property(nonatomic, strong) QMUIButton *ignore;

@end

NS_ASSUME_NONNULL_END
