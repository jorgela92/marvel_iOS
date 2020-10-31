//
//  CharactersListViewModel.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 29/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import RxSwift

class CharactersViewModel {

    fileprivate let charactersServiceHandler: CharactersServiceHandler
    fileprivate var characters: CharactersModel?
    fileprivate var elementsPagination = 20
    fileprivate var charactersSearch: CharactersModel?
    fileprivate var elementsPaginationSearch = 20
    fileprivate var isErrorCharacters = false
    fileprivate var isErrorCharactersSearch = false
    var searchText: String?
    
    init() {
        self.charactersServiceHandler = CharactersServiceHandler()
    }
}

//MARK: - public methods -
extension CharactersViewModel {
    func fetchDataListCharacters() -> Observable<Any?> {
        let disposables = Disposables.create()
        return Observable<Any?>.create { [weak self] observer in
            guard let weakself = self else { return disposables }
            weakself.loadCharacters(nameStartsWith: weakself.searchText, observer: observer)
            return disposables
        }
    }
    
    func getNumberOfCharacters() -> Int? {
        return isSearch() ? charactersSearch?.data.results.count : characters?.data.results.count
    }
    
    func getNameOfCharacters(index: Int) -> String? {
        return isSearch() ? charactersSearch?.data.results[index].name : characters?.data.results[index].name
    }
    
    func getIdOfCharacters(index: Int) -> Int {
        return isSearch() ? charactersSearch?.data.results[index].id ?? 0 : characters?.data.results[index].id ?? 0
    }
    
    func getURLImage(index: Int) -> String {
        return isSearch() ?
            #"\#(charactersSearch?.data.results[index].thumbnail.path ?? "").\#(charactersSearch?.data.results[index].thumbnail.thumbnailExtension ?? "")"# :
            #"\#(characters?.data.results[index].thumbnail.path ?? "").\#(characters?.data.results[index].thumbnail.thumbnailExtension ?? "")"#
    }
    
    func isPagination() -> Bool {
        if isSearch() {
            guard let charactersSearch = charactersSearch else { return !isErrorCharacters }
            return charactersSearch.data.results.count != charactersSearch.data.total && !isErrorCharacters
        } else {
            guard let characters = characters else { return !isErrorCharactersSearch }
            return characters.data.results.count != characters.data.total && !isErrorCharactersSearch
        }
    }
    
    func isSearch() -> Bool {
        return searchText != nil && !"".elementsEqual(searchText ?? "")
    }
    
    func closeSearch() {
        isErrorCharactersSearch = false
        charactersSearch = nil
        searchText = nil
    }
}

//MARK: - private methods -
private extension CharactersViewModel {
    func loadCharacters(nameStartsWith: String?, observer: AnyObserver<Any?>) {
        charactersServiceHandler.getCharacters(nameStartsWith: nameStartsWith, offset: getOffset(), limit: getLimit()) { [weak self] (response) in
            guard let weakself = self else { return }
            switch response {
                case .success(let characters):
                    if let characters = characters {
                        if weakself.isSearch() {
                            if weakself.charactersSearch == nil {
                                weakself.charactersSearch = characters
                            } else {
                                weakself.charactersSearch?.data.results.append(contentsOf: characters.data.results)
                                weakself.charactersSearch?.data.total = characters.data.total
                                weakself.charactersSearch?.data.count = characters.data.count
                            }
                            weakself.charactersSearch?.data.offset = characters.data.offset + weakself.elementsPaginationSearch
                            weakself.charactersSearch?.data.limit = characters.data.limit + weakself.elementsPaginationSearch
                        } else {
                            if weakself.characters == nil {
                                weakself.characters = characters
                            } else {
                                weakself.characters?.data.results.append(contentsOf: characters.data.results)
                                weakself.characters?.data.total = characters.data.total
                                weakself.characters?.data.count = characters.data.count
                            }
                            weakself.characters?.data.offset = characters.data.offset + weakself.elementsPagination
                            weakself.characters?.data.limit = characters.data.limit + weakself.elementsPagination
                        }
                    }
                    observer.onCompleted()
                    break
                case .error(let error):
                    if weakself.isSearch() {
                        weakself.isErrorCharacters = true
                    } else {
                        weakself.isErrorCharactersSearch = true
                    }
                    observer.onError(error)
                    break
            }
        }
    }
    
    func getOffset() -> String? {
        return isSearch() ? (charactersSearch?.data.offset != nil ? String(charactersSearch?.data.offset ?? 0) : nil) : (characters?.data.offset != nil ? String(characters?.data.offset ?? 0) : nil)
    }
    
    func getLimit() -> String? {
        return isSearch() ? (charactersSearch?.data.limit != nil ? String(charactersSearch?.data.limit ?? 0) : nil) : (characters?.data.limit != nil ? String(characters?.data.limit ?? 0) : nil)
    }
}
