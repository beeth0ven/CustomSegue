//
//  CoverVerticalSegue.swift
//  CustomSegue
//
//  Created by luojie on 16/7/7.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

class CoverVerticalSegue: ModelSegue {
    
    override var presentAnimator: UIViewControllerAnimatedTransitioning? {
        return PresentAnimator()
    }
    
    override var dismissAnimator: UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
}

extension CoverVerticalSegue {
    
    class PresentAnimator: TransitioningPresentAnimator {
        
        override func transition(context
            context: UIViewControllerContextTransitioning,
            presentingViewController: UIViewController?,
            presentedViewController: UIViewController?,
            presentingView: UIView?,
            presentedView: UIView?,
            containerView: UIView?) {
            
            presentedView?.frame.origin.y = presentedView!.frame.height
            containerView?.addSubview(presentedView!)
            
            UIView.animateWithDuration(
                duration,
                animations: {
                    presentedView?.frame.origin.y = 0
                    presentingViewController?.view.alpha = 0.5
                },
                completion: { _ in
                    context.completeTransition(true)
                }
            )
            
        }
    }
}

extension CoverVerticalSegue {
    
    class DismissAnimator: TransitioningDismissAnimator {
        
        override func transition(context
            context: UIViewControllerContextTransitioning,
            presentingViewController: UIViewController?,
            presentedViewController: UIViewController?,
            presentingView: UIView?,
            presentedView: UIView?,
            containerView: UIView?) {
            
            UIView.animateWithDuration(
                duration,
                animations: {
                    presentedView?.frame.origin.y = presentedView!.frame.height
                    presentingViewController?.view.alpha = 1
                },
                completion: { _ in
                    context.completeTransition(true)
                }
            )
        }
    }
}