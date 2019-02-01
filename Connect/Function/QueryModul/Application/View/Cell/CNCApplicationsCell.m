////  CNCApplicationsCell.m
//  Connect
//
//  Created by Dwang on 2018/10/18.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCApplicationsCell.h"
#import "UIView+CNCExtension.h"

@implementation CNCApplicationsCell

- (void)setCellINFO {
    [super setCellINFO];
    self.appIcon = [[UIImageView alloc] initWithImage:UIImageMake(@"default")];
    [self.contentView addSubview:self.appIcon];
    [self.appIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.mas_left).offset(15);
        make.size.equalTo(self.contentView.mas_height).offset(-10);
    }];
    self.appIcon.cornerRadius = 10.f;
    
    self.appName = [[QMUILabel alloc] init];
    self.appName.font = UIFontMake(18);
    [self.contentView addSubview:self.appName];
    [self.appName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.appIcon.mas_top).offset(2.5);
        make.left.equalTo(self.appIcon.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    self.lastTime = [[QMUIButton alloc] init];
    self.lastTime.titleLabel.font = UIFontMake(14);
    [self.lastTime setTitleColor:UIColorGrayLighten forState:UIControlStateNormal];
    [self.contentView addSubview:self.lastTime];
    [self.lastTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.appIcon.mas_centerY).offset(2.5);
        make.left.equalTo(self.appName.mas_left);
    }];
    
    self.appVerison1Activity = [[UIView alloc] init];
    [self.contentView addSubview:self.appVerison1Activity];
    [self.appVerison1Activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(10);
        make.left.equalTo(self.lastTime.mas_left);
        make.bottom.equalTo(self.appIcon.mas_bottom).offset(-5);
    }];
    self.appVerison1Activity.round = YES;
    
    
    self.appVersion1 = [[QMUILabel alloc] init];
    self.appVersion1.textColor = UIColorGray;
    self.appVersion1.font = UIFontMake(12);
    [self.contentView addSubview:self.appVersion1];
    [self.appVersion1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.appVerison1Activity.mas_right).offset(5);
        make.centerY.equalTo(self.appVerison1Activity);
    }];
    
    self.apv1 = [[QMUIButton alloc] init];
    [self.contentView addSubview:self.apv1];
    [self.apv1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.appVerison1Activity);
        make.right.equalTo(self.appVersion1.mas_right);
        make.bottom.equalTo(self.contentView);
    }];
    
    self.appVerison2Activity = [[UIView alloc] init];
    [self.contentView addSubview:self.appVerison2Activity];
    [self.appVerison2Activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.appVerison1Activity);
        make.left.equalTo(self.appVersion1.mas_right).offset(20);
        make.centerY.equalTo(self.appVersion1.mas_centerY);
    }];
    self.appVerison2Activity.round = YES;
    
    self.appVersion2 = [[QMUILabel alloc] init];
    self.appVersion2.textColor = UIColorGray;
    self.appVersion2.font = UIFontMake(12);
    [self.contentView addSubview:self.appVersion2];
    [self.appVersion2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.appVerison2Activity.mas_right).offset(5);
        make.centerY.equalTo(self.appVerison2Activity);
    }];
    self.apv2 = [[QMUIButton alloc] init];
    [self.contentView addSubview:self.apv2];
    [self.apv2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.appVerison2Activity);
        make.right.equalTo(self.appVersion2.mas_right);
        make.top.bottom.equalTo(self.apv1);
    }];
    
    self.ignore = [[QMUIButton alloc] init];
    [self.ignore setImage:UIImageMake(@"delete") forState:UIControlStateNormal];
    [self.contentView addSubview:self.ignore];
    [self.ignore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.size.mas_offset(self.ignore.currentImage.size);
    }];
    
}

- (void)setShouldLoading:(BOOL)shouldLoading {
    _shouldLoading = shouldLoading;
    if (!shouldLoading) {
        [self beginSomo];
    }else {
        [self endSomo];
    }
}

- (NSArray<SomoView *> *)somoSkeletonLayout {
    [self layoutIfNeeded];
    SomoView *s0 = [[SomoView alloc] initWithFrame:CGRectMake(15, 10, self.height-20, self.height-20) somoColor:UIColorGray animationStyle:SomoAnimationStyleGradientHorizontal];
    SomoView *s1 = [[SomoView alloc] initWithFrame:CGRectMake(s0.right+10, s0.top+2.5, 200, 15) somoColor:UIColorGray animationStyle:SomoAnimationStyleGradientHorizontal];
    SomoView *s2 = [[SomoView alloc] initWithFrame:CGRectMake(s1.left, s0.centerY-8, 100, 15) somoColor:UIColorGrayLighten animationStyle:SomoAnimationStyleGradientHorizontal];
    SomoView *s3 = [[SomoView alloc] initWithFrame:CGRectMake(s1.left, s0.bottom-17, 50, 15) somoColor:UIColorGray animationStyle:SomoAnimationStyleGradientHorizontal];
    return @[s0,s1,s2,s3];
}

@end
