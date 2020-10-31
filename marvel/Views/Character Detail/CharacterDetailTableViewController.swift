//
//  CharacterDetailTableViewController.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 29/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Kingfisher
import RxSwift

class CharacterDetailTableViewController: ParentViewController {
    
    fileprivate let characterDetailViewModel: CharacterDetailViewModel = CharacterDetailViewModel()
    fileprivate var alert: CustomAlertViewController?
    fileprivate let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

//MARK: - public methods -
extension CharacterDetailTableViewController {
    func initVM(characterId: Int) {
        characterDetailViewModel
            .fetchDataDetailCharacter(characterId: characterId)
            .subscribe(
            onError: {[weak self] (error) in
                ConnectionsManager.shared.hideHUD()
                guard let weakself = self, let error = error as? ErrorModel else { return }
                weakself.alert = CustomAlertViewController(imageViewName: nil, animationName: "error_animation", titleText: "error".localized.uppercased(), descriptionText: error.message, leftButtonTitle: nil, rightButtonTitle: "accept".localized.uppercased())
                weakself.alert?.delegate = self
                weakself.present(weakself.alert!, animated: true)
            }, onCompleted: { [weak self] in
                ConnectionsManager.shared.hideHUD()
                guard let weakself = self else { return }
                weakself.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
}

//MARK: - private methods -
private extension CharacterDetailTableViewController {
    func configureUI() {
        tableView.register(UINib(nibName: String(describing: ImageHeaderView.self), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing: ImageHeaderView.self))
        tableView.register(UINib(nibName: String(describing: SectionView.self), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing: SectionView.self))
        tableView.register(UINib(nibName: String(describing: HeaderCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HeaderCell.self))
        tableView.register(UINib(nibName: String(describing: HeaderBodyCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HeaderBodyCell.self))
        tableView.register(UINib(nibName: String(describing: BodyCell.self), bundle: nil), forCellReuseIdentifier: String(describing: BodyCell.self))
        tableView.register(UINib(nibName: String(describing: FooterCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FooterCell.self))
        tableView.register(UINib(nibName: String(describing: UniqueCell.self), bundle: nil), forCellReuseIdentifier: String(describing: UniqueCell.self))
    }
    
    func getImageHeaderView() -> UIView {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ImageHeaderView.self)) as! ImageHeaderView
        guard let url = URL(string: characterDetailViewModel.getURLImage()) else {
            view.animationView.stop()
            view.animationView.isHidden = true
            view.imageView.isHidden = false
            view.imageView.image = UIImage(named: "marvelSplash")?.resized(to: view.imageView.bounds.size)
            return view
        }
        view.imageView.kf.setImage(
            with: url,
            placeholder: UIImage(),
            options: [
                .cacheOriginalImage
            ], completionHandler:
                { result in
                    switch result {
                    case .success(let value):
                        view.animationView.stop()
                        view.animationView.isHidden = true
                        view.imageView.isHidden = false
                        view.imageView.image = value.image.resized(to: view.imageView.bounds.size)
                    case .failure(_):
                        view.animationView.stop()
                        view.animationView.isHidden = true
                        view.imageView.isHidden = false
                        view.imageView.image = UIImage(named: "marvelSplash")?.resized(to: view.imageView.bounds.size)
                    }
                })
        return view
    }
    
    func getSectionView(section: Int) -> UIView {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: SectionView.self)) as! SectionView
        var title = ""
        switch TypeSection.allCases[section] {
        case .COMICS:
            title = "comics".localized.uppercased()
            view.accessibilityIdentifier = "comics"
            break
        case .SERIES:
            title = "series".localized.uppercased()
            view.accessibilityIdentifier = "series"
            break
        case .STORIES:
            title = "stories".localized.uppercased()
            view.accessibilityIdentifier = "stories"
            break
        case .EVENTS:
            title = "events".localized.uppercased()
            view.accessibilityIdentifier = "events"
            break
        case .URLS:
            title = "urls".localized.uppercased()
            view.accessibilityIdentifier = "urls"
            break
        case .HEADER:
            break
        }
        view.tag = section
        view.delegate = self
        view.titleLabel.text = title
        if characterDetailViewModel.getArrowDirection(TypeSection.allCases[section]) {
            view.arrowImage.image = UIImage(named: "arrowTop")
        } else {
            view.arrowImage.image = UIImage(named: "arrowButton")
        }
        return view
    }
    
    func getHeaderCell(indexPath: IndexPath) -> HeaderCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
        cell.selectionStyle = .none
        if let detailDescription = characterDetailViewModel.getDescriptionDetail(), !"".elementsEqual(detailDescription) {
            cell.detailLabel.attributedText = detailDescription.htmlToAttributedString
        } else {
            cell.detailLabel.text = ""
        }
        cell.titleLabel.text = characterDetailViewModel.getNameDetail()
        cell.selectionStyle = .none
        return cell
    }
    
    func getHeaderBodyCell(indexPath: IndexPath) -> HeaderBodyCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeaderBodyCell.self), for: indexPath) as! HeaderBodyCell
        cell.titleLabel.text = getTitleCell(indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func getBodyCell(indexPath: IndexPath) -> BodyCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BodyCell.self), for: indexPath) as! BodyCell
        cell.titleLabel.text = getTitleCell(indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func getFooterCell(indexPath: IndexPath) -> FooterCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FooterCell.self), for: indexPath) as! FooterCell
        cell.titleLabel.text = getTitleCell(indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func getUniqueCell(indexPath: IndexPath) -> UniqueCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UniqueCell.self), for: indexPath) as! UniqueCell
        cell.titleLabel.text = getTitleCell(indexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }
    
    func getTitleCell(indexPath: IndexPath) -> String? {
        switch TypeSection.allCases[indexPath.section] {
        case .COMICS:
            return characterDetailViewModel.getTitleOfComics(indexRow: indexPath.row)
        case .SERIES:
            return characterDetailViewModel.getTitleOfSeries(indexRow: indexPath.row)
        case .STORIES:
            return characterDetailViewModel.getTitleOfStories(indexRow: indexPath.row)
        case .EVENTS:
            return characterDetailViewModel.getTitleOfEvents(indexRow: indexPath.row)
        case .URLS:
            return characterDetailViewModel.getTitleOfUrls(indexRow: indexPath.row)?.capitalized
        case.HEADER:
            return ""
        }
    }
}

