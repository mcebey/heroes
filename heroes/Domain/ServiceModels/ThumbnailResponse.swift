//
//  ThumbnailResponse.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 25/2/22.
//

import Foundation

struct ThumbnailResponse: Codable {
    let path: String
    let ext: String

    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
}
