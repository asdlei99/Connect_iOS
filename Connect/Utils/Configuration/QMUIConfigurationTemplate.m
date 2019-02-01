////  QMUIConfigurationTemplate.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "QMUIConfigurationTemplate.h"

@implementation QMUIConfigurationTemplate

- (void)applyConfigurationTemplate {
    QMUICMI.clearColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
    QMUICMI.whiteColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    QMUICMI.blackColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    QMUICMI.grayColor = UIColorMake(179, 179, 179);
    QMUICMI.grayDarkenColor = UIColorMake(163, 163, 163);
    QMUICMI.grayLightenColor = UIColorMake(198, 198, 198);
    QMUICMI.redColor = UIColorMake(250, 58, 58);
    QMUICMI.greenColor = UIColorMake(159, 214, 97);
    QMUICMI.blueColor = UIColorMake(49, 189, 243);
    QMUICMI.yellowColor = UIColorMake(255, 207, 71);
    
    QMUICMI.linkColor = UIColorMake(56, 116, 171);
    QMUICMI.disabledColor = QMUICMI.grayColor;
    QMUICMI.backgroundColor = UIColor.groupTableViewBackgroundColor;
    QMUICMI.maskDarkColor = UIColorMakeWithRGBA(0, 0, 0, .35f);
    QMUICMI.maskLightColor = UIColorMakeWithRGBA(255, 255, 255, .5f);
    QMUICMI.separatorColor = UIColorMake(222, 224, 226);
    QMUICMI.separatorDashedColor = UIColorMake(17, 17, 17);
    QMUICMI.placeholderColor = UIColorMake(196, 200, 208);
    
    QMUICMI.testColorRed = UIColorMakeWithRGBA(255, 0, 0, .3);
    QMUICMI.testColorGreen = UIColorMakeWithRGBA(0, 255, 0, .3);
    QMUICMI.testColorBlue = UIColorMakeWithRGBA(0, 0, 255, .3);
    
#pragma mark - UIControl
    
    QMUICMI.controlHighlightedAlpha = 0.5f;
    QMUICMI.controlDisabledAlpha = 0.5f;
    
#pragma mark - UIButton
    
    QMUICMI.buttonHighlightedAlpha = QMUICMI.controlHighlightedAlpha;
    QMUICMI.buttonDisabledAlpha = QMUICMI.controlDisabledAlpha;
    QMUICMI.buttonTintColor = QMUICMI.blackColor;
    
    QMUICMI.ghostButtonColorBlue = QMUICMI.blueColor;
    QMUICMI.ghostButtonColorRed = QMUICMI.redColor;
    QMUICMI.ghostButtonColorGreen = QMUICMI.greenColor;
    QMUICMI.ghostButtonColorGray = QMUICMI.grayColor;
    QMUICMI.ghostButtonColorWhite = QMUICMI.whiteColor;
    
    QMUICMI.fillButtonColorBlue = QMUICMI.blueColor;
    QMUICMI.fillButtonColorRed = QMUICMI.redColor;
    QMUICMI.fillButtonColorGreen = QMUICMI.greenColor;
    QMUICMI.fillButtonColorGray = QMUICMI.grayColor;
    QMUICMI.fillButtonColorWhite = QMUICMI.whiteColor;
    
#pragma mark - UITextField & UITextView
    
    QMUICMI.textFieldTintColor = nil;
    QMUICMI.textFieldTextInsets = UIEdgeInsetsMake(0, 7, 0, 7);
    
#pragma mark - NavigationBar
    
    QMUICMI.navBarHighlightedAlpha = 0.2f;
    QMUICMI.navBarDisabledAlpha = 0.2f;
    QMUICMI.navBarButtonFont = nil;
    QMUICMI.navBarButtonFontBold = nil;
    QMUICMI.navBarBackgroundImage = [UIImage qmui_imageWithColor:UIColorClear];
    QMUICMI.navBarShadowImage = UIImage.new;
    QMUICMI.navBarBarTintColor = UIColorWhite;//UIColorHex(#7993DE)
    QMUICMI.navBarTintColor = UIColorBlack;//UIColorWhite
    QMUICMI.navBarTitleColor = nil;
    QMUICMI.navBarTitleFont = UIFontMake(20.f);
    QMUICMI.navBarLargeTitleColor = nil;
    QMUICMI.navBarLargeTitleFont = nil;
    QMUICMI.navBarBackButtonTitlePositionAdjustment = UIOffsetZero;
    QMUICMI.sizeNavBarBackIndicatorImageAutomatically = YES;
    QMUICMI.navBarBackIndicatorImage = nil;
    QMUICMI.navBarCloseButtonImage = [UIImage qmui_imageWithShape:QMUIImageShapeNavClose size:CGSizeMake(16, 16) tintColor:QMUICMI.navBarTintColor];
    
    QMUICMI.navBarLoadingMarginRight = 3;
    QMUICMI.navBarAccessoryViewMarginLeft = 5;
    QMUICMI.navBarActivityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    QMUICMI.navBarAccessoryViewTypeDisclosureIndicatorImage = [[UIImage qmui_imageWithShape:QMUIImageShapeTriangle size:CGSizeMake(8, 5) tintColor:QMUICMI.navBarTitleColor] qmui_imageWithOrientation:UIImageOrientationDown];
    
#pragma mark - TabBar
    
    QMUICMI.tabBarBackgroundImage = nil;
    QMUICMI.tabBarBarTintColor = nil;
    QMUICMI.tabBarShadowImageColor = nil;
    QMUICMI.tabBarTintColor = QMUICMI.navBarBarTintColor;
    QMUICMI.tabBarItemTitleColor = nil;
    QMUICMI.tabBarItemTitleColorSelected = QMUICMI.navBarBarTintColor;
    QMUICMI.tabBarItemTitleFont = nil;
    
#pragma mark - Toolbar
    
    QMUICMI.toolBarHighlightedAlpha = 0.4f;
    QMUICMI.toolBarDisabledAlpha = 0.4f;
    QMUICMI.toolBarTintColor = nil;
    QMUICMI.toolBarTintColorHighlighted = [QMUICMI.toolBarTintColor colorWithAlphaComponent:QMUICMI.toolBarHighlightedAlpha];
    QMUICMI.toolBarTintColorDisabled = [QMUICMI.toolBarTintColor colorWithAlphaComponent:QMUICMI.toolBarDisabledAlpha];
    QMUICMI.toolBarBackgroundImage = nil;
    QMUICMI.toolBarBarTintColor = nil;
    QMUICMI.toolBarShadowImageColor = nil;
    QMUICMI.toolBarButtonFont = nil;
    
#pragma mark - SearchBar
    
    QMUICMI.searchBarTextFieldBackground = nil;
    QMUICMI.searchBarTextFieldBorderColor = nil;
    QMUICMI.searchBarBottomBorderColor = nil;
    QMUICMI.searchBarBarTintColor = nil;
    QMUICMI.searchBarTintColor = nil;
    QMUICMI.searchBarTextColor = nil;
    QMUICMI.searchBarPlaceholderColor = QMUICMI.placeholderColor;
    QMUICMI.searchBarFont = nil;
    QMUICMI.searchBarSearchIconImage = nil;
    QMUICMI.searchBarClearIconImage = nil;
    QMUICMI.searchBarTextFieldCornerRadius = 2.0;
    
#pragma mark - TableView / TableViewCell
    
    QMUICMI.tableViewEstimatedHeightEnabled = YES;
    
    QMUICMI.tableViewBackgroundColor = nil;
    QMUICMI.tableViewGroupedBackgroundColor = nil;
    QMUICMI.tableSectionIndexColor = nil;
    QMUICMI.tableSectionIndexBackgroundColor = nil;
    QMUICMI.tableSectionIndexTrackingBackgroundColor = nil;
    QMUICMI.tableViewSeparatorColor = QMUICMI.separatorColor;
    
    QMUICMI.tableViewCellNormalHeight = UITableViewAutomaticDimension;
    QMUICMI.tableViewCellTitleLabelColor = nil;
    QMUICMI.tableViewCellDetailLabelColor = nil;
    QMUICMI.tableViewCellBackgroundColor = QMUICMI.whiteColor;
    QMUICMI.tableViewCellSelectedBackgroundColor = UIColorMake(238, 239, 241);
    QMUICMI.tableViewCellWarningBackgroundColor = QMUICMI.yellowColor;
    QMUICMI.tableViewCellDisclosureIndicatorImage = nil;
    QMUICMI.tableViewCellCheckmarkImage = nil;
    QMUICMI.tableViewCellDetailButtonImage = nil;
    QMUICMI.tableViewCellSpacingBetweenDetailButtonAndDisclosureIndicator = 12;
    
    QMUICMI.tableViewSectionHeaderBackgroundColor = UIColorMake(244, 244, 244);
    QMUICMI.tableViewSectionFooterBackgroundColor = UIColorMake(244, 244, 244);
    QMUICMI.tableViewSectionHeaderFont = UIFontBoldMake(12);
    QMUICMI.tableViewSectionFooterFont = UIFontBoldMake(12);
    QMUICMI.tableViewSectionHeaderTextColor = QMUICMI.grayDarkenColor;
    QMUICMI.tableViewSectionFooterTextColor = QMUICMI.grayColor;
    QMUICMI.tableViewSectionHeaderAccessoryMargins = UIEdgeInsetsMake(0, 15, 0, 0);
    QMUICMI.tableViewSectionFooterAccessoryMargins = UIEdgeInsetsMake(0, 15, 0, 0);
    QMUICMI.tableViewSectionHeaderContentInset = UIEdgeInsetsMake(4, 15, 4, 15);
    QMUICMI.tableViewSectionFooterContentInset = UIEdgeInsetsMake(4, 15, 4, 15);
    
    QMUICMI.tableViewGroupedSectionHeaderFont = UIFontMake(12);
    QMUICMI.tableViewGroupedSectionFooterFont = UIFontMake(12);
    QMUICMI.tableViewGroupedSectionHeaderTextColor = QMUICMI.grayDarkenColor;
    QMUICMI.tableViewGroupedSectionFooterTextColor = QMUICMI.grayColor;
    QMUICMI.tableViewGroupedSectionHeaderAccessoryMargins = UIEdgeInsetsMake(0, 15, 0, 0);
    QMUICMI.tableViewGroupedSectionFooterAccessoryMargins = UIEdgeInsetsMake(0, 15, 0, 0);
    QMUICMI.tableViewGroupedSectionHeaderDefaultHeight = UITableViewAutomaticDimension;
    QMUICMI.tableViewGroupedSectionFooterDefaultHeight = UITableViewAutomaticDimension;
    QMUICMI.tableViewGroupedSectionHeaderContentInset = UIEdgeInsetsMake(16, 15, 8, 15);
    QMUICMI.tableViewGroupedSectionFooterContentInset = UIEdgeInsetsMake(8, 15, 2, 15);
    
#pragma mark - UIWindowLevel
    QMUICMI.windowLevelQMUIAlertView = UIWindowLevelAlert - 4.0;
    QMUICMI.windowLevelQMUIImagePreviewView = UIWindowLevelStatusBar + 1;
    
#pragma mark - QMUILog
    QMUICMI.shouldPrintDefaultLog = YES;
    QMUICMI.shouldPrintInfoLog = YES;
    QMUICMI.shouldPrintWarnLog = YES;
    
#pragma mark - Others
    
    QMUICMI.supportedOrientationMask = UIInterfaceOrientationMaskPortrait;
    QMUICMI.automaticallyRotateDeviceOrientation = NO;
    QMUICMI.statusbarStyleLightInitially = NO;
    QMUICMI.needsBackBarButtonItemTitle = NO;
    QMUICMI.hidesBottomBarWhenPushedInitially = NO;
    QMUICMI.preventConcurrentNavigationControllerTransitions = YES;
    QMUICMI.navigationBarHiddenInitially = NO;
    QMUICMI.shouldFixTabBarTransitionBugInIPhoneX = NO;
}

- (BOOL)shouldApplyTemplateAutomatically {
    return YES;
}

@end
