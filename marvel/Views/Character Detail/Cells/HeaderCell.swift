//
//  HeaderCell.swift
//  Marvel
//
//  Created by Jorge Lapeña Antón on 30/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewCell {
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
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = Color.colorTextRed
        }
    }
    @IBOutlet weak var detailLabel: UILabel!
}
