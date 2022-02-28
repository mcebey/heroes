//
//  MarvelCharactersDatasource.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 25/2/22.
//

import Foundation
import Resolver

/// @mockable
protocol MarvelCharactersDatasourceProtocol {
    func getCharacters(page: Int, elements: Int, completion: @escaping ([CharacterModel]?, BaseUrlApi.ApiError?) -> Void)
    func getCharacter(id: Int, completion: @escaping (CharacterModel?, BaseUrlApi.ApiError?) -> Void)
}

class  MarvelCharactersDatasource: MarvelCharactersDatasourceProtocol {
    @LazyInjected var service: MarvelApiServiceProtocol

    func getCharacters(page: Int, elements: Int, completion: @escaping ([CharacterModel]?, BaseUrlApi.ApiError?) -> Void) {
        service.getCharacters(page: page, elements: elements) { data, error in
            if error != nil {
                completion(nil, error)
                return
            }

            guard let results = data?.data.results.map(CharacterModel.init) else {
                completion(nil, error)
                return
            }

            completion(results, nil)
        }
    }

    func getCharacter(id: Int, completion: @escaping (CharacterModel?, BaseUrlApi.ApiError?) -> Void) {
        service.getCharacter(id: id) { data, error in
            if error != nil {
                completion(nil, error)
                return
            }

            guard let result = data?.data.results.first else {
                completion(nil, error)
                return
            }

            completion(CharacterModel(from: result), nil)
        }
    }


}

