//
//  DSSlideDismissAnimation.swift
//  Pods
//
//  Created by Dmitry Smolyakov on 4/1/17.
//
//

import UIKit

class DSSlideDismissAnimation: DSDismissAnimation {

    let direction: Animation.Direction
    let rotation: Bool
    
    init(direction: Animation.Direction, rotation: Bool) {
        self.direction = direction
        self.rotation = rotation
    }
    
    public override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
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
        
        UIView.animateKeyframes(withDuration: transitionDuration(using: transitionContext),
                                delay: 0,
                                options: .calculationModeCubic,
                                animations: {
                                    fromViewController.contentView.alpha = 0
                                    let transform = self.getTransformPropertiesForDirection(direction: self.direction, toView: fromView)
                                    let rotationAngle = self.rotationAngle != nil ? self.rotationAngle! : transform.rotationAngle
                                    fromViewController.contentView.transform = self.rotation ? CGAffineTransform(rotationAngle: rotationAngle).concatenating(transform.translation) : transform.translation
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
    
    private func getTransformPropertiesForDirection(direction: Animation.Direction, toView: UIView) -> (translation: CGAffineTransform, rotationAngle: CGFloat) {
        switch direction {
        case .top:
            return (CGAffineTransform(translationX: 0, y: -toView.frame.size.height), CGFloat.pi / 2)
        case .right:
            return (CGAffineTransform(translationX: toView.frame.size.width, y: 0), CGFloat.pi / 2)
        case .left:
            return (CGAffineTransform(translationX: -toView.frame.size.width, y: 0), -CGFloat.pi)
        case .bottom:
            return (CGAffineTransform(translationX: 0, y: toView.frame.size.height), CGFloat.pi / 2)
        case .topRight:
            return (CGAffineTransform(translationX: toView.frame.size.width, y: -toView.frame.size.height), -CGFloat.pi / 2)
        case .topLeft:
            return (CGAffineTransform(translationX: -toView.frame.size.width, y: -toView.frame.size.height), CGFloat.pi / 2)
        case .bottomRight:
            return (CGAffineTransform(translationX: toView.frame.size.width, y: toView.frame.size.height), CGFloat.pi / 2)
        case .bottomLeft:
            return (CGAffineTransform(translationX: -toView.frame.size.width, y: toView.frame.size.height), -CGFloat.pi / 2)
        }
    }
}
