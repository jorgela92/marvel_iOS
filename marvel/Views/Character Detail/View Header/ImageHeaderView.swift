//
//  ImageHeaderView.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 30/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit
import Lottie

class ImageHeaderView: UITableViewHeaderFooterView {
    @IBOutlet fileprivate weak var shadowView: RounedShadowView! {
        didSet {
            shadowView.backgroundColor = Color.colorShadowView
        }
    }
    
    @IBOutlet fileprivate weak var borderView: RounedBorderView! {
        didSet {
            borderView.backgroundColor = Color.colorBorderView
        }
    }
    
    @IBOutlet fileprivate weak var containerView: RounedContainerView! {
        didSet {
            containerView.backgroundColor = Color.colorContainerView
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var animationView: AnimationView! {
        didSet {
            animationView.animation = Animation.named("loading_animation")
            animationView.loopMode = .loop
            animationView.contentMode = .scaleAspectFit
            animationView.play()
        }
    }
    
    override func awakeFromNib() {
        backgroundView = UIView()
        backgroundView?.backgroundColor = UIColor.clear
    }
}
