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
            resultCodeTextView.text = resultCodeTextView.text.replacingOccurrences(of: "\nalertVC.width = \(width)", with: "")
            self.widthMultiplierLabel.alpha = 1
            self.widthMultiplierSlider.alpha = 1
            self.widthTextField.alpha = 0.2
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
            resultCodeTextView.text = resultCodeTextView.text.replacingOccurrences(of: "\nalertVC.height = \(height)", with: "")
            self.heightMultiplierLabel.alpha = 1
            self.heightMultiplierSlider.alpha = 1
            self.heightTextField.alpha = 0.2
            if resultCodeTextView.text.range(of: ".heightMultiplier") != nil {
                resultCodeTextView.text = resultCodeTextView.text.replacingOccurrences(of: ".heightMultiplier = \(oldValue)", with: ".heightMultiplier = \(heightMultiplier)")
            } else {
                resultCodeTextView.text = resultCodeTextView.text.replacingOccurrences(of: "\nalertVC.show", with: "\nalertVC.heightMultiplier = \(heightMultiplier)\nalertVC.show")
            }
        }
    }
    var width: CGFloat = 0 {
        didSet {
            alertVC.width = width
            resultCodeTextView.text = resultCodeTextView.text.replacingOccurrences(of: "\nalertVC.widthMultiplier = \(widthMultiplier)", with: "")
            self.widthMultiplierLabel.alpha = 0.2
            self.widthMultiplierSlider.alpha = 0.2
            self.widthTextField.alpha = 1
            if resultCodeTextView.text.range(of: ".width") != nil {
                resultCodeTextView.text = resultCodeTextView.text.replacingOccurrences(of: ".width = \(oldValue)", with: ".width = \(width)")
            } else {
                resultCodeTextView.text = resultCodeTextView.text.replacingOccurrences(of: "\nalertVC.show", with: "\nalertVC.width = \(width)\nalertVC.show")
            }
        }
    }
    var height: CGFloat = 0 {
        didSet {
            alertVC.height = height
            resultCodeTextView.text = resultCodeTextView.text.replacingOccurrences(of: "\nalertVC.heightMultiplier = \(heightMultiplier)", with: "")
            self.heightMultiplierLabel.alpha = 0.2
            self.heightMultiplierSlider.alpha = 0.2
            self.heightTextField.alpha = 1
            if resultCodeTextView.text.range(of: ".height") != nil {
                resultCodeTextView.text = resultCodeTextView.text.replacingOccurrences(of: ".height = \(oldValue)", with: ".height = \(height)")
            } else {
                resultCodeTextView.text = resultCodeTextView.text.replacingOccurrences(of: "\nalertVC.show", with: "\nalertVC.height = \(height)\nalertVC.show")
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
//        alertVC.centerOffsetX = 50
//        alertVC.centerOffsetY = 30
//            alertVC.width = 250
//            alertVC.height = 115
//            alertVC.backgroundViewIsHidden = true
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
    
    @IBOutlet weak var widthTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
}

extension ViewController: UITextFieldDelegate {
    
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let tempString: NSString = textField.text! as NSString
        let resultString = tempString.replacingCharacters(in: range, with: string) as String
        
        if resultString.isEmpty {
            return true
        }
        
        guard let value = Double(resultString) else {
            return false
        }
        
        if textField === widthTextField {
            width = CGFloat(value)
        } else if textField === heightTextField {
            height = CGFloat(value)
        }
        
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension Float {
    func roundTo(places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
