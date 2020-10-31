//
//  CharacterModel.swift
//  marvel
//
//  Created by Jorge Lapeña Antón on 28/10/2020.
//  Copyright © 2020 Jorge Lapeña Antón. All rights reserved.
//

import Foundation

// MARK: - CharactersModel
struct CharactersModel: StructDecodable {
    let code: Int
    let status, copyright, attributionText, attributionHTML, etag: String
    var data: DataClass
}


// MARK: - DataClass
struct DataClass: Decodable {
    var offset, limit, total, count: Int
    var results: [Result]
}

// MARK: - Result
struct Result: Decodable {
    let id: Int
    let name, resultDescription, modified, resourceURI: String
    var description: String?
    let thumbnail: Thumbnail
    let comics, series, events: Comics
    let stories: Stories
    let urls: [URLElement]
    enum CodingKeys: String, CodingKey {
        case id, name, modified, thumbnail, resourceURI, comics, series, stories, events, urls
        case resultDescription = "description"
    }
}

// MARK: - Comics
struct Comics: Decodable {
    let available, returned: Int
    let collectionURI: String
    let items: [ComicsItem]
}

// MARK: - ComicsItem
struct ComicsItem: Decodable {
    let resourceURI, name: String
}

// MARK: - CharactersModel
struct Stories: Decodable {
    let available, returned: Int
    let collectionURI: String
    let items: [StoriesItem]
}

// MARK: - StoriesItem
struct StoriesItem: Decodable {
    let resourceURI, name, type: String
}

// MARK: - Thumbnail
struct Thumbnail: Decodable {
    let path, thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: Decodable {
    let type, url: String
}
