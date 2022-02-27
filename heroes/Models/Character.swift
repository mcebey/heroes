//
//  Character.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 25/2/22.
//

import Foundation

struct Character {
    let id: Int
    let name: String
    let description: String
    let thumbnail: URL?

    init(from model: CharacterModel) {
        id = model.id
        name = model.name
        description = model.description
        thumbnail = model.thumbnail
    }
}
