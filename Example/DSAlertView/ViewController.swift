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
    
    let sectionTitleArray = ["Default", "Alert setup", "Animation"]
    let sectionSubtitleArray = ["Simple default style", "UI configuration", "Different styles"]
    let titleArray = [["Default style"],
                      ["Content view size"],
                      ["Slide animation for present and dismiss", "Slide animation with rotation", "Slide animation with rotation angle", "Final rotation angle"]]
    let subtitleArray = [["Simple alert with default style"],
                         ["Relative values"],
                         ["Simple slide animation", "Default rotation angle", "Slide animation with custom rotation angle", "Changed angle final rotation angle"]]
    
    var currentlyShowedAlertController: DSAlertController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
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
        guard let exampleViewController = self.storyboard?.instantiateViewController(withIdentifier: "ExampleViewController") as? ExampleViewController else {
            return
        }
        exampleViewController.delegate = self
        
        switch indexPath.section {
        case 0: //Default
            switch indexPath.row {
            case 0: //1.1 Default style
                self.currentlyShowedAlertController = ExampleProvider.defaultStyle(showedViewController: exampleViewController)
            default:
                break
            }
        case 1: //Alert setup
            switch indexPath.row {
            case 0: //2.1 Content view size, realtive values
                self.currentlyShowedAlertController = ExampleProvider.contentSizeRelative(showedViewController: exampleViewController)
            default:
                break
            }
        case 2: //Animation
            switch indexPath.row {
            case 0: //3.1 Slide animation for present and dismiss
                self.currentlyShowedAlertController = ExampleProvider.slideAnimation(showedViewController: exampleViewController)
            case 1: //3.2 Slide animation with rotation
                self.currentlyShowedAlertController = ExampleProvider.slideAnimationWithDefaultRotation(showedViewController: exampleViewController)
            case 2: //3.3 Slide animation with rotation angle
                self.currentlyShowedAlertController = ExampleProvider.slideAnimationWithCustomRotation(showedViewController: exampleViewController)
            case 3: //3.4 Final rotation angle
                self.currentlyShowedAlertController = ExampleProvider.finalRotationAngle(showedViewController: exampleViewController)
            default:
                break
            }
        default:
            break
        }
        self.currentlyShowedAlertController?.show(presenter: self)
    }
}

extension ViewController: ExampleViewControllerDelegate {
    func exampleButtonTapped(exampleViewController: ExampleViewController) {
        self.currentlyShowedAlertController?.dismiss()
    }
}
