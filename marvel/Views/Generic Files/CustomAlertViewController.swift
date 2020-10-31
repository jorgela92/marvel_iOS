//
//  CustomAlertViewController.swift
//  GitHub
//
//  Created by Jorge Lapeña Antón on 28/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit
import Lottie

protocol CustomAlertViewDelegate: class {
    func leftAlertButtonClicked(tag: Int)
    func rightAlertButtonClicked(tag: Int)
}

public final class CustomAlertViewController: UIViewController {

    @IBOutlet weak var shadowView: UIView! {
        didSet {
            shadowView.backgroundColor = Color.colorShadowViewSearch
        }
    }
    @IBOutlet fileprivate weak var containerView: RounedContainerView! {
        didSet {
            containerView.backgroundColor = UIColor.white
        }
    }
    @IBOutlet fileprivate weak var topImageView: UIImageView!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var leftButton: RounedButton! {
        didSet {
            leftButton.borderColor = Color.colorTextRed
            leftButton.backgroundColor = UIColor.clear
        }
    }
    @IBOutlet fileprivate weak var rightButton: RounedButton! {
        didSet {
            rightButton.borderColor = Color.colorTextRed
            rightButton.backgroundColor = Color.colorTextRed
        }
    }
    @IBOutlet fileprivate weak var topToContainerTitleConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var leadingToContainerRightButtonConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var trailingToContainerLeftButtonConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var trailingRightButtonConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var leadingLeftButtonConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var titleSeparatorView: UIView!
    
    fileprivate var imageViewName: String?
    fileprivate var animationName: String?
    fileprivate var titleText: String?
    fileprivate var descriptionText: String?
    fileprivate var leftButtonTitle: String?
    fileprivate var rightButtonTitle: String?
    fileprivate var alertTag = 0
    
    fileprivate var animator: Transition? = Transition()
    
    weak var delegate: CustomAlertViewDelegate?

    init(imageViewName: String?, animationName: String?, titleText: String?, descriptionText: String?, leftButtonTitle: String?, rightButtonTitle: String?, alertTag: Int = 0) {
        self.imageViewName = imageViewName
        self.animationName = animationName
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.leftButtonTitle = leftButtonTitle
        self.rightButtonTitle = rightButtonTitle
        self.alertTag = alertTag
        animator?.animationType = .peekAndPop
        super.init(nibName: String(describing: CustomAlertViewController.self), bundle: nil)
        self.transitioningDelegate = animator
        self.modalPresentationStyle = .custom
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func leftButtonAction(_ sender: Any) {
        delegate?.leftAlertButtonClicked(tag: alertTag)
        dismiss(animated: true)
    }
    
    @IBAction func rightButtonAction(_ sender: Any) {
        delegate?.rightAlertButtonClicked(tag: alertTag)
    }
}

//MARK: - private methods -
private extension CustomAlertViewController {
    func setup() {
        if let imageViewName = imageViewName {
            topImageView.image = UIImage(named: imageViewName)
        } else if let animationName = animationName {
            animationView.animation = Animation.named(animationName)
            animationView.loopMode = .loop
            animationView.contentMode = .scaleAspectFit
            animationView.play()
        } else {
            topImageView.isHidden = true
            topToContainerTitleConstraint.priority = UILayoutPriority(rawValue: 999)
        }
        
        if let titleText = titleText {
            titleLabel.text = titleText
        } else {
            titleLabel.text = ""
            titleSeparatorView.isHidden = true
        }
        
        if let descriptionText = descriptionText {
            descriptionLabel.text = descriptionText
        } else {
            descriptionLabel.text = ""
        }
        
        if let leftButtonTitle = leftButtonTitle {
            leftButton.setTitle(leftButtonTitle, for: .normal)
        } else {
            leftButton.isHidden = true
            trailingRightButtonConstraint.constant = 70.0
            leadingToContainerRightButtonConstraint.priority = UILayoutPriority(rawValue: 999)
        }
        
        if let rightButtonTitle = rightButtonTitle {
            rightButton.setTitle(rightButtonTitle, for: .normal)
        } else {
            rightButton.isHidden = true
            leadingLeftButtonConstraint.constant = 70.0
            trailingToContainerLeftButtonConstraint.priority = UILayoutPriority(rawValue: 999)
        }
        view.layoutIfNeeded()
    }
}
