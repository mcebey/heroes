//
//  BaseViewController.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 26/2/22.
//

import Foundation
import UIKit


class BaseViewController: UIViewController, StoryboardProtocol {
    private let activityView = UIActivityIndicatorView(style: .large)
    var router: MainRouter?

//    init() {
//        if let navctl = self.navigationController {
//            router = MainRouter(navigationController: navctl)
//        }
//    }

    func showError(msg: String) {
        let alert = UIAlertController(title: "ERROR", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in }))
        self.present(alert, animated: true, completion: nil)
    }

    func showActivity(_ value: Bool) {
        value ? showActivityIndicator() : hideActivityIndicator()
    }

    fileprivate func showActivityIndicator() {
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }

    fileprivate func hideActivityIndicator() {
        activityView.stopAnimating()
        activityView.removeFromSuperview()
    }
}
