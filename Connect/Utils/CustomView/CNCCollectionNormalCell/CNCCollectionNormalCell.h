////  CNCCollectionNormalCell.h
//  Connect
//
//  Created by Dwang on 2018/10/19.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNCCollectionNormalCell : UICollectionViewCell

- (void)setCellINFO;

/** 是否使用按压动画 */
@property(nonatomic, assign) BOOL animated;

@end

NS_ASSUME_NONNULL_END