//
//  TransitioningAnimator.swift
//  CustomSegue
//
//  Created by luojie on 16/7/7.
//  Copyright © 2016年 Caroline Begbie. All rights reserved.
//

import UIKit

public class TransitioningAnimator: NSObject, UIViewControllerAnimatedTransitioning  {
    
    public var duration: NSTimeInterval {
        return 0.4
    }
    
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        transition(
            context: transitionContext,
            fromViewController: transitionContext.fromViewController,
            toViewController: transitionContext.toViewController,
            fromView: transitionContext.fromView,
            toView: transitionContext.toView,
            containerView: transitionContext.containerView()
        )
    }
    
    public func transition(context
        context: UIViewControllerContextTransitioning,
        fromViewController: UIViewController?,
        toViewController: UIViewController?,
        fromView: UIView?,
        toView: UIView?,
        containerView: UIView?) {}
}

public class TransitioningPresentAnimator: TransitioningAnimator {
    
    public override func transition(context
        context: UIViewControllerContextTransitioning,
        fromViewController: UIViewController?,
        toViewController: UIViewController?,
        fromView: UIView?,
        toView: UIView?,
        containerView: UIView?) {
        transition(
            context: context,
            presentingViewController: fromViewController,
            presentedViewController: toViewController,
            presentingView: fromView,
            presentedView: toView,
            containerView: containerView
        )
    }
    
    public func transition(context
        context: UIViewControllerContextTransitioning,
        presentingViewController: UIViewController?,
        presentedViewController: UIViewController?,
        presentingView: UIView?,
        presentedView: UIView?,
        containerView: UIView?) {}
}

public class TransitioningDismissAnimator: TransitioningAnimator {
    
    public override func transition(context
        context: UIViewControllerContextTransitioning,
        fromViewController: UIViewController?,
        toViewController: UIViewController?,
        fromView: UIView?,
        toView: UIView?,
        containerView: UIView?) {
        transition(
            context: context,
            presentingViewController: toViewController,
            presentedViewController: fromViewController,
            presentingView: toView,
            presentedView: fromView,
            containerView: containerView
        )
    }
    
    public func transition(context
        context: UIViewControllerContextTransitioning,
        presentingViewController: UIViewController?,
        presentedViewController: UIViewController?,
        presentingView: UIView?,
        presentedView: UIView?,
        containerView: UIView?) {}
}

