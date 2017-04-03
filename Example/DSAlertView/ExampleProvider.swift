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
    
    static func defaultStyle(showedViewController: UIViewController) -> DSAlertController {
        let alertVC = DSAlertController(showedViewController: showedViewController)
        return alertVC
    }
    
    
}
