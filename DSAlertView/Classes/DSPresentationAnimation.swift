//
//  DSPresentationAnimation.swift
//  Pods
//
//  Created by Dmitry Smolyakov on 3/30/17.
//
//

import UIKit

protocol DSPresentationAnimationDelegate: class {
    func durationForPresentationAnimation() -> Double
    func rotationAngle() -> CGFloat?
}

public class DSPresentationAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    weak var delegate: DSPresentationAnimationDelegate?
    
    var rotationAngle: CGFloat? {
        return self.delegate?.rotationAngle() ?? nil
    }
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.delegate?.durationForPresentationAnimation() ?? 0.5
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }   
}
