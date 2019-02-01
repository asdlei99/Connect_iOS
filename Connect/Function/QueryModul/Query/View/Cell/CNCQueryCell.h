////  CNCQueryCell.h
//  Connect
//
//  Created by Dwang on 2018/9/10.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCCollectionNormalCell.h"

@interface CNCQueryCell : CNCCollectionNormalCell

/** 开发者账号 */
@property(nonatomic, strong) QMUILabel *emailLabel;

/** 备注 */
@property(nonatomic, strong) QMUILabel *markLabel;

/** 最后操作标示 */
@property(nonatomic, strong) UIImageView *lastQuery;

@end
