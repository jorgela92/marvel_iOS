//
//  ErrorModel.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 28/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Foundation

//MARK: - ErrorModel
struct ErrorModel: Error, Decodable {
    let code: String
    let message: String
    
    init(code: String, message: String) {
        self.code = code
        self.message = message
    }
}

//MARK: - public methods -
extension ErrorModel {
    static func getErrorModel(_ dataResponse: Data) -> ErrorModel? {
        do {
            guard let jsonDict = try JSONSerialization.jsonObject(with: dataResponse) as? NSDictionary else { return nil }
            var codeS = ""
            var messageS = ""
            if let code = jsonDict["code"] as? String {
                codeS = code
            }
            if let code = jsonDict["code"] as? Int {
                codeS = "\(code)"
            }
            if let message = jsonDict["message"] as? String {
                messageS = message
            }
            if let message = jsonDict["status"] as? String {
                messageS = message
            }
            return ErrorModel(code: codeS, message: messageS)
        } catch {
            return nil
        }
    }
}
