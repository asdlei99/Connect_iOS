////  CNCTransitionDismissPopStyleAnimator.m
//  Connect
//
//  Created by Dwang on 2018/10/20.
//	QQ群:	577506623
//	GitHub:	https://github.com/iizvv
//  Copyright © 2018 CoderDwang. All rights reserved.
//

#import "CNCTransitionDismissPopStyleAnimator.h"

#define kPPTransitionDismissPopStyleDuration 0.3
@implementation CNCTransitionDismissPopStyleAnimator

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    CGRect fromVCRect = fromVC.view.frame;
    fromVCRect.origin.x = 0;
    fromVC.view.frame = fromVCRect;
    [container addSubview:toVC.view];
    CGRect toVCRect = toVC.view.frame;
    toVCRect.origin.x = -SCREEN_WIDTH;
    toVC.view.frame = toVCRect;
    fromVCRect.origin.x = SCREEN_WIDTH;
    toVCRect.origin.x = 0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.frame = fromVCRect;
        toVC.view.transform = CGAffineTransformIdentity;
        toVC.view.frame = UIScreen.mainScreen.bounds;
    } completion:^(BOOL finished){
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];//动画结束、取消必须调用
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return kPPTransitionDismissPopStyleDuration;
}

@end