// MARK: - UITableViewDataSource
extension CharacterDetailTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TypeSection.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TypeSection.allCases[section] {
        case .HEADER:
            return 1
        case .COMICS:
            return characterDetailViewModel.getNumberOfComics() ?? 0
        case .SERIES:
            return characterDetailViewModel.getNumberOfSeries() ?? 0
        case .STORIES:
            return characterDetailViewModel.getNumberOfStories() ?? 0
        case .EVENTS:
            return characterDetailViewModel.getNumberOfEvents() ?? 0
        case .URLS:
            return characterDetailViewModel.getNumberOfUrls() ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch TypeSection.allCases[indexPath.section] {
        case .HEADER:
            return getHeaderCell(indexPath: indexPath)
        case .COMICS:
            if characterDetailViewModel.getNumberOfComics() ?? 0 == 1 {
                return getUniqueCell(indexPath: indexPath)
            } else {
                switch indexPath.row {
                    case (characterDetailViewModel.getNumberOfComics() ?? 0) - 1:
                        return getFooterCell(indexPath: indexPath)
                    case 0:
                        return getHeaderBodyCell(indexPath: indexPath)
                    default:
                        return getBodyCell(indexPath: indexPath)
                }
            }
            
        case .SERIES:
            if characterDetailViewModel.getNumberOfSeries() ?? 0 == 1 {
                return getUniqueCell(indexPath: indexPath)
            } else {
                switch indexPath.row {
                    case (characterDetailViewModel.getNumberOfSeries() ?? 0) - 1:
                        return getFooterCell(indexPath: indexPath)
                    case 0:
                        return getHeaderBodyCell(indexPath: indexPath)
                    default:
                        return getBodyCell(indexPath: indexPath)
                }
            }
        case .STORIES:
            if characterDetailViewModel.getNumberOfStories() ?? 0 == 1 {
                return getUniqueCell(indexPath: indexPath)
            } else {
                switch indexPath.row {
                    case (characterDetailViewModel.getNumberOfStories() ?? 0) - 1:
                        return getFooterCell(indexPath: indexPath)
                    case 0:
                        return getHeaderBodyCell(indexPath: indexPath)
                    default:
                        return getBodyCell(indexPath: indexPath)
                }
            }
        case .EVENTS:
            if characterDetailViewModel.getNumberOfEvents() ?? 0 == 1 {
                return getUniqueCell(indexPath: indexPath)
            } else {
                switch indexPath.row {
                    case (characterDetailViewModel.getNumberOfEvents() ?? 0) - 1:
                        return getFooterCell(indexPath: indexPath)
                    case 0:
                        return getHeaderBodyCell(indexPath: indexPath)
                    default:
                        return getBodyCell(indexPath: indexPath)
                }
            }
        case .URLS:
            if characterDetailViewModel.getNumberOfUrls() ?? 0 == 1 {
                let cell = getUniqueCell(indexPath: indexPath)
                cell.accessibilityIdentifier = "url1"
                return cell
            } else {
                switch indexPath.row {
                    case (characterDetailViewModel.getNumberOfUrls() ?? 0) - 1:
                        return getFooterCell(indexPath: indexPath)
                    case 0:
                        let cell = getHeaderBodyCell(indexPath: indexPath)
                        cell.accessibilityIdentifier = "url1"
                        return cell
                    default:
                        return getBodyCell(indexPath: indexPath)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch TypeSection.allCases[section] {
        case .COMICS, .SERIES, .STORIES, .EVENTS, .URLS:
            return getSectionView(section: section)
        case .HEADER:
            return getImageHeaderView()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch TypeSection.allCases[section] {
        case .COMICS, .SERIES, .STORIES, .EVENTS, .URLS:
            return 80
        case .HEADER:
            return 250
        }
    }
}

// MARK: - UITableViewDelegate
extension CharacterDetailTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch TypeSection.allCases[indexPath.section] {
        case .URLS:
            openUrl(url: characterDetailViewModel.getUrlOfUrls(indexRow: indexPath.row) ?? "", title: characterDetailViewModel.getTitleOfUrls(indexRow: indexPath.row)?.uppercased() ?? "")
                break
        default:
            break
        }
        
    }
}

// MARK: - ProductHeaderSectionTitleViewDelegate
extension CharacterDetailTableViewController: SectionViewDelegate {
    func arrowClicked(section: Int) {
        switch TypeSection.allCases[section] {
        case .HEADER:
            break
        case .COMICS:
            guard characterDetailViewModel.getCountComics() ?? 0 != 0 else { return }
            characterDetailViewModel.arrowClicked(.COMICS)
            break
        case .SERIES:
            guard characterDetailViewModel.getCountSeries() ?? 0 != 0 else { return }
            characterDetailViewModel.arrowClicked(.SERIES)
            break
        case .STORIES:
            guard characterDetailViewModel.getCountStories() ?? 0 != 0 else { return }
            characterDetailViewModel.arrowClicked(.STORIES)
            break
        case .EVENTS:
            guard characterDetailViewModel.getCountEvents() ?? 0 != 0 else { return }
            characterDetailViewModel.arrowClicked(.EVENTS)
            break
        case .URLS:
            guard characterDetailViewModel.getCountUrls() ?? 0 != 0 else { return }
            characterDetailViewModel.arrowClicked(.URLS)
            break
        }
        tableView.reloadSections([section], with: .automatic)
    }
}

extension CharacterDetailTableViewController: CustomAlertViewDelegate {
    func leftAlertButtonClicked(tag: Int) {
        
    }
    
    func rightAlertButtonClicked(tag: Int) {
        alert?.dismiss(animated: true, completion: { [weak self] in
            guard let weakself = self else { return }
            weakself.dismiss(animated: true)
        })
    }
}
