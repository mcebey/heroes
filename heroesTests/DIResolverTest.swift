//
//  ResolverTest.swift
//  heroesTests
//
//  Created by Manuel Alejandro Cebey on 27/2/22.
//

import Foundation
import Resolver
@testable import heroes

extension Resolver {

    static var test: Resolver!

    static func resetTestRegistrations() {
        Resolver.test = Resolver(child: .main)
        Resolver.root = Resolver.test
    }


}


//class DIResolverTest {
//    var mock = Resolver(parent: .main)
//
//    init() {
//        //Resolver.reset()
//        Resolver.root = mock
//        Resolver.defaultScope = .application
//        registerMockServices()
//    }
//
//    func reset() {
//       // Resolver.reset()
//    }
//
//    func registerServices() {
//        Resolver.register(MarvelApiServiceProtocol.self) { MarvelApiService() }.scope(.application)
//    }
//
//    func registerDataSources() {
//        Resolver.register(MarvelCharactersDatasourceProtocol.self) { MarvelCharactersDatasource() }
//    }
//
//    func registerInteractors() {
//        Resolver.register(GetCharactersInteractorProtocol.self) { GetCharactersInteractor() }
//        Resolver.register(GetCharacterInteractorProtocol.self) { GetCharacterInteractor() }
//    }
//
//    func registerViewModels() {
//        Resolver.register(CharacterListViewModelProtocol.self) { CharacterListViewModel() }
//        Resolver.register(CharacterDetailViewModelProtocol.self) { CharacterDetailViewModel() }
//    }
//
//    func registerMockServices() {
//        mock.register(MarvelApiServiceProtocol.self) { MarvelApiServiceProtocolMock() }.scope(.application)
//    }
//
//    func registerMockDataSources() {
//        mock.register(MarvelCharactersDatasourceProtocol.self) { MarvelCharactersDatasourceProtocolMock() }
//    }
//
//    func registerMockInteractors() {
//        mock.register(GetCharactersInteractorProtocol.self) { GetCharactersInteractorProtocolMock() }
//        mock.register(GetCharacterInteractorProtocol.self) { GetCharacterInteractorProtocolMock() }
//    }
//
//    private func registerMockViewModels() {
//        mock.register(CharacterListViewModelProtocol.self) { CharacterListViewModelProtocolMock() }
//        mock.register(CharacterDetailViewModelProtocol.self) { CharacterDetailViewModelProtocolMock() }
//    }
//}
