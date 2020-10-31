//
//  SearchViewHeader.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 30/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

class SearchViewHeader: UITableViewHeaderFooterView {
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
    
    
    @IBOutlet weak var searchLabel: UILabel! {
        didSet {
            searchLabel.textColor = Color.colorTextRed
        }
    }
    
    @IBOutlet weak var imageSearch: UIImageView!
    
    @IBOutlet weak var searchButton: UIButton!
    
    override func awakeFromNib() {
        backgroundView = UIView()
        backgroundView?.backgroundColor = UIColor.clear
    }
}
