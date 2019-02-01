////  CNCTranslateModel.h
//  Connect
//
//  Created by iizvv on 2018/11/28.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCTranslateModel : NSObject

- (void)cnc_translateWithString:(NSString *)string callBack:(void (^)(NSString *htmlString))sentences;

@end

NS_ASSUME_NONNULL_END