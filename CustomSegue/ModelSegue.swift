//
//  ModelSegue.swift
//  CustomSegue
//
//  Created by luojie on 16/7/7.
//  Copyright © 2016年 Caroline Begbie. All rights reserved.
//

import UIKit

/**
 Custom Segue
 ### Usage Example: ###
 ```swift
 
class FadeSegue: ModelSegue {
    
    override var presentAnimator: UIViewControllerAnimatedTransitioning? {
        return PresentAnimator()
    }

    override var dismissAnimator: UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
}

extension FadeSegue {
    
    class PresentAnimator: TransitioningPresentAnimator {
        
        override func transition(context
            context: UIViewControllerContextTransitioning,
            presentingViewController: UIViewController?,
            presentedViewController: UIViewController?,
            presentingView: UIView?,
            presentedView: UIView?,
            containerView: UIView?) {
            
            containerView?.addSubview(presentedView!)
            presentedView?.alpha = 0
            
            UIView.animateWithDuration(
                duration,
                animations: { 
                    presentedView?.alpha = 1
                },
                completion: { _ in
                    context.completeTransition(true)
                }
            )
            
        }
    }
}

extension FadeSegue {
    
    class DismissAnimator: TransitioningDismissAnimator {
        
        override func transition(context
            context: UIViewControllerContextTransitioning,
            presentingViewController: UIViewController?,
            presentedViewController: UIViewController?,
            presentingView: UIView?,
            presentedView: UIView?,
            containerView: UIView?) {
            
            _ = presentingView.flatMap { containerView?.insertSubview($0, atIndex: 0) }

            UIView.animateWithDuration(
                duration,
                animations: {
                    presentedView?.alpha = 0
                },
                completion: { _ in
                    context.completeTransition(true)
                }
            )
        }
    }
}
 ```
 */
public class ModelSegue: UIStoryboardSegue {
    override public func perform() {
        destinationViewController.transitioningDelegate = self
        super.perform()
    }
}

extension ModelSegue: UIViewControllerTransitioningDelegate {
    
    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimator
    }
    
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimator
    }
    
    public var presentAnimator: UIViewControllerAnimatedTransitioning? {
        return nil
    }
    
    public var dismissAnimator: UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

