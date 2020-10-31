//
//  HUDView.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 28/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Lottie

class HUDView: UIVisualEffectView {
    
    fileprivate var text: String? {
        didSet {
            label.text = text
        }
    }
    var activityIndicator: AnimationView = AnimationView(name: "loading_animation") {
        didSet {
            activityIndicator.backgroundColor = UIColor.clear
            activityIndicator.contentMode = .scaleAspectFit
        }
    }
    var label: UILabel = UILabel()
    fileprivate let blurEffect = UIBlurEffect(style: .light)
    fileprivate let vibrancyView: UIVisualEffectView
    
    fileprivate let WIDTH_STRING_EMPTY: CGFloat = 100
    fileprivate let HEIGHT_STRING_EMPTY: CGFloat = 100
    fileprivate let HEIGHT_STRING_FULL: CGFloat = 100
    fileprivate let MULTIPLIER_NSLAYOUT_CONSTRAINT: CGFloat = 1
    fileprivate let CONSTANT_NSLAYOUT_CONSTRAINT: CGFloat = 0
    fileprivate let ACTIVITY_INDICATOR_SIZE: CGFloat = 85
    fileprivate let CORENR_RADIUS: CGFloat = 8

    init(text: String) {
        self.text = text
        self.vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        self.setup()
        isHidden = false
    }
    
    init() {
        text = ""
        vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(effect: blurEffect)
        setup()
        isHidden = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = ""
        vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(coder: aDecoder)
        setup()
        isHidden = false
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        configureUI()
    }
}

//MARK: - public methods -
extension HUDView {
    func hide() {
        activityIndicator.stop()
        self.removeFromSuperview()
    }
}

//MARK: - private methods -
private extension HUDView {
    func configureUI() {
        accessibilityIdentifier = "HUD"
        if let superview = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            if text == "" {
                NSLayoutConstraint.activate([
                    NSLayoutConstraint.init(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: HEIGHT_STRING_EMPTY),
                    NSLayoutConstraint.init(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: WIDTH_STRING_EMPTY)
                ])
                NSLayoutConstraint.activate([
                    NSLayoutConstraint.init(item: activityIndicator, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: CONSTANT_NSLAYOUT_CONSTRAINT),
                    NSLayoutConstraint.init(item: self, attribute: .centerY, relatedBy: .equal, toItem: activityIndicator, attribute: .centerY, multiplier: MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: CONSTANT_NSLAYOUT_CONSTRAINT)
                ])
            } else {
                NSLayoutConstraint.activate([
                    NSLayoutConstraint.init(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: HEIGHT_STRING_FULL)
                ])
                NSLayoutConstraint.activate([
                    NSLayoutConstraint.init(item: self, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: CONSTANT_NSLAYOUT_CONSTRAINT)
                ])
                
                NSLayoutConstraint.activate([
                    NSLayoutConstraint.init(item: self, attribute: .top, relatedBy: .equal, toItem: activityIndicator, attribute: .top, multiplier: MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: CONSTANT_NSLAYOUT_CONSTRAINT)
                ])

                NSLayoutConstraint.activate([
                    NSLayoutConstraint.init(item: label, attribute: .top, relatedBy: .equal, toItem: activityIndicator, attribute: .bottom, multiplier: MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: -10),
                    NSLayoutConstraint.init(item: label, attribute: .centerX, relatedBy: .equal, toItem: activityIndicator, attribute: .centerX, multiplier: MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: CONSTANT_NSLAYOUT_CONSTRAINT)
                ])
                NSLayoutConstraint.activate([
                    NSLayoutConstraint.init(item: label, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: 15),
                    NSLayoutConstraint.init(item: self, attribute: .trailing, relatedBy: .equal, toItem: label, attribute: .trailing, multiplier: MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: 15)
                ])
                NSLayoutConstraint.activate([
                    NSLayoutConstraint.init(item: label, attribute: .width, relatedBy: .lessThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: superview.frame.width / 1.5)
                ])
                
                label.text = text
                label.textAlignment = NSTextAlignment.center
                label.numberOfLines = 1
            }
            
            NSLayoutConstraint.activate([
                NSLayoutConstraint.init(item: self, attribute: .centerX, relatedBy: .equal, toItem: superview, attribute: .centerX, multiplier: MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: CONSTANT_NSLAYOUT_CONSTRAINT),
                NSLayoutConstraint.init(item: superview, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: CONSTANT_NSLAYOUT_CONSTRAINT)
            ])
            vibrancyView.frame = self.bounds
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                NSLayoutConstraint.init(item: activityIndicator, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: ACTIVITY_INDICATOR_SIZE),
                NSLayoutConstraint.init(item: activityIndicator, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: MULTIPLIER_NSLAYOUT_CONSTRAINT, constant: ACTIVITY_INDICATOR_SIZE)
            ])
            layer.cornerRadius = CORENR_RADIUS
            layer.masksToBounds = true
            layer.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.25).cgColor
            
        }
    }
    
    func setup() {
        if text != "" {
            contentView.addSubview(label)
        }
        contentView.addSubview(vibrancyView)
        activityIndicator.loopMode = .loop
        activityIndicator.play()
        contentView.addSubview(activityIndicator)
    }
}
