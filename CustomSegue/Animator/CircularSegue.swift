//
//  CircularSegue.swift
//  CustomSegue
//
//  Created by luojie on 16/7/7.
//  Copyright © 2016年 Caroline Begbie. All rights reserved.
//

import UIKit

class CircularSegue: ModelSegue {
    
    override var presentAnimator: UIViewControllerAnimatedTransitioning? {
        return PresentAnimator()
    }
    
    override var dismissAnimator: UIViewControllerAnimatedTransitioning? {
        return DismissAnimator()
    }
}

extension CircularSegue {
    
    class PresentAnimator: TransitioningPresentAnimator {
        
        override func transition(context
            context: UIViewControllerContextTransitioning,
            presentingViewController: UIViewController?,
            presentedViewController: UIViewController?,
            presentingView: UIView?,
            presentedView: UIView?,
            containerView: UIView?) {
            
            containerView?.addSubview(presentedView!)
            
            let point = (presentingViewController?.contentViewController as! HasCircularRevealCenter).circularRevealCenter
            
            let minCirclePath = CGPathCreateWithEllipseInRect(SquareAroundCircle(point, radius: 1), nil)
            let maxCirclePath = CGPathCreateWithEllipseInRect(SquareAroundCircle(point, radius: presentingView!.bounds.containingCircleRadiusFromPoint(point)), nil)
            
            let mask = CAShapeLayer()
            mask.frame = presentingView!.layer.bounds
            mask.path = maxCirclePath
            mask.fillRule = kCAFillRuleEvenOdd
            presentedView?.layer.mask = mask
            
            let animation = CABasicAnimation(keyPath: "path")
            animation.duration = duration
            animation.fromValue = minCirclePath
            animation.toValue = maxCirclePath
            animation.delegate = AnimationDelegate {
                presentedView?.layer.mask = nil
                animation.delegate = nil
                context.completeTransition(true)
            }
            
            mask.addAnimation(animation, forKey: "reveal")
        }
    }
}

extension CircularSegue {
    
    class DismissAnimator: TransitioningDismissAnimator {
        
        override func transition(context
            context: UIViewControllerContextTransitioning,
            presentingViewController: UIViewController?,
            presentedViewController: UIViewController?,
            presentingView: UIView?,
            presentedView: UIView?,
            containerView: UIView?) {
            
            _ = presentingView.flatMap { containerView?.insertSubview($0, atIndex: 0) }
            
            let point = (presentingViewController?.contentViewController as! HasCircularRevealCenter).circularRevealCenter
            
            let minCirclePath = CGPathCreateWithEllipseInRect(SquareAroundCircle(point, radius: 1), nil)
            let maxCirclePath = CGPathCreateWithEllipseInRect(SquareAroundCircle(point, radius: presentingView!.bounds.containingCircleRadiusFromPoint(point)), nil)
            
            let mask = CAShapeLayer()
            mask.frame = presentingView!.layer.bounds
            mask.path = minCirclePath
            mask.fillRule = kCAFillRuleEvenOdd
            presentedView?.layer.mask = mask
            
            let animation = CABasicAnimation(keyPath: "path")
            animation.duration = duration
            animation.fromValue = maxCirclePath
            animation.toValue = minCirclePath
            animation.delegate = AnimationDelegate {
                presentedView?.layer.mask = nil
                animation.delegate = nil
                context.completeTransition(true)
            }
            
            mask.addAnimation(animation, forKey: "reveal")
        }

    }
}

protocol HasCircularRevealCenter {
    var circularRevealCenter: CGPoint { get }
}

private func SquareAroundCircle(center: CGPoint, radius: CGFloat) -> CGRect {
    assert(0 <= radius, "radius must be a positive value")
    return CGRectInset(CGRect(origin: center, size: CGSizeZero), -radius, -radius)
}


extension CGRect {
    
    private func containingCircleRadiusFromPoint(point: CGPoint) -> CGFloat {
        let endX = origin.x + width
        let endY = origin.y + height
        let maxWidth = max(abs(point.x - origin.x), abs(endX - point.x))
        let maxHeight = max(abs(point.y - origin.y), abs(endY - point.y))
        return sqrt(maxWidth*maxWidth + maxHeight*maxHeight)
        
    }
    
    private var center: CGPoint {
        return CGPointMake(origin.x + width / 2, origin.y + height / 2)
    }
    
    private var endPoint: CGPoint {
        return CGPointMake(origin.x + width, origin.y + height)
    }
}
