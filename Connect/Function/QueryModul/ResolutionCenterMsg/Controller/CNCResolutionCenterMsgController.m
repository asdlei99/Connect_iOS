////  CNCResolutionCenterMsgController.m
//  Connect
//
//  Created by Dwang on 2018/10/7.
//    QQ群:    577506623
//    GitHub:    https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCResolutionCenterMsgController.h"
#import "CNCResolutionCenterMsgToolBar.h"
#import "CNCActivityViewController.h"
#import "CNCReplyController.h"
#import <WebKit/WebKit.h>
#import "CNCReplyModel.h"
#import "CNCTranslateModel.h"
#import "CNCSentencesModel.h"

//#define HORIZONTAL_SPACE 30//水平间距
//#define VERTICAL_SPACE 50//竖直间距
//#define CG_TRANSFORM_ROTATION (M_PI_2 / 3)//旋转角度(正旋45度 || 反旋45度)

@interface CNCResolutionCenterMsgController ()<WKNavigationDelegate, WKUIDelegate, CNCResolutionCenterMsgToolBarDelegate>

@property(nonatomic, strong) WKWebView *webView;

@property(nonatomic, strong) UIProgressView *progressView;

@property(nonatomic, strong) CNCResolutionCenterMsgToolBar *toolBar;

@property(nonatomic, copy) NSString *tempHtmlString;

@property(nonatomic, strong) CNCReplyModel *model;

@property(nonatomic, strong) CNCTranslateModel *translate;

@end

@implementation CNCResolutionCenterMsgController

- (void)didInitialize {
    [super didInitialize];
    self.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setUI {
    self.view.backgroundColor = UIColorWhite;
    if (ISEqualToString(self.author, @"Apple") ||
        [self.htmlString containsString:@"<br/>"]) {
        self.tempHtmlString = self.htmlString;
    }else {
        self.tempHtmlString = [self.htmlString stringByReplacingOccurrencesOfString:@"\n" withString:@"<br/>&nbsp;&nbsp;"];
    }
    self.tempHtmlString = [NSString stringWithFormat:@"<html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no\"></head><body>%@</body></html>", self.tempHtmlString];
    [self.webView loadHTMLString:self.tempHtmlString baseURL:[NSURL URLWithString:wkBaseUrl]];
    [self.view addSubview:self.webView];
    CGFloat bottomMargin = 52.f;
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-bottomMargin);
        } else {
            make.top.equalTo(self.view.mas_top);
            make.bottom.equalTo(self.view.mas_bottom).offset(-bottomMargin);
        }
        make.left.equalTo(self.view.mas_left).offset(10);
        make.right.equalTo(self.view.mas_right).offset(-10);
    }];
    [self.view addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.webView);
        make.height.mas_offset(1);
    }];
    [self.view addSubview:self.toolBar];
    [self.toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.webView.mas_bottom);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(self.view.mas_bottom);
        }
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    if (![webView.backForwardList.currentItem.URL.absoluteString isEqualToString:webView.URL.absoluteString]) {
        self.progressView.hidden = NO;
        self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
        [self.view bringSubviewToFront:self.progressView];
        [self.toastView showLoading];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.toastView hideAnimated:YES];
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.toastView showError:@"加载失败" hideAfterDelay:2.25f];
    __weak __typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.25f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (weakSelf.webView.canGoBack) {
            [weakSelf.webView goBack];
        }else {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    });
}

