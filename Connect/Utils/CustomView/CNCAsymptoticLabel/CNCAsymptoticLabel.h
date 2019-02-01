////  CNCAsymptoticLabel.h
//  Connect
//
//  Created by Dwang on 2018/9/21.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCAsymptoticLabel : UILabel

/** 需要显示的内容 */
@property(nonatomic, copy) NSString *message;

/** 停顿时间 */
@property(nonatomic, assign) CGFloat timeInterval;

/** 启动 */
- (void)cnc_show;

/** 文字显示完成 */
@property(nonatomic, copy) void (^cnc_endCallBack)(CNCAsymptoticLabel *asymptoticLabel);

@end

NS_ASSUME_NONNULL_END
