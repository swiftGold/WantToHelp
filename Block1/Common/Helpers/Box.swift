//
//  Box.swift
//  Block1
//
//  Created by Сергей Золотухин on 09.07.2023.
//

final class Box<T> {
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
