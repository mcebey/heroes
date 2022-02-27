//
//  ViewController.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 25/2/22.
//

import UIKit
import Resolver

class CharacterListViewController: BaseViewController {
    @Injected var viewModel: CharacterListViewModelProtocol
    
    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        bind()
        getData()
    }

    private func getData() {
        viewModel.send(action: .fetchData)
    }

    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func bind() {

        viewModel.error.bind(listener: { value in
            guard let value = value else { return }
            self.showError(msg: value)
        })

        viewModel.refresh.bind(listener: { value in
            if value {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })

        viewModel.isLoading.bind(listener: { value in
            DispatchQueue.main.async {
                self.showActivity(value)
            }
        })
    }
}

extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = viewModel.list[indexPath.row]
        router?.goToCharacterDetail(id: character.id)
    }
}

extension CharacterListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CharactersCell", for: indexPath) as? CharactersCellView {
            let character = self.viewModel.list[indexPath.row]
            cell.name.text = character.name
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.list.count - 1 {
            viewModel.send(action: .fetchData)
        }
    }
}
