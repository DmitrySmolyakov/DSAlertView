//
//  ViewController.swift
//  DSAlertView
//
//  Created by vinclai@yandex.ru on 03/30/2017.
//  Copyright (c) 2017 vinclai@yandex.ru. All rights reserved.
//

import UIKit
import DSAlertView

class ViewController: UITableViewController {
    
    public let sectionTitleArray = ["Default"]
    public let sectionSubtitleArray = ["Simple default style"]
    public let titleArray = [["Default style"]]
    public let subtitleArray = [["Simple alert with default style"]]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightText
    }
    
//            alertVC.widthMultiplier = 0.9
//            alertVC.heightMultiplier = 0.9
//            alertVC.centerMultiplierX = 1.1
//            alertVC.centerMultiplierY = 1.1
//            alertVC.cornerRadius = 50
//            alertVC.borderWidth = 5
//            alertVC.borderColor = .white
//            alertVC.backgroundViewIsHidden = true
//            alertVC.backgroundColor = .red
//            alertVC.backgroundViewAlpha = 0.4
//            alertVC.presentAnimation = .slide(direction: .topRight, rotation: true)
//            alertVC.presentAnimationDuration = 2
//            alertVC.finalRotationAngle = CGFloat.pi / 15
//            alertVC.presentAnimationRotationAngle = 0
//            alertVC.dismissAnimation = .slide(direction: .topRight, rotation: true)
//            alertVC.dismissAnimationDuration = 2
//            alertVC.dismissAnimationRotationAngle = 0
//            alertVC.closeButtonTintColor = .white
//            alertVC.closeButtonIsHidden = true
//            alertVC.show(presenter: self)
//            DSAlertController.showViewController(presenter: self, showedViewController: vc)
}

// MARK: UITableViewDataSource
extension ViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitleArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray[section].count
    }
}

// MARK: UITableViewDelegate
extension ViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68.0
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 42.0
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitleArray[section] + " " + "(" + sectionSubtitleArray[section] + ")"
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell") ?? UITableViewCell.init(style: .subtitle, reuseIdentifier: "UITableViewCell")
        
        cell.textLabel?.textColor = UIColor.init(white: 0.0, alpha: 0.6)
        cell.textLabel?.font = UIFont.init(name: "Courier-Regular", size: 14.0)
        cell.textLabel?.lineBreakMode = .byCharWrapping
        cell.textLabel?.text = "\(indexPath.section + 1).\(indexPath.row + 1) \(titleArray[indexPath.section][indexPath.row])"
        cell.textLabel?.numberOfLines = 2
        
        cell.detailTextLabel?.textColor = UIColor.init(white: 0.0, alpha: 0.5)
        cell.detailTextLabel?.font = UIFont.init(name: "Courier-Regular", size: 11.0)
        cell.detailTextLabel?.text = "\(subtitleArray[indexPath.section][indexPath.row])"
        cell.detailTextLabel?.numberOfLines = 2
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let exampleViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShowedViewControllerExample")
                ExampleProvider.defaultStyle(showedViewController: exampleViewController!).show(presenter: self)
            default:
                break
            }
        default:
            break
        }
        
        
    }

}
