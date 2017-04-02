//
//  DSFadePresentationAnimation.swift
//  Pods
//
//  Created by Dmitry Smolyakov on 4/2/17.
//
//

import UIKit

class DSFadePresentationAnimation: DSPresentationAnimation {

    override public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? DSTransitionAnimation else {
            return
        }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return
        }

        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        let startingBackgroundAlpha = toViewController.backgroundView.alpha
        toViewController.backgroundView.alpha = 0
        toViewController.contentView.alpha = 0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext) * 0.5,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        toViewController.backgroundView.alpha = startingBackgroundAlpha
        }, completion: nil)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
                        toViewController.contentView.alpha = 1
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
}
