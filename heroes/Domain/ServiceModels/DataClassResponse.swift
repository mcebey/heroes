//
//  DataClassResponse.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 25/2/22.
//

import Foundation

//struct DataClassResponse: Codable {
//    let offset: Int
//    let limit: Int
//    let total: Int
//    let count: Int
//    let results: [CharacterResponse]
//}

struct DataClassResponse<T: Codable>: Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: T
}
