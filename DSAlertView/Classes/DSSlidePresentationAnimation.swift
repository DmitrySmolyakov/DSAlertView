//
//  DSSlidePresentationAnimation.swift
//  Pods
//
//  Created by Dmitry Smolyakov on 3/31/17.
//
//

import UIKit

class DSSlidePresentationAnimation: DSPresentationAnimation {

    let direction: DSAlertController.Animation.Direction
    
    init(direction: DSAlertController.Animation.Direction) {
        self.direction = direction
    }
    
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
        toViewController.contentView.transform = getTransformForDirection(direction: direction, toView: toView)
        
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
                        toViewController.contentView.transform = CGAffineTransform.identity
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
    
    private func getTransformForDirection(direction: DSAlertController.Animation.Direction, toView: UIView) -> CGAffineTransform {
        switch direction {
        case .top:
            return CGAffineTransform(translationX: 0, y: -toView.frame.size.height)
        case .right:
            return CGAffineTransform(translationX: toView.frame.size.width, y: 0)
        case .left:
            return CGAffineTransform(translationX: -toView.frame.size.width, y: 0)
        case .bottom:
            return CGAffineTransform(translationX: 0, y: toView.frame.size.height)
        }
    }
}
