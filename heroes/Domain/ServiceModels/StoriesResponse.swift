//
//  StoriesResponse.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 25/2/22.
//

import Foundation

struct StoriesResponse: Codable {
    let available: String
    let returned: String
    let collectionUri: String
    let items: [StoriesItemResponse]

    enum CodingKeys: String, CodingKey {
        case available
        case returned
        case collectionUri
        case items
    }
}
