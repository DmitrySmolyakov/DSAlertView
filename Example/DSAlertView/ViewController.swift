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
            alertVC.cornerRadius = 50
            alertVC.backgroundColor = .red
            alertVC.backgroundViewAlpha = 0.4
            alertVC.presentAnimation = .slide(direction: .top, rotation: true)
            alertVC.presentAnimationDuration = 0.5
//            alertVC.presentAnimationRotationAngle = 0
            alertVC.closeButton.tintColor = .white
            alertVC.closeButton.isHidden = true
            alertVC.show(presenter: self)
            
//            DSAlertController.showViewController(presenter: self, showedViewController: vc)
        }
    }
}
