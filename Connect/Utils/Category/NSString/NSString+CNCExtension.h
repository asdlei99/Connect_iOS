////  NSString+CNCExtension.h
//  Connect
//
//  Created by Dwang on 2018/10/6.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (CNCExtension)

/** 去除html标签后的字符串 */
@property(nonatomic, copy, readonly) NSString *trimAllHtmlTag;

/**
 不同颜色的字体

 @param strings 查找的字符
 @param colors 使用的颜色
 @return 富文本
 */
- (NSMutableAttributedString *)cnc_attributeStrings:(NSArray<NSString *> *)strings colors:(NSArray <UIColor *> *)colors;

@end

NS_ASSUME_NONNULL_END
