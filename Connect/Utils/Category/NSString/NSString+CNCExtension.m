////  NSString+CNCExtension.m
//  Connect
//
//  Created by Dwang on 2018/10/6.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "NSString+CNCExtension.h"

@implementation NSString (CNCExtension)
@dynamic trimAllHtmlTag;

- (NSString *)trimAllHtmlTag {
    NSString *string = [self stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    NSRegularExpression *regularExpretion = [NSRegularExpression regularExpressionWithPattern:kHTMLTagRegular options:0 error:nil];
    string = [regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    return string;
}

- (NSMutableAttributedString *)cnc_attributeStrings:(NSArray<NSString *> *)strings colors:(NSArray <UIColor *> *)colors {
    __weak __typeof(self)weakSelf = self;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:self];
    [strings enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [attrString addAttribute:NSForegroundColorAttributeName
                           value:colors.count==1?colors[0]:colors[idx]
                           range:[weakSelf rangeOfString:obj]];
    }];
    return attrString;
}

@end
