//
//  HeaderBodyCell.swift
//  Marvel
//
//  Created by Jorge Lapeña Antón on 30/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

class HeaderBodyCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var shadowView: UIView! {
        didSet {
            shadowView.backgroundColor = Color.colorShadowView
            shadowView.addRoundCornersView(corners: [UIRectCorner.topLeft, UIRectCorner.topRight], radius: 10.0)
        }
    }
    
    @IBOutlet fileprivate weak var borderView: UIView! {
        didSet {
            borderView.backgroundColor = Color.colorBorderView
            borderView.addRoundCornersView(corners: [UIRectCorner.topLeft, UIRectCorner.topRight], radius: 10.0)
        }
    }
    
    @IBOutlet fileprivate weak var containerView: UIView! {
        didSet {
            containerView.backgroundColor = Color.colorContainerView
            containerView.addRoundCornersView(corners: [UIRectCorner.topLeft, UIRectCorner.topRight], radius: 10.0)
        }
    }
}
