//
//  BodyCell.swift
//  Marvel
//
//  Created by Jorge Lapeña Antón on 30/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

class BodyCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var shadowView: UIView! {
        didSet {
            shadowView.backgroundColor = Color.colorShadowView
        }
    }
    
    @IBOutlet fileprivate weak var borderView: UIView! {
        didSet {
            borderView.backgroundColor = Color.colorBorderView
        }
    }
    
    @IBOutlet fileprivate weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = Color.colorContainerView
        }
    }
}
