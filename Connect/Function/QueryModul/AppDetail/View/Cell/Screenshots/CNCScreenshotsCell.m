////  CNCScreenshotsCell.m
//  Connect
//
//  Created by iizvv on 2018/11/27.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCScreenshotsCell.h"
#import <YYWebImage.h>
#import <KSPhotoBrowser.h>

@interface CNCScreenshotsCell ()

/** 标题view */
@property(nonatomic, strong) UIScrollView *titleScroller;

@property(nonatomic, strong) UIScrollView *imgScroller;

@end

@implementation CNCScreenshotsCell

- (void)setCellINFO {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.titleScroller];
    [self.titleScroller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.mas_offset(34);
    }];
    [self.contentView addSubview:self.imgScroller];
    [self.imgScroller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleScroller.mas_bottom);
        make.left.right.equalTo(self.titleScroller);
        make.height.mas_offset(350);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    CGFloat width = 100;
    [self.titleScroller removeAllSubviews];
    [self.titleScroller setContentSize:CGSizeMake(titles.count*width, 0)];
    __weak __typeof(self)weakSelf = self;
    __block QMUIButton *temp = nil;
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QMUIButton *sender = [[QMUIButton alloc] init];
        sender.tag = 100+idx;
        [sender setTitle:obj forState:UIControlStateNormal];
        sender.titleLabel.font = UIFontMake(14);
        [weakSelf.titleScroller addSubview:sender];
        [sender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(weakSelf.titleScroller.mas_height);
            make.width.mas_offset(width);
            if (!temp) {
                make.left.equalTo(weakSelf.titleScroller.mas_left);
            }else {
                make.left.equalTo(temp.mas_right);
            }
        }];
        [sender addBlockForControlEvents:UIControlEventTouchUpInside block:^(QMUIButton *sender) {
            [weakSelf setUrl:weakSelf.imgUrls[sender.tag-100]];
        }];
        temp = sender;
    }];
}

- (void)setImgUrls:(NSArray<NSArray<NSString *> *> *)imgUrls {
    _imgUrls = imgUrls;
    [self setUrl:imgUrls[0]];
}

- (void)setUrl:(NSArray <NSString *>*)urls {
    CGFloat width = 220;
    __weak __typeof(self)weakSelf = self;
    [self.imgScroller removeAllSubviews];
    [self.imgScroller setContentSize:CGSizeMake(urls.count*width+urls.count*5+15, 0)];
    __block UIImageView *temp = nil;
    NSMutableArray <KSPhotoItem *>*items = [NSMutableArray array];
    [urls enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView *img = [[UIImageView alloc] init];
        img.backgroundColor = UIColorBlack;
        img.userInteractionEnabled = YES;
        img.contentMode = UIViewContentModeScaleAspectFit;
        img.tag = idx+100;
        img.url = obj;
        [weakSelf.imgScroller addSubview:img];
        [items addObject:[KSPhotoItem itemWithSourceView:img imageUrl:[NSURL URLWithString:obj]]];
        [img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(UITapGestureRecognizer *sender) {
            KSPhotoBrowser *browser = [KSPhotoBrowser browserWithPhotoItems:items selectedIndex:sender.view.tag-100];
            [browser showFromViewController:weakSelf.viewController];
        }]];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.imgScroller.mas_top);
            make.height.mas_offset(340);
            make.width.mas_offset(width);
            if (!temp) {
                make.left.equalTo(weakSelf.imgScroller.mas_left).offset(15);
            }else {
                make.left.equalTo(temp.mas_right).offset(5);
            }
        }];
        temp = img;
    }];
}

- (UIScrollView *)titleScroller {
    if (!_titleScroller) {
        _titleScroller = [[UIScrollView alloc] init];
        _titleScroller.showsHorizontalScrollIndicator = NO;
    }
    return _titleScroller;
}

- (UIScrollView *)imgScroller {
    if (!_imgScroller) {
        _imgScroller = [[UIScrollView alloc] init];
        _imgScroller.showsHorizontalScrollIndicator = NO;
    }
    return _imgScroller;
}

@end
