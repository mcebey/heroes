//
//  GetCharacterInteractor.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 27/2/22.
//

import Foundation
import Resolver

/// @mockable
protocol GetCharacterInteractorProtocol {
    func execute(id: Int, completion: @escaping (Character?, BaseUrlApi.ApiError?) -> Void)
}

struct GetCharacterInteractor: GetCharacterInteractorProtocol {
    @Injected var datasource: MarvelCharactersDatasourceProtocol

    func execute(id: Int, completion: @escaping (Character?, BaseUrlApi.ApiError?) -> Void)  {
        return datasource.getCharacter(id: id) { data, error in
            if error != nil {
                completion(nil, error)
            }

            guard let data = data else {
                completion(nil, error)
                return
            }

            let result = Character(from: data)
            completion(result, error)
        }
    }
}
