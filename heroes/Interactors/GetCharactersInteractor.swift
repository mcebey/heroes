//
//  GetCharactersInteractor.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 25/2/22.
//

import Foundation
import Resolver

/// @mockable
protocol GetCharactersInteractorProtocol {
    func execute(page: Int, elements: Int, completion: @escaping ([Character]?, BaseUrlApi.ApiError?) -> Void)
}

struct GetCharactersInteractor: GetCharactersInteractorProtocol {
    @Injected var datasource: MarvelCharactersDatasourceProtocol

    func execute(page: Int, elements: Int, completion: @escaping ([Character]?, BaseUrlApi.ApiError?) -> Void)  {
        return datasource.getCharacters(page: page, elements: elements) { data, error in
            if error != nil {
                completion(nil, error)
            }

            guard let data = data else {
                completion(nil, error)
                return
            }

            let result = data.map(Character.init)
            completion(result, error)
        }
    }
}
