//
//  CharacterTableViewCell.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 29/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Lottie

class CharacterTableViewCell: UITableViewCell {
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
    @IBOutlet weak var characterImage: UIImageView! {
        didSet {
            characterImage.layer.cornerRadius = 10
            characterImage.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var characterIndicator: AnimationView! {
        didSet {
            characterIndicator.animation = Animation.named("loading_animation")
            characterIndicator.loopMode = .loop
            characterIndicator.isUserInteractionEnabled = false
            characterIndicator.contentMode = .scaleAspectFit
            characterIndicator.play()
        }
    }
    @IBOutlet weak var characterName: UILabel! {
        didSet {
            characterName.textColor = Color.colorTextRed
        }
    }
}
