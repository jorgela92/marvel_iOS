//
//  ParentViewController.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 29/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

class ParentViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

//MARK: - public methods -
extension ParentViewController {
    func dismissKeyBoard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        view.addGestureRecognizer(tapGesture)
    }
    
    func openSearchList(delegate: SearchCharactersViewControllerCallback) {
        guard let navigationController = navigationController as? ParentNavigationController else { return }
        navigationController.openSearchList(delegate: delegate)
    }
    
    func openCharacterDetail(_ characterId: Int, _ title: String) {
        guard let navigationController = navigationController as? ParentNavigationController else { return }
        navigationController.openCharacterDetail(characterId, title)
    }
    
    func openUrl(url: String, title: String) {
        guard let navigationController = navigationController as? ParentNavigationController else { return }
        navigationController.openUrl(url: url, title: title)
    }
}

//MARK: - private methods -
private extension ParentViewController {
    func configureUI() {
        view.backgroundColor = Color.colorPrivateBackgraund
        tableView.separatorStyle = .none
        tableView.backgroundColor = Color.colorPrivateBackgraund
    }
    
    @objc func endEditing() {
        view.endEditing(true)
    }
}

