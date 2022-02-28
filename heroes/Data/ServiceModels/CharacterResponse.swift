//
//  CharacterResponse.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 25/2/22.
//

import Foundation

struct CharacterResponse: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: ThumbnailResponse
}
