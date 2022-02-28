//
//  MarvelApiService.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 25/2/22.
//

import Foundation
import Resolver

/// @mockable
protocol MarvelApiServiceProtocol {
    func getCharacters(page: Int, elements: Int, completion: @escaping (MarvelResponse<[CharacterResponse]>?, BaseUrlApi.ApiError?) -> Void)
    func getCharacter(id: Int, completion: @escaping (MarvelResponse<[CharacterResponse]>?, BaseUrlApi.ApiError?) -> Void)
}

class MarvelApiService: MarvelApiServiceProtocol {
    let api = BaseUrlApi()

    func getCharacters(page: Int, elements: Int, completion: @escaping (MarvelResponse<[CharacterResponse]>?, BaseUrlApi.ApiError?) -> Void) {
        api.call(url: Endpoint.characters(page, elements).url) { (data: MarvelResponse?, error: BaseUrlApi.ApiError?) in
            completion(data, error)
        }
    }

    func getCharacter(id: Int, completion: @escaping (MarvelResponse<[CharacterResponse]>?, BaseUrlApi.ApiError?) -> Void) {
        api.call(url: Endpoint.character(id).url) { (data: MarvelResponse?, error: BaseUrlApi.ApiError?) in
            completion(data, error)
        }
    }
}

// MARK: Enum Endpoints
extension MarvelApiService {
    enum Endpoint {
        case characters(Int, Int)
        case character(Int)
    }
}

// MARK: URL
extension MarvelApiService.Endpoint {
    var url: URLComponents? {
         var urlComponents = URLComponents()
        urlComponents.scheme = Constants.Marvel.scheme
        urlComponents.host   = Constants.Marvel.host
        urlComponents.path   = "\( Constants.Marvel.path)\(self.path)"
        urlComponents.queryItems = params

        return urlComponents
    }
}

// MARK: Paths
extension MarvelApiService.Endpoint {
    private var path: String {
        switch self {
        case .characters:
            return "/v1/public/characters"
        case .character(let heroeId):
            return "/v1/public/characters/\(heroeId)"
        }
    }
}

// MARK: Params
extension MarvelApiService.Endpoint {
    private var initialParams: [URLQueryItem] {
        let ts = String(NSDate().timeIntervalSince1970)
        return [
            .init(name: "apikey", value: Constants.Marvel.apiKey),
            .init(name: "hash", value: (ts + Constants.Marvel.privateKey + Constants.Marvel.apiKey).md5),
            .init(name: "ts", value: ts)
        ]

    }
    private var params: [URLQueryItem] {
        switch self {
        case .characters(let page, let elements):
            let custom : [URLQueryItem] = [
                .init(name: "offset", value: String(page * elements)),
                .init(name: "limit", value: String(elements))
            ]

            return initialParams + custom
        case .character(_):
            return initialParams

        }
    }
}
