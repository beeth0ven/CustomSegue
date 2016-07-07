//
//  Helper.swift
//  CustomSegue
//
//  Created by luojie on 16/7/5.
//  Copyright © 2016年 Caroline Begbie. All rights reserved.
//

import UIKit

extension UIViewControllerContextTransitioning {
    var fromViewController: UIViewController? { return viewControllerForKey(UITransitionContextFromViewControllerKey) }
    var toViewController: UIViewController? { return viewControllerForKey(UITransitionContextToViewControllerKey) }
    
    var fromView: UIView? { return viewForKey(UITransitionContextFromViewKey) }
    var toView: UIView? { return viewForKey(UITransitionContextToViewKey) }
    
    var fromViewStartFrame: CGRect? { return fromViewController != nil ? initialFrameForViewController(fromViewController!) : nil }
    var toViewEndFrame: CGRect? { return toViewController != nil ? finalFrameForViewController(toViewController!) : nil }
    
}

extension UIViewController {
    
    var contentViewController: UIViewController {
        switch self {
        case let nav as UINavigationController:
            return nav.topViewController?.contentViewController ?? self
        case let tab as UITabBarController:
            return tab.selectedViewController?.contentViewController ?? self
        default:
            return self
        }
    }
}

public class AnimationDelegate {
    private let completion: () -> Void
    
    init(completion: () -> Void) {
        self.completion = completion
    }
    
    dynamic func animationDidStop(_: CAAnimation, finished: Bool) {
        completion()
    }
}