- (void)cnc_toolBarDidClick:(QMUIButton *)sender {
    switch (sender.tag) {
        case 100:{
            if (self.webView.title.isNotBlank && !self.webView.canGoBack) {
                [self.webView loadHTMLString:self.tempHtmlString baseURL:[NSURL URLWithString:wkBaseUrl]];
            }else if (self.webView.canGoBack) {
                [self.webView goBack];
            }else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }break;
        case 101:{
            [self.toastView showLoading];
            __weak __typeof(self)weakSelf = self;
            [self.translate cnc_translateWithString:self.htmlString callBack:^(NSString *htmlString) {
                [weakSelf.toastView hideAnimated:YES];
                QMUIDialogViewController *translate = [[QMUIDialogViewController alloc] init];
                translate.title = @"翻译";
                WKWebView *webView = [[WKWebView alloc] qmui_initWithSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
                webView.backgroundColor = UIColorWhite;
                webView.scrollView.showsVerticalScrollIndicator = NO;
//                webView.UIDelegate = self;
//                webView.navigationDelegate = self;
                [webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:wkBaseUrl]];
                translate.contentView = webView;
                translate.contentViewMargins = UIEdgeInsetsMake(10, 10, 10, 10);
                [translate addCancelButtonWithText:@"取消" block:nil];
                [translate show];
            }];
        }break;
        case 102:{
            QMUIDialogViewController *replyDialog = [[QMUIDialogViewController alloc] init];
            replyDialog.title = @"回复反馈";
            UIView *replyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 130)];
            QMUITextView *reply = [[QMUITextView alloc] qmui_initWithSize:replyView.size];
            reply.font = UIFontMake(16);
            reply.placeholder = @"请在此处输入想要反馈的内容";
            [replyView addSubview:reply];
            replyDialog.contentView = replyView;
            [replyDialog addCancelButtonWithText:@"取消" block:nil];
            [replyDialog addSubmitButtonWithText:@"发送" block:^(__kindof QMUIDialogViewController *aDialogViewController) {
                
            }];
            [replyDialog showWithAnimated:YES completion:^(BOOL finished) {
                [reply becomeFirstResponder];
            }];
        }break;
        default:
            break;
    }
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    UIPreviewAction *cancel = [UIPreviewAction actionWithTitle:@"取消" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {}];
    //    __weak __typeof(self)weakSelf = self;;
    //    UIPreviewAction *push = [UIPreviewAction actionWithTitle:@"查看完整内容" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
    //
    //    }];
    return @[cancel];
}

- (WKWebView *)webView {
    if (!_webView) {
        NSMutableString *javascript = [NSMutableString string];
        //        [javascript appendString:@"document.documentElement.style.webkitTouchCallout='none';"];//禁止长按
        //        [javascript appendString:@"document.documentElement.style.webkitUserSelect='none';"];//禁止选择
        WKUserContentController *userContentController = [[WKUserContentController alloc] init];
        WKUserScript *script = [[WKUserScript alloc] initWithSource:javascript injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:YES];
        [userContentController addUserScript:script];
        WKProcessPool *processPool = [[WKProcessPool alloc] init];
        WKWebViewConfiguration *webViewController = [[WKWebViewConfiguration alloc] init];
        webViewController.processPool = processPool;
        webViewController.allowsInlineMediaPlayback = YES;
        webViewController.userContentController = userContentController;
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:webViewController];
        _webView.backgroundColor = self.view.backgroundColor;
        _webView.scrollView.backgroundColor = _webView.backgroundColor;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES;
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
        _progressView.backgroundColor = UIColorClear;
        _progressView.progressTintColor = UIColorGreen;
        _progressView.trackTintColor = UIColorClear;
        _progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    }
    return _progressView;
}

- (CNCResolutionCenterMsgToolBar *)toolBar {
    if (!_toolBar) {
        _toolBar = [[CNCResolutionCenterMsgToolBar alloc] init];
        _toolBar.delegate = self;
        _toolBar.tools.lastObject.enabled = self.reply;
    }
    return _toolBar;
}

- (CNCReplyModel *)model {
    if (!_model) {
        _model = [[CNCReplyModel alloc] init];
    }
    return _model;
}

- (CNCTranslateModel *)translate {
    if (!_translate) {
        _translate = [[CNCTranslateModel alloc] init];
    }
    return _translate;
}

- (BOOL)preferredNavigationBarHidden {
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end

