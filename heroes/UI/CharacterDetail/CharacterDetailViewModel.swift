//
//  CharacterDetailViewModel.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 27/2/22.
//

import Foundation
import Resolver

/// @mockable
protocol CharacterDetailViewModelProtocol {
    var character: Character? { get }
    var refresh: () -> Void { get set }
    var isLoading: (Bool) -> Void { get set }

    func send(action: CharacterDetailViewModel.ViewActions)
}

class CharacterDetailViewModel: CharacterDetailViewModelProtocol {
    @Injected var getCharacterInteractor: GetCharacterInteractorProtocol
    var character: Character?

    var refresh: () -> Void = { () -> () in }
    var isLoading: (Bool) -> Void = { _ in }

    func send(action: ViewActions) {
        processAction(action)
    }
}

extension CharacterDetailViewModel {
    private func fetchData(id: Int) {
        processState(.loading)
        getCharacterInteractor.execute(id: id) { data, error in
            if error == nil {
                // process error
            }

            self.character = data
            self.processState(.loaded)
        }
    }
}

extension CharacterDetailViewModel {
    func processAction(_ action: ViewActions) {
        switch action {
        case .fetchData(let id):
            fetchData(id: id)
        }
    }
}

extension CharacterDetailViewModel {
    func processState(_ action: ViewStates) {
        switch action {
        case .idle:
            isLoading(true)
        case .loading:
            isLoading(true)
        case .loaded:
            refresh()
            isLoading(false)
        }
    }
}

extension CharacterDetailViewModel {
    enum ViewActions {
        case fetchData(Int)
    }
}

extension CharacterDetailViewModel {
    enum ViewStates {
        case idle
        case loading
        case loaded
    }
}
