//
//  ParentNavigationController.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 29/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import UIKit

class ParentNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
    }
}

//MARK: - public methods -
extension ParentNavigationController {
    func openSearchList(delegate: SearchCharactersViewControllerCallback) {
        let searchCharactersViewController = SearchCharactersViewController.loadFromNib()
        searchCharactersViewController.delegate = delegate
        present(searchCharactersViewController, animated: true)
    }
    
    func openCharacterDetail(_ characterId: Int, _ title: String) {
        let characterDetailTableViewController = CharacterDetailTableViewController.loadFromNib()
        characterDetailTableViewController.title = title
        characterDetailTableViewController.initVM(characterId: characterId)
        pushViewController(characterDetailTableViewController, animated: true)
    }
    
    func openUrl(url: String, title: String) {
        let webViewController = WebViewController.loadFromNib()
        webViewController.title = title
        webViewController.loadUrl(url)
        pushViewController(webViewController, animated: true)
    }
}

//MARK: - private methods -
private extension ParentNavigationController {
    func configureNavigationController() {
        delegate = self
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        navigationBar.barStyle = .black
        navigationBar.tintColor = .white
        navigationBar.barTintColor = Color.colorNavigationBar
        navigationBar.isTranslucent = false
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        interactivePopGestureRecognizer?.delegate = self
        let defaultNavigationBarFrame = CGRect(x: 0, y: 0, width: Screen.width, height: navigationBar.frame.height + Screen.height)
        navigationBar.frame = defaultNavigationBarFrame
    }
    
    func configureNavigationItems(viewController: UIViewController) {
        guard viewController.navigationItem.title == nil && viewController.navigationItem.titleView == nil else { return }
        let image = UIImage(named: "marvelSplash")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: imageView.frame.origin.x, y: imageView.frame.origin.y, width: navigationBar.bounds.width, height: navigationBar.bounds.height)
        viewController.navigationItem.titleView = imageView
    }
    
    func backButtonItem() -> UIBarButtonItem {
        let button = UIButton()
        button.accessibilityIdentifier = "backArrow"
        button.setImage(UIImage(named: "ic_back_arrow"), for: .normal)
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 45, height: 40)
        buttonImageInstets(buttonName: button)
        button.widthAnchor.constraint(equalToConstant: 45).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return UIBarButtonItem(customView: button)
    }
    
    func buttonItem() -> UIBarButtonItem {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 45, height: 40)
        buttonImageInstets(buttonName: button)
        button.widthAnchor.constraint(equalToConstant: 45).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return UIBarButtonItem(customView: button)
    }
    
    @objc func backAction() {
        popViewController(animated: true)
    }
    
    func buttonImageInstets(buttonName: UIButton) {
        buttonName.imageEdgeInsets.bottom = 8
        buttonName.imageEdgeInsets.left = 8
        buttonName.imageEdgeInsets.top = 8
        buttonName.imageEdgeInsets.right = 8
    }
}

//MARK: - UINavigationControllerDelegate
extension ParentNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.modalPresentationStyle = .fullScreen
        if viewController is CharactersListViewController {
            viewController.navigationItem.leftBarButtonItem = buttonItem()
        } else {
            viewController.navigationItem.leftBarButtonItem = backButtonItem()
        }
        viewController.navigationItem.rightBarButtonItem = buttonItem()
        configureNavigationItems(viewController: viewController)
    }
}
