//
//  DI.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 25/2/22.
//

import Foundation
import Resolver

class DIResolver {

    init() {
        registerServices()
        registerDataSources()
        registerInteractors()
        registerViewModels()
    }

    private func registerServices() {
        Resolver.register(MarvelApiServiceProtocol.self) { MarvelApiService() }.scope(.application)
    }

    private func registerDataSources() {
        Resolver.register(MarvelCharactersDatasourceProtocol.self) { MarvelCharactersDatasource() }
    }

    private func registerInteractors() {
        Resolver.register(GetCharactersInteractorProtocol.self) { GetCharactersInteractor() }
        Resolver.register(GetCharacterInteractorProtocol.self) { GetCharacterInteractor() }
    }

    private func registerViewModels() {
        Resolver.register(CharacterListViewModelProtocol.self) { CharacterListViewModel() }
        Resolver.register(CharacterDetailViewModelProtocol.self) { CharacterDetailViewModel() }
    }
}
