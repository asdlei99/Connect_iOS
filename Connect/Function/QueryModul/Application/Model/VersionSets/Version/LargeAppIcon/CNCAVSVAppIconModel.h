////  CNCAVSVAppIconModel.h
//  Connect
//
//  Created by Dwang on 2018/9/26.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCAVSVAppIconModel : NSObject

/** 令牌 */
@property(nonatomic, copy, readonly) NSString *assetToken;

/** 500*500像素 */
@property(nonatomic, copy, readonly) NSString *url;

/** 340*340像素 */
@property(nonatomic, copy, readonly) NSString *thumbNailUrl;

@end

NS_ASSUME_NONNULL_END
