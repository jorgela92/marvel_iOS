//
//  SearchCharactersViewController.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 30/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

protocol SearchCharactersViewControllerCallback: AnyObject {
    func search(text: String)
}

class SearchCharactersViewController: UIViewController {

    @IBOutlet fileprivate weak var shadowButton: UIButton! {
        didSet {
            shadowButton.backgroundColor = Color.colorShadowViewSearch
            shadowButton.addTarget(self, action: #selector(closeSearch), for: .touchUpInside)
        }
    }
    
    @IBOutlet fileprivate weak var containerView: RounedContainerView! {
        didSet {
            containerView.background = Color.colorContainerView
        }
    }
    @IBOutlet fileprivate weak var searchByLabel: UILabel! {
        didSet {
            searchByLabel.text = "search_title".localized
            searchByLabel.textColor = Color.colorTextRed
        }
    }
    @IBOutlet fileprivate weak var searchTextField: RounedTextField!
    @IBOutlet fileprivate weak var cancelSearchButton: RounedButton! {
        didSet {
            cancelSearchButton.backgroundColor = UIColor.clear
            cancelSearchButton.borderColor = Color.colorTextRed
            cancelSearchButton.setTitleColor(Color.colorTextRed, for: .normal)
            cancelSearchButton.setTitle("cancel".localized.uppercased(), for: .normal)
            cancelSearchButton.addTarget(self, action: #selector(closeSearch), for: .touchUpInside)
        }
    }
    @IBOutlet fileprivate weak var acceptSearchButton: RounedButton! {
        didSet {
            acceptSearchButton.backgroundColor = Color.colorTextRed
            acceptSearchButton.borderColor = Color.colorTextRed
            acceptSearchButton.setTitleColor(UIColor.white, for: .normal)
            acceptSearchButton.setTitle("accept".localized.uppercased(), for: .normal)
            
        }
    }
    
    weak var delegate: SearchCharactersViewControllerCallback?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction fileprivate func searchAction(_ sender: Any) {
        guard let text = searchTextField.text else { return }
        delegate?.search(text: text)
        closeSearch()
    }
}

//MARK: - private methods -
private extension SearchCharactersViewController {
    @objc func closeSearch() {
        dismiss(animated: true, completion: nil)
    }
}


