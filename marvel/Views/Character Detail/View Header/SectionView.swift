//
//  SectionView.swift
//  Marvel
//
//  Created by Jorge Lapeña Antón on 30/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

protocol SectionViewDelegate: AnyObject {
    func arrowClicked(section: Int)
}

class SectionView: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = Color.colorTextRed
        }
    }
    @IBOutlet weak var arrowButton: UIButton! {
        didSet {
            arrowButton.accessibilityIdentifier = "arrowButton"
        }
    }
    @IBOutlet weak var arrowImage: UIImageView!
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
    
    weak var delegate: SectionViewDelegate?
    
    override func awakeFromNib() {
        backgroundView = UIView()
        backgroundView?.backgroundColor = UIColor.clear
    }
    
    @IBAction func arrowAction(_ sender: Any) {
        delegate?.arrowClicked(section: tag)
    }
}
