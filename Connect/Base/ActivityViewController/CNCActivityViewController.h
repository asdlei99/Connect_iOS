////  CNCActivityViewController.h
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CNCActivityViewController : UIActivityViewController

/** 实测中发现，当执行viewDidLoad之后ActivityViewController视图才出现，所以在viewDidLoad中将HUD取消才是最佳时机 */
@property(nonatomic, copy) void (^dismissHUD)(void);

@end
