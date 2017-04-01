//
//  DSAlertController.swift
//  Pods
//
//  Created by Dmitry Smolyakov on 3/30/17.
//
//

import UIKit
import SnapKit

public class DSAlertController: UIViewController, DSTransitionAnimation {
    
    public var presentAnimationDuration: Double = 0.5
    public var presentAnimationRotationAngle: CGFloat?
    public var finalRotationAngle: CGFloat?
    
    public var dismissAnimationDuration: Double = 0.25
    public var dismissAnimationRotationAngle: CGFloat?
    
    public var presentAnimation: Animation = .slide(direction: .top, rotation: false) {
        didSet {
            switch presentAnimation {
            case .slide(let direction, let rotation):
                self.presentationAnimation = DSSlidePresentationAnimation(direction: direction, rotation: rotation)
                self.presentationAnimation.delegate = self
            case .fade:
                break
            }
        }
    }
    public var dismissAnimation: Animation = .slide(direction: .bottom, rotation: false) {
        didSet {
            switch dismissAnimation {
            case .slide(let direction, let rotation):
                self.dismissingAnimation = DSSlideDismissAnimation(direction: direction, rotation: rotation)
                self.dismissingAnimation.delegate = self
            case .fade:
                break
            }
        }
    }
    
    let showedViewController: UIViewController
    lazy var contentView: UIView = {
        let tempContentView = UIView()
        tempContentView.clipsToBounds = true
        tempContentView.layer.cornerRadius = self.cornerRadius
        return tempContentView
    }()
    
    lazy var backgroundView: UIView = {
        let tempBackgroundView = UIView()
        tempBackgroundView.backgroundColor = .black
        tempBackgroundView.alpha = self.backgroundViewAlpha
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onBackViewTap))
        tempBackgroundView.addGestureRecognizer(tap)
        return tempBackgroundView
    }()
    
    lazy public var closeButton: UIButton = {
        let tempCloseButton = UIButton()
        tempCloseButton.tintColor = .black
        tempCloseButton.setImage(self.getImageFromBundle(name: "closeButton").withRenderingMode(.alwaysTemplate), for: .normal)
        tempCloseButton.addTarget(self, action: #selector(self.closeButtonTapped), for: .touchUpInside)
        return tempCloseButton
    }()
    
    lazy var presentationAnimation: DSPresentationAnimation = {
        return DSSlidePresentationAnimation(direction: .top, rotation: false)
    }()
    lazy var dismissingAnimation: DSDismissAnimation = {
        return DSDismissAnimation()
    }()
    
    public var widthMultiplier: Double = 1
    public var heightMultiplier: Double = 1
    public var cornerRadius: CGFloat = 25 {
        didSet {
            contentView.layer.cornerRadius = cornerRadius
        }
    }
    public var borderWidth: CGFloat = 0 {
        didSet {
            contentView.layer.borderWidth = borderWidth
        }
    }
    public var borderColor: UIColor = .black {
        didSet {
            contentView.layer.borderColor = borderColor.cgColor
        }
    }
    public var backgroundColor: UIColor = .black {
        didSet {
            backgroundView.backgroundColor = backgroundColor
        }
    }
    public var backgroundViewAlpha: CGFloat = 0.6 {
        didSet {
            backgroundView.alpha = backgroundViewAlpha
        }
    }
    
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
        
        self.view.addSubview(backgroundView)
        self.backgroundView.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.height.equalTo(self.view)
            make.width.equalTo(self.view)
        }
        
        self.view.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.center.equalTo(self.view.snp.center)
            make.width.equalTo(self.view).multipliedBy(widthMultiplier)
            make.height.equalTo(self.view).multipliedBy(heightMultiplier)
        }
        
        self.addChildViewController(showedViewController)
        self.contentView.addSubview(showedViewController.view)
        showedViewController.view.snp.makeConstraints { (make) in
            make.center.equalTo(self.contentView.snp.center)
            make.width.equalTo(self.contentView.snp.width)
            make.height.equalTo(self.contentView.snp.height)
        }
        self.showedViewController.didMove(toParentViewController: self)
        
        self.contentView.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.top.equalTo(self.contentView).offset(20)
            make.right.equalTo(self.contentView).offset(-20)
        }
    }
    
    public func show(presenter: UIViewController) {
        self.transitioningDelegate = self
        self.modalPresentationStyle = .overFullScreen
        presenter.present(self, animated: true, completion: nil)
    }
    
    dynamic private func onBackViewTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    dynamic private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func getImageFromBundle(name: String) -> UIImage {
        let podBundle = Bundle(for: DSAlertController.self)
        return UIImage(named: name, in: podBundle, compatibleWith: nil)!
    }
}

extension DSAlertController: DSPresentationAnimationDelegate {
    func durationForPresentationAnimation() -> Double {
        return presentAnimationDuration
    }
    
    func rotationAngleForPresentAnimation() -> CGFloat? {
        return presentAnimationRotationAngle
    }
    
    func contentFinalRotationAngleForPresentAnimation() -> CGFloat? {
        return finalRotationAngle
    }
}

extension DSAlertController: DSDismissAnimationDelegate {
    func durationForDismissAnimation() -> Double {
        return dismissAnimationDuration
    }
    
    func rotationAngleForDismissAnimation() -> CGFloat? {
        return dismissAnimationRotationAngle
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
        return presentationAnimation
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissingAnimation
    }
}
