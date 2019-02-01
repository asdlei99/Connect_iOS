////  CNCAnimationLabel.h
//  Connect
//
//  Created by Dwang on 2018/9/20.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCAnimationLabel : UIView

/** 内容是否填充 */
@property(nonatomic, assign) BOOL fill;

/** 线宽 */
@property(nonatomic, assign) CGFloat lineWidth;

/** 字体大小 */
@property(nonatomic, assign) CGFloat fontSize;

/** 渲染颜色 */
@property(nonatomic, strong) UIColor *strokeColor;

/** 文本内容 */
@property(nonatomic, copy) NSString *text;

@end

NS_ASSUME_NONNULL_END
