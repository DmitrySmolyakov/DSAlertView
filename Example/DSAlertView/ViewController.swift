//
//  ViewController.swift
//  DSAlertView
//
//  Created by vinclai@yandex.ru on 03/30/2017.
//  Copyright (c) 2017 vinclai@yandex.ru. All rights reserved.
//

import UIKit
import DSAlertView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showController(_ sender: UIButton) {
        
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShowedViewControllerExample") {
            
            let alertVC = DSAlertController(showedViewController: vc, widthMultiplier: 0.75, heightMultiplier: 0.65)
//            alertVC.widthMultiplier = 0.9
//            alertVC.heightMultiplier = 0.9
//            alertVC.centerMultiplierX = 1.1
//            alertVC.centerMultiplierY = 1.1
            alertVC.cornerRadius = 50
            alertVC.borderWidth = 5
            alertVC.borderColor = .white
            alertVC.backgroundViewIsHidden = true
//            alertVC.backgroundColor = .red
            alertVC.backgroundViewAlpha = 0.4
//            alertVC.presentAnimation = .slide(direction: .topRight, rotation: true)
//            alertVC.presentAnimationDuration = 2
//            alertVC.finalRotationAngle = CGFloat.pi / 15
//            alertVC.presentAnimationRotationAngle = 0
//            alertVC.dismissAnimation = .slide(direction: .topRight, rotation: true)
//            alertVC.dismissAnimationDuration = 2
//            alertVC.dismissAnimationRotationAngle = 0
            alertVC.closeButtonTintColor = .white
            alertVC.closeButtonIsHidden = true
            alertVC.show(presenter: self)
            
//            DSAlertController.showViewController(presenter: self, showedViewController: vc)
        }
    }
}
