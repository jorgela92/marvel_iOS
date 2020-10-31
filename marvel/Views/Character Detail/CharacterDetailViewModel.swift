//
//  CharacterDetailViewModel.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 30/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import RxSwift

enum TypeSection: CaseIterable {
    case HEADER, COMICS, SERIES, STORIES, EVENTS, URLS
}

class CharacterDetailViewModel {
    fileprivate let charactersServiceHandler: CharactersServiceHandler
    fileprivate var detailCharacter: CharactersModel?
    fileprivate var arrowSection = [TypeSection.COMICS : false, TypeSection.SERIES : false, TypeSection.STORIES : false, TypeSection.EVENTS : false, TypeSection.URLS : false]
    var id: String?
    
    init() {
        self.charactersServiceHandler = CharactersServiceHandler()
    }
}

//MARK: - public methods -
extension CharacterDetailViewModel {
    func fetchDataDetailCharacter(characterId: Int) -> Observable<Any?> {
        let disposables = Disposables.create()
        return Observable<Any?>.create { [weak self] observer in
            guard let weakself = self else { return disposables }
            weakself.loadDetailCharacter(characterId: characterId, observer: observer)
            return disposables
        }
    }
    
    func getURLImage() -> String {
        return (detailCharacter?.data.results[0].thumbnail.path ?? "") + "." + (detailCharacter?.data.results[0].thumbnail.thumbnailExtension ?? "")
    }
    
    func getNameDetail() -> String? {
        return detailCharacter?.data.results[0].name
    }
    
    func getDescriptionDetail() -> String? {
        return detailCharacter?.data.results[0].resultDescription
    }
    
    func getNumberOfComics() -> Int? {
        if arrowSection[.COMICS] ?? false {
            return getCountComics()
        } else {
            return 0
        }
    }
    
    func getCountComics() -> Int? {
        return detailCharacter?.data.results[0].comics.items.count
    }
    
    func getTitleOfComics(indexRow: Int) -> String? {
        return detailCharacter?.data.results[0].comics.items[indexRow].name
    }
    
    func getNumberOfSeries() -> Int? {
        if arrowSection[.SERIES] ?? false {
            return getCountSeries()
        } else {
            return 0
        }
    }
    
    func getCountSeries() -> Int? {
        return detailCharacter?.data.results[0].series.items.count
    }
    
    func getTitleOfSeries(indexRow: Int) -> String? {
        return detailCharacter?.data.results[0].series.items[indexRow].name
    }
    
    func getNumberOfStories() -> Int? {
        if arrowSection[.STORIES] ?? false {
            return getCountStories()
        } else {
            return 0
        }
    }
    
    func getCountStories() -> Int? {
        return detailCharacter?.data.results[0].stories.items.count
    }
    
    func getTitleOfStories(indexRow: Int) -> String? {
        return detailCharacter?.data.results[0].stories.items[indexRow].name
    }
    
    func getNumberOfEvents() -> Int? {
        if arrowSection[.EVENTS] ?? false {
            return getCountEvents()
        } else {
            return 0
        }
    }
    
    func getCountEvents() -> Int? {
        return detailCharacter?.data.results[0].events.items.count
    }
    
    func getTitleOfEvents(indexRow: Int) -> String? {
        return detailCharacter?.data.results[0].events.items[indexRow].name
    }
    
    func getNumberOfUrls() -> Int? {
        if arrowSection[.URLS] ?? false {
            return getCountUrls()
        } else {
            return 0
        }
    }
    
    func getCountUrls() -> Int? {
        return detailCharacter?.data.results[0].urls.count
    }
    
    func getTitleOfUrls(indexRow: Int) -> String? {
        return detailCharacter?.data.results[0].urls[indexRow].type
    }
    
    func getUrlOfUrls(indexRow: Int) -> String? {
        return detailCharacter?.data.results[0].urls[indexRow].url
    }
    
    func arrowClicked(_ section: TypeSection) {
        arrowSection[section] = !(arrowSection[section] ?? true)
    }
    
    func getArrowDirection(_ section: TypeSection) -> Bool {
        return arrowSection[section] ?? false
    }
}

//MARK: - private methods -
private extension CharacterDetailViewModel {
    func loadDetailCharacter(characterId: Int, observer: AnyObserver<Any?>) {
        charactersServiceHandler.getDetailCharacter(characterId: characterId) { [weak self] (response) in
               guard let weakself = self else { return }
               switch response {
                   case .success(let detailCharacter):
                        guard let detailCharacter = detailCharacter else { return }
                        weakself.detailCharacter = detailCharacter
                        observer.onCompleted()
                        break
                   case .error(let error):
                        observer.onError(error)
                        break
               }
           }
    }
}
