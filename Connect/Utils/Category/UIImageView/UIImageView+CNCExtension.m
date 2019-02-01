////  UIImageView+CNCExtension.m
//  Connect
//
//  Created by Dwang on 2018/9/26.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "UIImageView+CNCExtension.h"
#import <YYWebImage.h>

@implementation UIImageView (CNCExtension)
@dynamic url;
@dynamic placeholder;
@dynamic activity;
@dynamic cornerRadius;

- (void)setUrl:(NSString * _Nonnull)url {
    [self yy_setImageWithURL:[NSURL URLWithString:url] options:YYWebImageOptionProgressive];
}

- (void)setPlaceholder:(NSString *)placeholder {
    [self yy_setImageWithURL:[NSURL URLWithString:placeholder] placeholder:self.image];
}

- (void)setActivity:(NSString *)activity {
    if (!activity.isNotBlank) {
        self.image = UIImageMake(@"default");
        return;
    }
    [self layoutIfNeeded];
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:self.bounds];
    activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    __weak __typeof(self)weakSelf = self;
    [self yy_setImageWithURL:[NSURL URLWithString:activity] placeholder:self.image options:YYWebImageOptionProgressiveBlur completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        [activityIndicatorView stopAnimating];
        [activityIndicatorView removeFromSuperview];
        if (image) {
            weakSelf.image = image;
        }else {
            weakSelf.image = UIImageMake(@"default");
        }
    }];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

@end
