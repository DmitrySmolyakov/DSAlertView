//
//  ExampleViewController.swift
//  DSAlertView
//
//  Created by Dmitry Smolyakov on 4/3/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

protocol ExampleViewControllerDelegate: class {
    func exampleButtonTapped(exampleViewController: ExampleViewController)
}

class ExampleViewController: UIViewController {

    weak var delegate: ExampleViewControllerDelegate?
    
    @IBAction func okButtonTapped(_ sender: UIButton) {
        delegate?.exampleButtonTapped(exampleViewController: self)
    }
}
