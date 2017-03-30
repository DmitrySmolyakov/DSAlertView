//
//  DSAlertController.swift
//  Pods
//
//  Created by Dmitry Smolyakov on 3/30/17.
//
//

import UIKit
import SnapKit

public class DSAlertController: UIViewController {
    
    let showedViewController: UIViewController
    
    let presentionAnimation = DSPresentationAnimation()
    let dismissAnimation = DSDismissAnimation()
    
    var widthMultiplier: Double = 1
    var heightMultiplier: Double = 1
    
    public init(showedViewController: UIViewController, widthMultiplier: Double = 1, heightMultiplier: Double = 1) {
        self.showedViewController = showedViewController
        self.widthMultiplier = widthMultiplier
        self.heightMultiplier = heightMultiplier
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let contentView = UIView()
        contentView.layer.cornerRadius = 25
        contentView.clipsToBounds = true
        self.view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.snp.center)
            make.width.equalTo(self.view).multipliedBy(widthMultiplier)
            make.height.equalTo(self.view).multipliedBy(heightMultiplier)
        }
        
        self.addChildViewController(showedViewController)
        contentView.addSubview(showedViewController.view)
        showedViewController.view.snp.makeConstraints { (make) in
            make.center.equalTo(contentView.snp.center)
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(contentView.snp.height)
        }
        self.showedViewController.didMove(toParentViewController: self)
    }
    
    public func show(presenter: UIViewController) {
        self.transitioningDelegate = self
        self.modalPresentationStyle = .overFullScreen
        presenter.present(self, animated: true, completion: nil)
    }
}

extension DSAlertController {
    
    public static func showViewController(presenter: UIViewController, showedViewController: UIViewController) {
        let viewController = DSAlertController(showedViewController: showedViewController)
        viewController.show(presenter: presenter)
    }
}

extension DSAlertController: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentionAnimation
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimation
    }
}
