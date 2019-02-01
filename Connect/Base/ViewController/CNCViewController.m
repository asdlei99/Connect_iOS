////  CNCViewController.m
//  Connect
//
//  Created by Dwang on 2018/9/2.
//    QQ群:    577506623
//    GitHub:    https://github.com/iizvv
//  Copyright © 2018年 CoderDwang. All rights reserved.
//

#import "CNCViewController.h"
#import "CNCNotification.h"
#import "CNCTransitionDismissPopStyleAnimator.h"
#import "CNCTransitionPresenPushStyleAnimator.h"

@interface CNCViewController ()<UIViewControllerTransitioningDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *percentDrivenTransition;

@property(nonatomic, strong) UIViewController *presentViewController;

@end

@implementation CNCViewController

- (void)initSubviews {
    [super initSubviews];
    [self.view addSubview:self.navigationBar];
}

- (void)didInitialize {
    [super didInitialize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [CNCNotification cnc_addObserver:self selector:@selector(cnc_requestError:) name:kREQUESTERROR];
}

- (void)cnc_requestError:(NSNotification *)cation {
    [self.toastView showError:cation.object];
    [self.toastView hideAnimated:YES afterDelay:2.25f];
}

- (void)cnc_presentViewController:(UIViewController *)viewController {
    [self cnc_presentViewController:viewController animated:YES];
}

//封装原presentViewController:animated:completion:接口
- (void)cnc_presentViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.navigationController pushViewController:viewController animated:animated];
    //    self.presentViewController = viewController;
//    UIViewController *toViewController;
//    if (navigation) {
//       toViewController = [[CNCNavigationController alloc] initWithRootViewController:viewController];
//        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem qmui_backItemWithTarget:self action:@selector(cnc_dismissViewController)];
//    }
//    toViewController.transitioningDelegate = self;
//    UIScreenEdgePanGestureRecognizer *screenGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGesture:)];
//    screenGesture.delegate = self;
//    screenGesture.edges = UIRectEdgeLeft;
//    [toViewController.view addGestureRecognizer:screenGesture];
//    if ([toViewController isKindOfClass:[UINavigationController class]]) {
//        [screenGesture requireGestureRecognizerToFail:((CNCNavigationController *)toViewController).interactivePopGestureRecognizer];
//    }
//    [self presentViewController:toViewController animated:YES completion:nil];
}

//- (void)cnc_dismissViewController {
//    [self.navigationController popViewControllerAnimated:YES];
////    [self dismissViewControllerAnimated:YES completion:nil];
//}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [CNCTransitionPresenPushStyleAnimator new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [CNCTransitionDismissPopStyleAnimator new];
}

//返回手势需要实现
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator {
    if ([animator isKindOfClass:[CNCTransitionDismissPopStyleAnimator class]]) {
        return self.percentDrivenTransition;
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator {
    if ([animator isKindOfClass:[CNCTransitionPresenPushStyleAnimator class]]) {
        return self.percentDrivenTransition;
    }
    return nil;
}


#pragma mark - UIGestureRecognizer
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]
        && [otherGestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        return NO;//和NavigationController自带的返回手势不能同时执行
    } else {
        return  YES;
    }
}

- (void)onPanGesture:(UIScreenEdgePanGestureRecognizer *)gesture {
    float progress = [gesture translationInView:self.view].x / [UIScreen mainScreen].bounds.size.width;
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.percentDrivenTransition = [UIPercentDrivenInteractiveTransition new];
        [self dismissViewControllerAnimated:YES completion:NULL];
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    } else if (gesture.state == UIGestureRecognizerStateCancelled ||
               gesture.state == UIGestureRecognizerStateEnded) {
        if (progress > 0.5) {
            [self.percentDrivenTransition finishInteractiveTransition];
        } else {
            [self.percentDrivenTransition cancelInteractiveTransition];
        }
        self.percentDrivenTransition = nil;
    }
}

- (UIView *)navigationBar {
    if (!_navigationBar) {
        _navigationBar = [[UIView alloc] qmui_initWithSize:CGSizeMake(SCREEN_WIDTH, NavigationBarHeight+StatusBarHeight)];
        _navigationBar.backgroundColor = UIColorWhite;
    }
    return _navigationBar;
}

- (QMUIToastView *)toastView {
    if (!_toastView) {
        _toastView = [[QMUITips alloc] initWithView:self.view];
        [self.view addSubview:_toastView];
    }
    return _toastView;
}

- (BOOL)preferredNavigationBarHidden {
    return NO;
}

- (BOOL)shouldCustomizeNavigationBarTransitionIfHideable {
    return YES;
}

- (BOOL)forceEnableInteractivePopGestureRecognizer {
    return YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.toastView hideAnimated:YES];
}

- (void)dealloc
{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

@end

