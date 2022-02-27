//
//  CharacterDetailViewController.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 26/2/22.
//

import Foundation
import Resolver
import UIKit
import Kingfisher

class CharacterDetailViewController: BaseViewController {
    @Injected var viewModel: CharacterDetailViewModelProtocol

    var id: Int? = nil

    @IBOutlet weak var charaterName: UILabel!
    @IBOutlet weak var characterImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        getData()
    }

    private func getData() {
        guard let id = id else { return }
        viewModel.send(action: .fetchData(id))
    }

    private func loadImage(url: URL, imageView: UIImageView) {
        let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
                     //|> RoundCornerImageProcessor(cornerRadius: 20)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        { _ in }
    }

    private func bind() {
        viewModel.refresh = {
            self.charaterName.text = self.viewModel.character?.name ?? ""
            if let url = self.viewModel.character?.thumbnail {
                self.loadImage(url: url, imageView: self.characterImage)
            }
        }
    }

}
