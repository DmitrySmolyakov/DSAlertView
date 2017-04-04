//
//  DSAlertController.swift
//  Pods
//
//  Created by Dmitry Smolyakov on 3/30/17.
//
//

import UIKit
import SnapKit

open class DSAlertController: UIViewController, DSTransitionAnimation {
    
    let showedViewController: UIViewController
    lazy open var contentView: UIView = {
        let tempContentView = UIView()
        tempContentView.clipsToBounds = true
        tempContentView.layer.cornerRadius = self.cornerRadius
        return tempContentView
    }()
    
    lazy open var backgroundView: UIView = {
        let tempBackgroundView = UIView()
        tempBackgroundView.backgroundColor = self.backgroundColor
        tempBackgroundView.alpha = self.backgroundViewAlpha
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.onBackViewTap))
        tempBackgroundView.addGestureRecognizer(tap)
        return tempBackgroundView
    }()
    
    lazy open var closeButton: UIButton = {
        let tempCloseButton = UIButton(type: .custom)
        tempCloseButton.tintColor = self.closeButtonTintColor
        tempCloseButton.isHidden = self.closeButtonIsHidden
        tempCloseButton.setImage(self.getImageFromBundle(name: "closeButton").withRenderingMode(.alwaysTemplate), for: .normal)
        tempCloseButton.addTarget(self, action: #selector(self.closeButtonTapped), for: .touchUpInside)
        return tempCloseButton
    }()
    
    lazy var presentationAnimation: DSPresentationAnimation = {
        return DSFadePresentationAnimation()
    }()
    lazy var dismissingAnimation: DSDismissAnimation = {
        return DSFadeDismissAnimation()
    }()
    
    // Content view size
    private struct ContentSizeConstraints {
        var widthMultiplier: Bool
        var heightMultiplier: Bool
        var centerMultiplier: Bool
    }
    private var contentSizeConstraints = ContentSizeConstraints(widthMultiplier: true,
                                                                heightMultiplier: true,
                                                                centerMultiplier: true)
    open var widthMultiplier: Double = 0.7 {
        didSet {
            contentSizeConstraints.widthMultiplier = true
            remakeConstraintsForContentView()
        }
    }
    open var width: CGFloat = 250 {
        didSet {
            contentSizeConstraints.widthMultiplier = false
            remakeConstraintsForContentView()
        }
    }
    open var heightMultiplier: Double = 0.6 {
        didSet {
            contentSizeConstraints.heightMultiplier = true
            remakeConstraintsForContentView()
        }
    }
    open var height: CGFloat = 300 {
        didSet {
            contentSizeConstraints.heightMultiplier = false
            remakeConstraintsForContentView()
        }
    }
    
    //Content view position
    open var finalPositionRotationAngle: CGFloat?
    open var centerMultiplierX: Double = 1 {
        didSet {
            contentSizeConstraints.centerMultiplier = true
            remakeConstraintsForContentView()
        }
    }
    open var centerOffsetX: CGFloat = 0 {
        didSet {
            contentSizeConstraints.centerMultiplier = false
            remakeConstraintsForContentView()
        }
    }
    open var centerMultiplierY: Double = 1 {
        didSet {
            contentSizeConstraints.centerMultiplier = true
            remakeConstraintsForContentView()
        }
    }
    open var centerOffsetY: CGFloat = 0 {
        didSet {
            contentSizeConstraints.centerMultiplier = false
            remakeConstraintsForContentView()
        }
    }
    
    //Setup content view border
    open var cornerRadius: CGFloat = 25 {
        didSet {
            contentView.layer.cornerRadius = cornerRadius
        }
    }
    open var borderWidth: CGFloat = 0 {
        didSet {
            contentView.layer.borderWidth = borderWidth
        }
    }
    open var borderColor: UIColor = .black {
        didSet {
            contentView.layer.borderColor = borderColor.cgColor
        }
    }
    
    //Background view setup
    open var backgroundColor: UIColor = .black {
        didSet {
            backgroundView.backgroundColor = backgroundColor
        }
    }
    open var backgroundViewAlpha: CGFloat = 0.6 {
        didSet {
            backgroundView.alpha = backgroundViewAlpha
        }
    }
    open var backgroundViewIsHidden = false {
        didSet {
            backgroundView.alpha = backgroundViewIsHidden ? 0 : backgroundViewAlpha
        }
    }
    open var hideByTapIsOn: Bool = true
    
    
    //Close button setup
    open var closeButtonIsHidden: Bool = true {
        didSet {
            closeButton.isHidden = closeButtonIsHidden
        }
    }
    open var closeButtonTintColor: UIColor = .black {
        didSet {
            closeButton.tintColor = closeButtonTintColor
        }
    }
    
    //animation setup
    open var presentAnimationDuration: Double = 0.5
    open var presentAnimationRotationAngle: CGFloat?
    
    open var dismissAnimationDuration: Double = 0.25
    open var dismissAnimationRotationAngle: CGFloat?
    
    open var presentAnimation: Animation = .fade {
        didSet {
            switch presentAnimation {
            case .slide(let direction, let rotation):
                self.presentationAnimation = DSSlidePresentationAnimation(direction: direction, rotation: rotation)
                self.presentationAnimation.delegate = self
            case .fade:
                self.presentationAnimation = DSFadePresentationAnimation()
                self.presentationAnimation.delegate = self
            }
        }
    }
    open var dismissAnimation: Animation = .fade {
        didSet {
            switch dismissAnimation {
            case .slide(let direction, let rotation):
                self.dismissingAnimation = DSSlideDismissAnimation(direction: direction, rotation: rotation)
                self.dismissingAnimation.delegate = self
            case .fade:
                self.dismissingAnimation = DSFadeDismissAnimation()
                self.presentationAnimation.delegate = self
            }
        }
    }
    
    // MARK: Initialization
    public init(showedViewController: UIViewController, widthMultiplier: Double = 1, heightMultiplier: Double = 1) {
        self.showedViewController = showedViewController
        self.widthMultiplier = widthMultiplier
        self.heightMultiplier = heightMultiplier
        super.init(nibName: nil, bundle: nil)
    }
    
    public init(showedViewController: UIViewController) {
        self.showedViewController = showedViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: LifeCycle
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(backgroundView)
        self.backgroundView.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.height.equalTo(self.view)
            make.width.equalTo(self.view)
        }
        
        self.view.addSubview(self.contentView)
        self.remakeConstraintsForContentView()
        
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
    
    // MARK: Actions
    dynamic private func onBackViewTap() {
        if hideByTapIsOn {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    dynamic private func closeButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Helpers
    private func getImageFromBundle(name: String) -> UIImage {
        let podBundle = Bundle(for: DSAlertController.self)
        return UIImage(named: name, in: podBundle, compatibleWith: nil)!
    }

    private func remakeConstraintsForContentView() {
        self.contentView.snp.remakeConstraints { (make) in
            if contentSizeConstraints.widthMultiplier {
                make.width.equalTo(self.view).multipliedBy(widthMultiplier)
            } else {
                make.width.equalTo(width)
            }
            if contentSizeConstraints.heightMultiplier {
                make.height.equalTo(self.view).multipliedBy(heightMultiplier)
            } else {
                make.height.equalTo(height)
            }
            if contentSizeConstraints.centerMultiplier {
                make.centerX.equalTo(self.view.snp.centerX).multipliedBy(centerMultiplierX)
            } else {
                make.centerX.equalTo(self.view.snp.centerX).offset(centerOffsetX)
            }
            if contentSizeConstraints.centerMultiplier {
                make.centerY.equalTo(self.view.snp.centerY).multipliedBy(centerMultiplierY)
            } else {
                make.centerY.equalTo(self.view.snp.centerY).offset(centerOffsetY)
            }
        }
    }
}

// MARK: DSPresentationAnimationDelegate
extension DSAlertController: DSPresentationAnimationDelegate {
    func durationForPresentationAnimation() -> Double {
        return presentAnimationDuration
    }
    
    func rotationAngleForPresentAnimation() -> CGFloat? {
        return presentAnimationRotationAngle
    }
    
    func contentFinalRotationAngleForPresentAnimation() -> CGFloat? {
        return finalPositionRotationAngle
    }
}

// MARK: DSDismissAnimationDelegate
extension DSAlertController: DSDismissAnimationDelegate {
    func durationForDismissAnimation() -> Double {
        return dismissAnimationDuration
    }
    
    func rotationAngleForDismissAnimation() -> CGFloat? {
        return dismissAnimationRotationAngle
    }
}

// MARK: Presenting methods
extension DSAlertController {
    open static func showViewController(presenter: UIViewController, showedViewController: UIViewController) {
        let viewController = DSAlertController(showedViewController: showedViewController)
        viewController.show(presenter: presenter)
    }
    
    open func show(presenter: UIViewController) {
        self.transitioningDelegate = self
        self.modalPresentationStyle = .overFullScreen
        presenter.present(self, animated: true, completion: nil)
    }
    
    open func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: UIViewControllerTransitioningDelegate
extension DSAlertController: UIViewControllerTransitioningDelegate {
    open func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentationAnimation
    }
    
    open func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissingAnimation
    }
}
