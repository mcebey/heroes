//
//  ComicResponse.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 25/2/22.
//

import Foundation

struct ComicsResponse: Codable {
    let available: String
    let returned: String
    let collectionUri: String
    let items: [ComicsItemResponse]
}
