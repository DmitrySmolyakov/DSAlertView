//
//  ExampleProvider.swift
//  DSAlertView
//
//  Created by Dmitry Smolyakov on 4/3/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation
import DSAlertView

class ExampleProvider {
    
    //Default
    //1.1 Default style
    static func defaultStyle(showedViewController: UIViewController) -> DSAlertController {
        let alertVC = DSAlertController(showedViewController: showedViewController)
        return alertVC
    }
    
    //Alert setup
    //2.1 Content view size, relative values
    static func contentSizeRelative(showedViewController: UIViewController) -> DSAlertController {
        let alertVC = DSAlertController(showedViewController: showedViewController, widthMultiplier: 0.5, heightMultiplier: 0.45)
        return alertVC
    }
    
    //Animation
    //3.1 Slide animation for present and dismiss
    static func slideAnimation(showedViewController: UIViewController) -> DSAlertController {
        let alertVC = DSAlertController(showedViewController: showedViewController)
        alertVC.presentAnimation = .slide(direction: .top, rotation: false)
        alertVC.dismissAnimation = .slide(direction: .bottom, rotation: false)
        return alertVC
    }
    
    //3.2 Slide animation with rotation
    static func slideAnimationWithDefaultRotation(showedViewController: UIViewController) -> DSAlertController {
        let alertVC = DSAlertController(showedViewController: showedViewController)
        alertVC.presentAnimation = .slide(direction: .topLeft, rotation: true)
        alertVC.dismissAnimation = .slide(direction: .bottomRight, rotation: true)
        return alertVC
    }
    
    //3.3 Slide animation with rotation angle
    static func slideAnimationWithCustomRotation(showedViewController: UIViewController) -> DSAlertController {
        let alertVC = DSAlertController(showedViewController: showedViewController)
        alertVC.presentAnimation = .slide(direction: .left, rotation: true)
        alertVC.presentAnimationRotationAngle = CGFloat.pi
        alertVC.dismissAnimationRotationAngle = CGFloat.pi
        alertVC.dismissAnimation = .slide(direction: .right, rotation: true)
        return alertVC
    }
    
    //3.4 Final rotation angle
    static func finalRotationAngle(showedViewController: UIViewController) -> DSAlertController {
        let alertVC = DSAlertController(showedViewController: showedViewController)
        alertVC.presentAnimation = .slide(direction: .bottom, rotation: true)
        alertVC.finalRotationAngle = CGFloat.pi / 25
        alertVC.dismissAnimation = .slide(direction: .bottom, rotation: true)
        return alertVC
    }
}
