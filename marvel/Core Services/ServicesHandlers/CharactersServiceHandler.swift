//
//  CharactersServiceHandler.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 28/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

protocol CharactersServiceHandlerProtocol {
    func getCharacters(nameStartsWith: String?, offset: String?, limit: String?, completion: @escaping (ResultResponse<CharactersModel?>) -> ())
    func getDetailCharacter(characterId: Int, completion: @escaping (ResultResponse<CharactersModel?>) -> ())
}

final class CharactersServiceHandler: BaseServiceHandler {
    fileprivate let baseServiceUrl = "characters"
}

//MARK: - CharactersServiceHandlerProtocol
extension CharactersServiceHandler: CharactersServiceHandlerProtocol {
    func getCharacters(nameStartsWith: String? = nil, offset: String? = nil, limit: String? = nil, completion: @escaping (ResultResponse<CharactersModel?>) -> ()) {
        ConnectionsManager.shared.request(getUrl(nameStartsWith: nameStartsWith, offset: offset, limit: limit), method: .get) { (result) in
            switch result {
            case .success(let data):
                guard let characters = CharactersModel.getModelFrom(data) else {
                    completion(ResultResponse.error(ErrorModel.getErrorModel(data) ?? ErrorModel(code: "", message: "generic_error".localized)))
                    return
                }
                completion(ResultResponse.success(characters))
                break
                
            case .error(let error):
                completion(ResultResponse.error(error))
                break
            }
        }
    }
    
    func getDetailCharacter(characterId: Int, completion: @escaping (ResultResponse<CharactersModel?>) -> ()) {
        ConnectionsManager.shared.request(getUrl(characterId: characterId), method: .get) { (result) in
            switch result {
            case .success(let data):
                guard let characters = CharactersModel.getModelFrom(data) else {
                    completion(ResultResponse.error(ErrorModel.getErrorModel(data) ?? ErrorModel(code: "", message: "generic_error".localized)))
                    return
                }
                completion(ResultResponse.success(characters))
                break
                
            case .error(let error):
                completion(ResultResponse.error(error))
                break
            }
        }
    }
}

//MARK: - private methods -
private extension CharactersServiceHandler {
    func getUrl(nameStartsWith: String? = nil, offset: String? = nil, limit: String? = nil, characterId: Int? = nil) -> String {
        return getBaseUrl(baseServiceUrl + getPathURL(characterId) + getParameters(nameStartsWith: nameStartsWith, offset: offset, limit: limit))
    }
    
    func getPathURL(_ characterId: Int?) -> String {
        guard let characterIdS = characterId  else { return "" }
        return "/\(characterIdS)"
    }
}

