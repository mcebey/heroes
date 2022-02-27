//
//  CharacterListViewModel.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 25/2/22.
//

import Foundation
import Resolver

/// @mockable
protocol CharacterListViewModelProtocol {
    var list: [Character] { get }
    var refresh: Binding<Bool> { get set }
    var isLoading: Binding<Bool> { get }
    var error: Binding<String?> { get }

    func send(action: CharacterListViewModel.ViewActions)
}

class CharacterListViewModel: CharacterListViewModelProtocol {
    @Injected var getCharatersInteractor: GetCharactersInteractorProtocol
    var list: [Character] = []
    var refresh = Binding<Bool>(false)
    var isLoading = Binding<Bool>(false)
    var page = 0
    let elements = 20
    var error = Binding<String?>(nil)

    func send(action: ViewActions) {
        processAction(action)
    }
}

extension CharacterListViewModel {
    private func getError(error: BaseUrlApi.ApiError) -> String {
        switch error {
        case .decoded:
            return "Mensaje mal formado"
        default:
            return "Problema de red"
        }
    }

    private func fetchData() {
        processState(.loading)
        getCharatersInteractor.execute(page: page, elements: elements) { data, error in
            if let error = error  {
                self.error.value = self.getError(error: error)
            }

            self.list += data ?? []
            self.page += 1
            self.processState(.loaded)
        }
    }
}

extension CharacterListViewModel {
    func processAction(_ action: ViewActions) {
        switch action {
        case .fetchData:
            fetchData()
        }
    }
}

extension CharacterListViewModel {
    func processState(_ action: ViewStates) {
        switch action {
        case .idle:
            isLoading.value = true
        case .loading:
            isLoading.value = true
        case .loaded:
            refresh.value = true
            isLoading.value = false
        }
    }
}

extension CharacterListViewModel {
    enum ViewActions {
        case fetchData
    }
}

extension CharacterListViewModel {
    enum ViewStates {
        case idle
        case loading
        case loaded
    }
}
