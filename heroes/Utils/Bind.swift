//
//  Bind.swift
//  heroes
//
//  Created by Manuel Alejandro Cebey on 27/2/22.
//

import Foundation

final class Binding<T> {
  typealias Listener = (T) -> Void
  var listener: Listener?

  var value: T {
    didSet {
      listener?(value)
    }
  }

  init(_ value: T) {
    self.value = value
  }

  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
