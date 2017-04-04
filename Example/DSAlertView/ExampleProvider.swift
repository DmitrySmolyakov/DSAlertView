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
    //2.2 Content view size, absolute values
    static func contentSizeAbsolute(showedViewController: UIViewController) -> DSAlertController {
        let alertVC = DSAlertController(showedViewController: showedViewController)
        alertVC.width = 200
        alertVC.height = 250
        alertVC.cornerRadius = 5
        return alertVC
    }
    //2.3 Content view center offset, relative values
    static func contentCenterOffsetRelative(showedViewController: UIViewController) -> DSAlertController {
        let alertVC = DSAlertController(showedViewController: showedViewController)
        alertVC.centerMultiplierX = 1.2
        alertVC.centerMultiplierY = 0.6
        
        //add some animation and size changes
        alertVC.width = 200
        alertVC.height = 250
        alertVC.finalPositionRotationAngle = CGFloat.pi / 30
        alertVC.presentAnimation = .slide(direction: .topLeft, rotation: true)
        alertVC.dismissAnimation = .slide(direction: .bottomRight, rotation: true)
        
        return alertVC
    }
    //2.4 Border setup with content view center offset
    static func borderSetup(showedViewController: UIViewController) -> DSAlertController {
        let alertVC = DSAlertController(showedViewController: showedViewController)
        alertVC.borderColor = .red
        alertVC.borderWidth = 4
        alertVC.cornerRadius = 35

        //center offset in absolute values
        alertVC.centerOffsetX = -50
        alertVC.centerOffsetY = 75
        
        //size multipliers
        alertVC.widthMultiplier = 0.5
        alertVC.heightMultiplier = 0.45
        
        //animation and final position setup
        alertVC.finalPositionRotationAngle = -CGFloat.pi / 30
        alertVC.presentAnimation = .slide(direction: .bottom, rotation: true)
        alertVC.dismissAnimation = .slide(direction: .bottom, rotation: true)
        
        return alertVC
    }
    //2.5 Background setup
    static func backgroundSetup(showedViewController: UIViewController) -> DSAlertController {
        let alertVC = DSAlertController(showedViewController: showedViewController)
        alertVC.backgroundColor = .orange
        alertVC.backgroundViewAlpha = 0.9
        alertVC.hideByTapIsOn = false
        
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
    
    //Features
    //4.1 Close button setup
    static func closeButtonSetup(showedViewController: UIViewController) -> DSAlertController {
        let alertVC = DSAlertController(showedViewController: showedViewController)
        alertVC.closeButtonIsHidden = false
        alertVC.closeButtonTintColor = .white
        return alertVC
    }
    //4.2 Custom close button
    static func customCloseButton(showedViewController: UIViewController) -> DSAlertController {
        let alertVC = DSAlertController(showedViewController: showedViewController)
        alertVC.closeButton.isHidden = false
        alertVC.closeButton.tintColor = .white
        alertVC.closeButton.setImage(UIImage(named: "close"), for: .normal)
        return alertVC
    }
}
