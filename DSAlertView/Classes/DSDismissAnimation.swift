//
//  DSDismissAnimation.swift
//  Pods
//
//  Created by Dmitry Smolyakov on 3/30/17.
//
//

import UIKit

class DSDismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? DSTransitionAnimation else {
            return
        }
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
            return
        }
        
        let backgroundShowAnimationTimeMultiplier = 0.5
        let delay = transitionDuration(using: transitionContext) - transitionDuration(using: transitionContext) * backgroundShowAnimationTimeMultiplier
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext) * backgroundShowAnimationTimeMultiplier,
                       delay: delay,
                       options: .curveEaseOut,
                       animations: {
            fromViewController.backgroundView.alpha = 0
        }, completion: nil)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: .curveEaseOut, animations: {
            fromViewController.contentView.alpha = 0
            fromViewController.contentView.transform = CGAffineTransform(translationX: 0, y: fromView.frame.maxY - fromViewController.backgroundView.frame.minY)
        }) { _ in
            transitionContext.completeTransition(true)
        }
        
    }

}
