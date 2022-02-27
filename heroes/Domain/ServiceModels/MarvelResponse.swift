//
//  CharactersResponse.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 25/2/22.
//

import Foundation

struct MarvelResponse<T: Codable>: Codable {
    let code: Int
    let status: String
    let data: DataClassResponse<T>
}

