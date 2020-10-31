//
//  LoadingTableViewCell.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 28/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Lottie

class LoadingTableViewCell: UITableViewCell {
    @IBOutlet weak var activityIndicator: AnimationView! {
        didSet {
            activityIndicator.backgroundColor = UIColor.clear
            activityIndicator.animation = Animation.named("loading_animation")
            activityIndicator.loopMode = .loop
            activityIndicator.contentMode = .scaleAspectFit
            activityIndicator.play()
        }
    }
}
