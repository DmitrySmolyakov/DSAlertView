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

    var codeString = String()
    @IBOutlet weak var resultCodeTextView: UITextView!
    
    var widthMultiplier: Float = 1 {
        didSet {
            alertVC.widthMultiplier = Double(widthMultiplier)
            if resultCodeTextView.text.range(of: ".widthMultiplier") != nil {
                resultCodeTextView.text = resultCodeTextView.text.replacingOccurrences(of: ".widthMultiplier = \(oldValue)", with: ".widthMultiplier = \(widthMultiplier)")
            } else {
                resultCodeTextView.text = resultCodeTextView.text.replacingOccurrences(of: "\nalertVC.show", with: "\nalertVC.widthMultiplier = \(widthMultiplier)\nalertVC.show")
            }
        }
    }
    var heightMultiplier: Float = 1 {
        didSet {
            alertVC.heightMultiplier = Double(heightMultiplier)
            if resultCodeTextView.text.range(of: ".heightMultiplier") != nil {
                resultCodeTextView.text = resultCodeTextView.text.replacingOccurrences(of: ".heightMultiplier = \(oldValue)", with: ".heightMultiplier = \(heightMultiplier)")
            } else {
                resultCodeTextView.text = resultCodeTextView.text.replacingOccurrences(of: "\nalertVC.show", with: "\nalertVC.heightMultiplier = \(heightMultiplier)\nalertVC.show")
            }
        }
    }
    
    lazy var alertVC: DSAlertController = {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShowedViewControllerExample") else {
            return DSAlertController(showedViewController: UIViewController())
        }
        return DSAlertController(showedViewController: vc)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultCodeTextView.text = "let alertVC = DSAlertController(showedViewController: UIViewController())\nalertVC.show(presenter: self)"
        widthMultiplierSlider.value = 0.7
        widthMultiplierSliderChanged(widthMultiplierSlider)
        heightMultiplierSlider.value = 0.6
        heightMultiplierSliderChanged(heightMultiplierSlider)
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    @IBAction func showController(_ sender: UIButton) {
        
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
    
    @IBOutlet weak var widthMultiplierLabel: UILabel!
    @IBOutlet weak var widthMultiplierSlider: UISlider!
    @IBAction func widthMultiplierSliderChanged(_ sender: UISlider) {
        widthMultiplier = sender.value.roundTo(places: 2)
        widthMultiplierLabel.text = String(widthMultiplier)
    }
    
    @IBOutlet weak var heightMultiplierLabel: UILabel!
    @IBOutlet weak var heightMultiplierSlider: UISlider!
    @IBAction func heightMultiplierSliderChanged(_ sender: UISlider) {
        heightMultiplier = sender.value.roundTo(places: 2)
        heightMultiplierLabel.text = String(heightMultiplier)
    }
}

extension ViewController: UITextFieldDelegate {
    
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let tempString: NSString = textField.text! as NSString
        let resultString = tempString.replacingCharacters(in: range, with: string) as String
        
        
        print(resultString)
        return true
    }

    
    
}

extension Float {
    func roundTo(places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
