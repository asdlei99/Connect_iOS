////  CNCResolutionCenterMsgToolBar.h
//  Connect
//
//  Created by Dwang on 2018/10/7.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CNCResolutionCenterMsgToolBarDelegate <NSObject>
//@optional
- (void)cnc_toolBarDidClick:(QMUIButton *_Nullable)sender;
@end

NS_ASSUME_NONNULL_BEGIN

@interface CNCResolutionCenterMsgToolBar : UIView

@property(nonatomic, copy) void (^cnc_toolBarDidClickCallBack)(QMUIButton *sender);

@property(nonatomic, weak) id <CNCResolutionCenterMsgToolBarDelegate>delegate;

@property(nonatomic, copy) NSArray<QMUIButton *> *tools;

@end

NS_ASSUME_NONNULL_END
