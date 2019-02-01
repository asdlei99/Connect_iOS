////  CNCWebView.m
//  Connect
//
//  Created by Dwang on 2018/9/23.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCWebView.h"
#import <WebKit/WebKit.h>

@interface CNCWebView ()<WKNavigationDelegate>

@property(nonatomic, strong) WKWebView *webView;

@property(nonatomic, strong) UIProgressView *progressView;

@end

@implementation CNCWebView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = UIColorWhite;
    }
    return self;
}

- (instancetype)initWithRequestURLString:(NSString *)urlString {
    self = [super init];
    if (self) {
        [self loadRequestURLString:urlString];
    }
    return self;
}

- (instancetype)initWithHtmlString:(NSString *)htmlString {
    self = [super init];
    if (self) {
        [self loadHtmlString:htmlString];
    }
    return self;
}

- (void)loadRequestURLString:(NSString *)urlString {
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
    [self addSubview:self.webView];
}

- (void)loadHtmlString:(NSString *)htmlString {
    [self.webView loadHTMLString:htmlString baseURL:nil];
    [self addSubview:self.webView];
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
    NSLog(@"开始加载");
    if (![webView.backForwardList.currentItem.URL.absoluteString isEqualToString:webView.URL.absoluteString]) {
        self.progressView.hidden = NO;
        self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败");
    [webView reload];
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    if([[navigationAction.request.URL host] isEqualToString:@"itunes.apple.com"] &&
       [[UIApplication sharedApplication] canOpenURL:navigationAction.request.URL]) {
        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:UIScreen.mainScreen.bounds];
        _webView.navigationDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES;
        _webView.backgroundColor = self.backgroundColor;
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _webView;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 2)];
        _progressView.backgroundColor = UIColorClear;
        _progressView.progressTintColor = UIColorGreen;
        _progressView.trackTintColor = UIColorClear;
        _progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
        [self.webView addSubview:_progressView];
    }
    return _progressView;
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
