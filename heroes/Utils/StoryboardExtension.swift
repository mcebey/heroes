//
//  StoryboardExtension.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 26/2/22.
//

import Foundation
import UIKit

protocol StoryboardProtocol {
    static func getInstance() -> Self
}

extension StoryboardProtocol where Self: UIViewController {
    static func getInstance() -> Self {
        let name = NSStringFromClass(self)
        let className = name.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
