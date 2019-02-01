////  CNCCreateAccountCell.h
//  Connect
//
//  Created by Dwang on 2018/9/5.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "QMUITableViewCell.h"

@interface CNCCreateAccountCell : QMUITableViewCell

/** 标题 */
@property(nonatomic, strong) QMUILabel *title;

/** 内容 */
@property(nonatomic, strong) QMUITextField *content;

/** 下划线 */
@property(nonatomic, strong) UIView *line;

@end
