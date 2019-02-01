////  CNCCollectionNormalCell.m
//  Connect
//
//  Created by Dwang on 2018/10/19.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCCollectionNormalCell.h"

@interface CNCCollectionNormalCell ()

@property(nonatomic, strong) UIView *bgView;

@end

@implementation CNCCollectionNormalCell

- (void)setCellINFO {
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = self.backgroundColor;
    self.selectedBackgroundView = self.bgView;
    self.backgroundColor = UIColorWhite;
    self.layer.cornerRadius = 10.f;
    self.layer.masksToBounds = YES;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (self.animated) {
        __weak __typeof(self)weakSelf = self;
        [UIView animateWithDuration:.3f animations:^{
            if (highlighted) {
                weakSelf.transform = CGAffineTransformMakeScale(0.95, 0.95);
            }else {
                weakSelf.transform = CGAffineTransformIdentity;
            }
        }];
    }
}

@end
