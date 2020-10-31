//
//  ViewController.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 28/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import RxSwift
import Kingfisher
import Lottie

class CharactersListViewController: ParentViewController {
    
    fileprivate let charactersViewModel: CharactersViewModel = CharactersViewModel()
    fileprivate var alert: CustomAlertViewController?
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
}

//MARK: - private methods -
private extension CharactersListViewController {
    func configureUI() {
        tableView.accessibilityIdentifier = "listTableView"
        tableView.register(UINib(nibName: String(describing: SearchViewHeader.self), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing: SearchViewHeader.self))
        tableView.register(UINib(nibName: String(describing: CharacterTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CharacterTableViewCell.self))
        tableView.register(UINib(nibName: String(describing: LoadingTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LoadingTableViewCell.self))
        ConnectionsManager.shared.showHUD()
    }
    
    func getSearchViewHeader() -> UIView? {
        let view: SearchViewHeader  = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: SearchViewHeader.self)) as! SearchViewHeader
        view.searchButton.addTarget(self, action: #selector(selectSearch), for: .touchUpInside)
        if charactersViewModel.isSearch() {
            view.searchLabel.text = charactersViewModel.searchText
            view.imageSearch.image = UIImage(named: "close")
        } else {
            view.searchLabel.text = "search".localized.capitalized
            view.imageSearch.image = UIImage(named: "search")
        }
        return view
    }
    
    @objc func selectSearch() {
        if charactersViewModel.isSearch() {
            charactersViewModel.closeSearch()
            tableView.reloadData()
        } else {
           openSearchList(delegate: self)
        }
    }
    
    func getLoadingTableViewCell(indexPath: IndexPath) -> LoadingTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LoadingTableViewCell.self), for: indexPath) as! LoadingTableViewCell
        cell.selectionStyle = .none
        charactersViewModel.fetchDataListCharacters()
            .subscribe(
                onError: {[weak self] (error) in
                    ConnectionsManager.shared.hideHUD()
                    guard let weakself = self, let error = error as? ErrorModel else { return }
                    weakself.alert = CustomAlertViewController(imageViewName: nil, animationName: "error_animation", titleText: "error".localized.uppercased(), descriptionText: error.message, leftButtonTitle: nil, rightButtonTitle: "accept".localized.uppercased())
                    weakself.alert?.delegate = self
                    weakself.present(weakself.alert!, animated: true)
                    weakself.tableView.reloadData()
                }, onCompleted: { [weak self] in
                    ConnectionsManager.shared.hideHUD()
                    guard let weakself = self else { return }
                    weakself.tableView.reloadData()
                }).disposed(by: disposeBag)
        return cell
    }
    
    
    
    func getCharacterTableViewCell(indexPath: IndexPath) -> CharacterTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharacterTableViewCell.self), for: indexPath) as! CharacterTableViewCell
        cell.selectionStyle = .none
        cell.characterName.text = charactersViewModel.getNameOfCharacters(index: indexPath.row) ?? ""
        guard let url = URL(string: charactersViewModel.getURLImage(index: indexPath.row)) else {
            cell.characterImage.isHidden = false
            cell.characterIndicator.stop()
            cell.characterIndicator.isHidden = true
            cell.characterImage.image = UIImage(named: "marvelSplash")?.resized(to: cell.characterImage.bounds.size)
            return cell
        }
        cell.characterImage.kf.setImage(
            with: url,
            placeholder: UIImage(),
            options: [
                .cacheOriginalImage
            ], completionHandler:
                { result in
                    switch result {
                    case .success(let value):
                        cell.characterImage.isHidden = false
                        cell.characterIndicator.stop()
                        cell.characterIndicator.isHidden = true
                        cell.characterImage.image = value.image.resized(to: cell.characterImage.bounds.size)
                    case .failure(_):
                        cell.characterImage.isHidden = false
                        cell.characterIndicator.stop()
                        cell.characterIndicator.isHidden = true
                        cell.characterImage.image = UIImage(named: "marvelSplash")?.resized(to: cell.characterImage.bounds.size)
                    }
                })
        return cell
    }
}

//MARK: - UITableViewDataSource
extension CharactersListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 110
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return getSearchViewHeader()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersViewModel.getNumberOfCharacters() ?? 0 + (charactersViewModel.isPagination() ? 1 : 0)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == ((charactersViewModel.getNumberOfCharacters() ?? 0) - 1) && charactersViewModel.isPagination() {
            return getLoadingTableViewCell(indexPath: indexPath)
        }
        if -1 == ((charactersViewModel.getNumberOfCharacters() ?? 0) - 1) && charactersViewModel.isPagination() {
            return getLoadingTableViewCell(indexPath: indexPath)
        }
        return getCharacterTableViewCell(indexPath: indexPath)
    }
}

//MARK: - UITableViewDelegate
extension CharactersListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ConnectionsManager.shared.showHUD()
        openCharacterDetail(charactersViewModel.getIdOfCharacters(index: indexPath.row), charactersViewModel.getNameOfCharacters(index: indexPath.row) ?? "")
    }
}


//MARK: - SearchCharactersViewControllerCallback
extension CharactersListViewController: SearchCharactersViewControllerCallback {
    func search(text: String) {
        charactersViewModel.searchText = text
        tableView.reloadData()
        
    }
}

//MARK: - SearchCharactersViewControllerCallback
extension CharactersListViewController: CustomAlertViewDelegate {
    func leftAlertButtonClicked(tag: Int) {
        
    }
    
    func rightAlertButtonClicked(tag: Int) {
        alert?.dismiss(animated: true)
        alert = nil
        if charactersViewModel.isSearch() {
            charactersViewModel.closeSearch()
            tableView.reloadData()
        }
    }
}
