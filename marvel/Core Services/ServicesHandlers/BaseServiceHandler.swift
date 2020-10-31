//
//  BaseServiceHandler.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 28/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Foundation
import CommonCrypto

//MARK: - ResultResponse
enum ResultResponse<T> {
    case success(T)
    case error(ErrorModel)
}

//MARK: - BaseServiceHandler
class BaseServiceHandler {
    fileprivate let baseUrlDEV = "https://gateway.marvel.com/v1/public/"
    fileprivate let apikey = "8b32f2fc7c43f1f44399784d59fb3e4b"
    fileprivate let privateApikey = "20000c5ccd6c0ea2823e04977bfd9304f91dab9d"
}

//MARK: - public methods -
extension BaseServiceHandler {
    func getBaseUrl(_ path: String) -> String {
        return baseUrlDEV + path
    }
    
    func getParameters(nameStartsWith: String?, offset: String?, limit: String?) -> String {
        let ts = getTS()
        return "?apikey=" + apikey + "&ts=" + ts + "&hash=" + getHash(ts) + (nameStartsWith != nil ? ("&nameStartsWith=" + nameStartsWith!) : "") + (offset != nil ? ("&offset=" + offset!) : "") + (limit != nil ? ("&limit=" + limit!) : "")
    }
}

//MARK: - private methods -
private extension BaseServiceHandler {
    func getTS() -> String {
        return String(Date().timeIntervalSince1970 * 1000000)
    }
    
    func getHash(_ ts: String) -> String {
        return md5(ts + privateApikey + apikey)
    }
    
    func md5(_ string: String) -> String {
        let length = Int(CommonCrypto.CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData.map {
                String(format: "%02hhx", $0)
            }.joined()
    }
}
