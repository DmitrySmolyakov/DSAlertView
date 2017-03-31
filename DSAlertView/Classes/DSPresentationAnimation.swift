//
//  DSPresentationAnimation.swift
//  Pods
//
//  Created by Dmitry Smolyakov on 3/30/17.
//
//

import UIKit

class DSPresentationAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? DSTransitionAnimation else {
            return
        }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return
        }
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        toViewController.backgroundView.alpha = 0
        toViewController.contentView.transform = CGAffineTransform(translationX: 0, y: -toView.frame.size.height)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext) * 0.5,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            toViewController.backgroundView.alpha = 0.6
        }, completion: nil)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 1,
                       options: .curveEaseOut,
                       animations: {
            toViewController.contentView.transform = CGAffineTransform.identity
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }   
}
