////  CNCAccountManagerCell.h
//  Connect
//
//  Created by Dwang on 2018/9/8.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCCollectionNormalCell.h"

@interface CNCAccountManagerCell : CNCCollectionNormalCell

/** 邮箱 */
@property(nonatomic, strong) QMUILabel *emailLabel;

/** 备注 */
@property(nonatomic, strong) QMUILabel *markLabel;

/** 创建时间 */
@property(nonatomic, strong) QMUILabel *createTimeLabel;

/** 删除账号 */
@property(nonatomic, strong) QMUIButton *deleteBtn;

/** 分享 */
@property(nonatomic, strong) QMUIButton *shareBtn;

@end
