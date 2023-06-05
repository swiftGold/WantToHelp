//
//  String+Extensions.swift
//  Block1
//
//  Created by Сергей Золотухин on 31.05.2023.
//

import Foundation

extension String {
  func firstCharOnly() -> String {
    return prefix(1).uppercased() + self.dropFirst()
  }
}
