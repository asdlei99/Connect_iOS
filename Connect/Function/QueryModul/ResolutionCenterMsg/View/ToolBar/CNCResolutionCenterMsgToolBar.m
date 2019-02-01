////  CNCResolutionCenterMsgToolBar.m
//  Connect
//
//  Created by Dwang on 2018/10/7.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCResolutionCenterMsgToolBar.h"

@interface CNCResolutionCenterMsgToolBar ()

@property(nonatomic, strong) QMUIButton *lastBtn;

@end

@implementation CNCResolutionCenterMsgToolBar

- (void)loadView {
    NSArray <NSString *>*imgNames = @[@"返回", @"翻译",/* @"回复"*/];
    __weak __typeof(self)weakSelf = self;
    [imgNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        QMUIButton *btn = [[QMUIButton alloc] init];
//        btn.imagePosition = QMUIButtonImagePositionTop;
//        btn.spacingBetweenImageAndTitle = 2.5;
        [btn setImage:UIImageMake(obj) forState:UIControlStateNormal];
//        [btn setTitle:obj forState:UIControlStateNormal];
//        [btn setTitleColor:UIColorGray forState:UIControlStateNormal];
//        btn.titleLabel.font = UIFontMake(12);
        btn.tag = 100+idx;
        [btn addTarget:weakSelf action:@selector(cnc_toolbarDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [weakSelf addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            if (weakSelf.lastBtn) {
                make.left.equalTo(weakSelf.lastBtn.mas_right);
                make.width.equalTo(weakSelf.lastBtn);
            }else {
                make.left.equalTo(weakSelf.mas_left);
                make.width.equalTo(weakSelf.mas_width).dividedBy(imgNames.count);
            }
        }];
        weakSelf.lastBtn = btn;
        weakSelf.tools = [weakSelf.tools arrayByAddingObject:btn];
    }];
}

- (void)cnc_toolbarDidClick:(QMUIButton *)sender {
    if (self.cnc_toolBarDidClickCallBack) {
        self.cnc_toolBarDidClickCallBack(sender);
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(cnc_toolBarDidClick:)]) {
        [self.delegate cnc_toolBarDidClick:sender];
    }
}

- (NSArray<QMUIButton *> *)tools {
    if (!_tools) {
        _tools = [NSArray array];
    }
    return _tools;
}

@end
