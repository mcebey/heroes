//
//  CharacterModel.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 25/2/22.
//

import Foundation

struct CharacterModel {
   let id: Int
   let name: String
   let description: String
   let thumbnail: URL?

   init(from response: CharacterResponse) {
        id = response.id
        name = response.name
        description = response.description
        thumbnail = URL(string: "\(response.thumbnail.path).\(response.thumbnail.ext)")
    }
}
