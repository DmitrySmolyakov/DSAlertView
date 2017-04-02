//
//  DSFadeDismissAnimation.swift
//  Pods
//
//  Created by Dmitry Smolyakov on 4/2/17.
//
//

import UIKit

class DSFadeDismissAnimation: DSDismissAnimation {

    public override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? DSTransitionAnimation else {
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
        
        UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModeCubic,
                                animations: {
                                    fromViewController.contentView.alpha = 0
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
}
