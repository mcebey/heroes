//
//  MainRouter.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 26/2/22.
//

import Foundation
import UIKit

class MainRouter {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func goToCharacterList() {
        let controller = CharacterListViewController.getInstance()
        controller.router = self
        navigationController.pushViewController(controller, animated: false)
    }

    func goToCharacterDetail(id: Int) {
        let controller = CharacterDetailViewController.getInstance()
        controller.router = self
        controller.id = id
        navigationController.pushViewController(controller, animated: false)    }

}
