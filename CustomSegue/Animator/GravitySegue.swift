//
//  GravitySegue.swift
//  CustomSegue
//
//  Created by luojie on 16/7/8.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

class GravitySegue: ModelSegue {
    
    override var presentAnimator: UIViewControllerAnimatedTransitioning? {
        return PresentAnimator()
    }
    
    override var dismissAnimator: UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
}

extension GravitySegue {
    
    class PresentAnimator: TransitioningPresentAnimator {
        
        override func transition(context
            context: UIViewControllerContextTransitioning,
            presentingViewController: UIViewController?,
            presentedViewController: UIViewController?,
            presentingView: UIView?,
            presentedView: UIView?,
            containerView: UIView?) {
            
            presentedView?.frame.origin.y -= presentedView!.frame.height
            containerView?.addSubview(presentedView!)

            let animator = UIDynamicAnimator(referenceView: containerView!)
            
            let gravityBehavior = UIGravityBehavior(items: [presentedView!])
            animator.addBehavior(gravityBehavior)
            
            let itemBehavior = UIDynamicItemBehavior(items: [presentedView!])
            itemBehavior.elasticity = 0.2
            itemBehavior.density = 400
            itemBehavior.allowsRotation = false
            animator.addBehavior(itemBehavior)
            
            let collisionBehavior = UICollisionBehavior(items: [presentedView!])
            let y = presentedView!.frame.height + 2
            let fromPoint = CGPoint(x: 0, y: y)
            let toPoint = CGPoint(x: presentedView!.frame.width, y: y)
            collisionBehavior.addBoundaryWithIdentifier("bottom", fromPoint: fromPoint, toPoint: toPoint)
            animator.addBehavior(collisionBehavior)
            
            let delegate = AnimatorDelegate(animatorDidPause: { _ in
                context.completeTransition(true)
            })
            
            animator.delegate = delegate
            
            Queue.Main.executeAfter(seconds: 5) { animator; delegate }
        }
    }
}

extension GravitySegue {
    
    class DismissAnimator: TransitioningDismissAnimator {
        
        override func transition(context
            context: UIViewControllerContextTransitioning,
            presentingViewController: UIViewController?,
            presentedViewController: UIViewController?,
            presentingView: UIView?,
            presentedView: UIView?,
            containerView: UIView?) {
            
            _ = presentingView.flatMap { containerView?.insertSubview($0, atIndex: 0) }

            let animator = UIDynamicAnimator(referenceView: containerView!)
            
            let gravityBehavior = UIGravityBehavior(items: [presentedView!])
            animator.addBehavior(gravityBehavior)
            
            let itemBehavior = UIDynamicItemBehavior(items: [presentedView!])
            itemBehavior.elasticity = 0
            itemBehavior.density = 400
            itemBehavior.allowsRotation = false
            animator.addBehavior(itemBehavior)
            
            let collisionBehavior = UICollisionBehavior(items: [presentedView!])
            let y = 2 * presentedView!.frame.height + 50
            let fromPoint = CGPoint(x: 0, y: y)
            let toPoint = CGPoint(x: presentedView!.frame.width, y: y)
            collisionBehavior.addBoundaryWithIdentifier("bottom", fromPoint: fromPoint, toPoint: toPoint)
            animator.addBehavior(collisionBehavior)
            
            let delegate = AnimatorDelegate(animatorDidPause: { _ in
                context.completeTransition(true)
            })
            
            animator.delegate = delegate
            
            Queue.Main.executeAfter(seconds: 5) { animator; delegate }

        }
    }
}

class AnimatorDelegate: NSObject, UIDynamicAnimatorDelegate {
    
    let animatorDidPause: ((UIDynamicAnimator) -> Void)?
    let animatorWillResume: ((UIDynamicAnimator) -> Void)?
    
    init(animatorDidPause: ((UIDynamicAnimator) -> Void)? = nil, animatorWillResume: ((UIDynamicAnimator) -> Void)? = nil) {
        self.animatorDidPause = animatorDidPause
        self.animatorWillResume = animatorWillResume
    }
    
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        animatorDidPause?(animator)
    }
    
    func dynamicAnimatorWillResume(animator: UIDynamicAnimator) {
        animatorWillResume?(animator)
    }
}